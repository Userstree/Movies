//
//  GenresListRequest.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 01.06.2022.
//

import Foundation

protocol GenresListRequest {
    func sendGenresListRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, ErrorResponse>
}

extension GenresListRequest {
    func sendGenresListRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, ErrorResponse>
    {
        let urlString = endpoint.baseURL + endpoint.path 

        guard var urlComponents = URLComponents(string: urlString) else {
            return .failure(.invalidURL)
        }

        var queryItems: [URLQueryItem] = []

        endpoint.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            queryItems.append(urlQueryItem)
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            return .failure(.unknown)
        }

        print(url.absoluteString)

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.header
        request.httpMethod = endpoint.method.rawValue

        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)

            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }

                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
