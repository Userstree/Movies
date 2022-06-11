//
// Created by Dossymkhan Zhulamanov on 04.06.2022.
//

import UIKit

class BaseRepository {

    var baseURL = "https://api.themoviedb.org/3/"

    var decoder = JSONDecoder()

    private var basePath: String

    init(basePath: String) {
        self.basePath = basePath
    }

    func get<T: Decodable>(_ path: String, queryParams: [String: Any?]? = nil) async -> Result<T, ErrorResponse> {
        let urlString = baseURL + basePath + path

        guard var urlComponents = URLComponents(string: urlString) else {
            return .failure(.invalidURL)
        }

        var queryItems: [URLQueryItem] = []

        queryItems.append(URLQueryItem(name: "api_key", value: "7a9ff9d95f6e5dc76e22f1989c7255d6"))

        queryParams?.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: "\($0.value)")
            queryItems.append(urlQueryItem)
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            return .failure(.unknown)
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json;charset=utf-8"
        ]
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)



            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? decoder.decode(T.self, from: data) else {
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

    func getImage(_ path: String, queryParams: [String: Any?]? = nil) async -> Result<UIImage, ErrorResponse> {
        let urlString = "https://image.tmdb.org/t/p/" + basePath + path

        guard var urlComponents = URLComponents(string: urlString) else {
            return .failure(.invalidURL)
        }

        var queryItems: [URLQueryItem] = []

        queryItems.append(URLQueryItem(name: "api_key", value: "7a9ff9d95f6e5dc76e22f1989c7255d6"))

        queryParams?.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: "\($0.value)")
            queryItems.append(urlQueryItem)
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            return .failure(.unknown)
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json;charset=utf-8"
        ]
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

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

}