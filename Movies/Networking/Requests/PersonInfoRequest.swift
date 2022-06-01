//
//  CastRequest.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 28.05.2022.
//

import Foundation

protocol PersonInfoRequest {
    func sendPersonInfoRequest<T: Decodable>(endpoint: Endpoint, personId: Int, responseModel: T.Type) async -> Result<T, ErrorResponse>
}

extension PersonInfoRequest {
    func sendPersonInfoRequest<T: Decodable>(endpoint: Endpoint, personId: Int, responseModel: T.Type) async -> Result<T, ErrorResponse>
    {
        let urlString = endpoint.baseURL + endpoint.path + "/\(personId)"

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
