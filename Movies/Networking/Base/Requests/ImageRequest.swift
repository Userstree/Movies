//
//  ImageRequest.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol ImageRequest {
    func sendImageRequest(endpoint: Endpoint, imagePath: String) async -> Result<UIImage, ErrorResponse>
}

extension ImageRequest {
    func sendImageRequest(endpoint: Endpoint, imagePath: String) async -> Result<UIImage, ErrorResponse>
    {
        guard let url = URL(string: endpoint.baseURL + endpoint.path + imagePath) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                
                guard let image = UIImage(data: data) else {
                    return .failure(.decode)
                }
                
                return .success(image)
                
            case 401:
                return .failure(.unauthorized)
                
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
//    func nonAsyncsendImageRequest(endpoint: Endpoint, imagePath: String, completion: @escaping (UIImage) -> Void) //-> Result<UIImage, ErrorResponse>
//    {
//
//        guard let url = URL(string: endpoint.baseURL + endpoint.path + imagePath) else {
//            print("URL error")
//            return //.failure(.invalidURL)
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = endpoint.method.rawValue
//        request.allHTTPHeaderFields = endpoint.header
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            print("in datatask...")
//            guard let response = response as? HTTPURLResponse else {
//                return
//            }
//
//            guard let data = data else {
//                return
//            }
//
//
//            switch response.statusCode {
//            case 200...299:
//
//                guard let image = UIImage(data: data) else {
//                    return
//                }
//                print("before completion")
//                completion(image)
//
//            case 401:
//                return
//
//            default:
//                return
//            }
//        }.resume()
//    }
}
