//
//  HTTPClient.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

protocol DataRequest {
    func sendDataRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, ErrorResponse>
}

extension DataRequest {
    func sendDataRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, ErrorResponse>
    {
        // MARK: REDO THIS
        let urlString = (endpoint.baseURL + endpoint.path)
        
        guard var urlComponent = URLComponents(string: urlString) else {
            return .failure(.unknown)
        }
        
        var queryItems: [URLQueryItem] = []
        
        endpoint.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return .failure(.unknown)
        }

        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.header
        request.httpMethod = endpoint.method.rawValue
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

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

