//
//  NetworkManager.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import Foundation

protocol Model: Codable { }
extension Array: Model where Element: Model { }

func asyncMain(action: @escaping () -> Void) {
    DispatchQueue.main.async(execute: action)
}

class NetworkManager {

    private static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhcGlfa2V5IjoiODhiZjI4OWNhNTQxYWQxOCIsInNjb3BlcyI6WyJwdXJjaGFzZXMiLCJwbGFuZ3JhcGhzMjAyMCJdLCJpYXQiOjE2NTI0Mjc5OTMsImV4cCI6MTY1MjUxNDM5MywiaXNzIjoiaHR0cHM6Ly9kZXYuZ29zcGxhbi5pbmZvIiwiYXVkIjoiaHR0cHM6Ly9nb3NwbGFuLmluZm8vYXBpL3YxIiwianRpIjoiZGFmYjg2MTYtZDljMi00YTZiLTg0MDItN2M1ZTEyZDdjMjc4In0.GP2v89OGkvys3jUzZfHm-kG27JgBd9N-_9hL0T9Meys"

    var page = 1
    
    func nextPage() {
        page += 1
        let strPageValue = String(page)
        CurrentURL.shared.page = strPageValue
    }

    private static var session: URLSession?
    
    static let shared: NetworkManager = {
        let authValue = "Bearer \(apiKey)"
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": authValue]
        session = URLSession(configuration: config)
        return NetworkManager()
    }()
    
    func loadJson<T: Model>(completion: @escaping (Result<T, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: CurrentURL.shared.baseURL) else { return }
        urlComponents.path = CurrentURL.shared.basePath
        urlComponents.queryItems = CurrentURL.shared.params

        if let url = urlComponents.url {
            let urlSession = NetworkManager.session?.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    asyncMain { completion(.failure(error)) }
                }
                if let data = data {
                    do {
                        let value = try JSONDecoder().decode(T.self, from: data)
                        asyncMain { completion(.success(value)) }
                    } catch {
                        print(error)
                        asyncMain { completion(.failure(error)) }
                    }
                }
            }
            urlSession?.resume()
        }
    }
}

