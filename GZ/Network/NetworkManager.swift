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

    private static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhcGlfa2V5IjoiODhiZjI4OWNhNTQxYWQxOCIsInNjb3BlcyI6WyJwdXJjaGFzZXMiLCJwbGFuZ3JhcGhzMjAyMCJdLCJpYXQiOjE2NTIzMzQ3OTEsImV4cCI6MTY1MjQyMTE5MSwiaXNzIjoiaHR0cHM6Ly9kZXYuZ29zcGxhbi5pbmZvIiwiYXVkIjoiaHR0cHM6Ly9nb3NwbGFuLmluZm8vYXBpL3YxIiwianRpIjoiMDk4MDM0YjUtZGZjZC00ZjA2LTgyYjEtMGQzNTJhMmQ0YmU5In0.sDoGO1KwDE2FPtvdaJwxLt8QOf4sWE16UmFWd1mtHjI"

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

