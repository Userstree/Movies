//
//  HTTPClient.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

protocol MovieInfoRequest {
    func sendMovieInfoRequest<T: Decodable>(endpoint: Endpoint, forMovieWithID: Int?, responseModel: T.Type) async -> Result<T, ErrorResponse>
}

extension MovieInfoRequest {
    func sendMovieInfoRequest<T: Decodable>(endpoint: Endpoint, forMovieWithID: Int? = nil, responseModel: T.Type) async -> Result<T, ErrorResponse>
    {
        var urlString = (endpoint.baseURL + endpoint.path)
        
        if forMovieWithID != nil, let id = forMovieWithID {
            urlString.append("\(id)")
        }
        
        guard var urlComponents = URLComponents(string: urlString) else {
            return .failure(.unknown)
        }
        
        var queryItems: [URLQueryItem] = []
        
        endpoint.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            queryItems.append(urlQueryItem)
        }
        
        urlComponents.queryItems = queryItems

        if forMovieWithID != nil {
            urlComponents.path.append("/credits")
        }

        guard var url = urlComponents.url else {
            return .failure(.unknown)
        }

//        var urlStr = url.absoluteString
//        urlStr.append(endpoint.appendToRequest + "credits")
//        url = URL(string: urlStr)!

        print("url is ", url)

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
                    print("Error happened during decoding")
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

