//
//  NetworkManager.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import Foundation

class NetworkManager {

    var page = 1
    var urlLastSegmentForPage = ["?page=", "", "&per=10"]
    
    let region = CurrentURL.shared.region
    let inn = CurrentURL.shared.inn
    
    let key =
    "eyJhbGciOiJIUzI1NiJ9.eyJhcGlfa2V5IjoiODhiZjI4OWNhNTQxYWQxOCIsInNjb3BlcyI6WyJwdXJjaGFzZXMiLCJwbGFuZ3JhcGhzMjAyMCJdLCJpYXQiOjE2NTE1Nzc5NDgsImV4cCI6MTY1MTY2NDM0OCwiaXNzIjoiaHR0cHM6Ly9kZXYuZ29zcGxhbi5pbmZvIiwiYXVkIjoiaHR0cHM6Ly9nb3NwbGFuLmluZm8vYXBpL3YxIiwianRpIjoiNmFmMTFiMzAtMjRhNC00MTkzLTg5NzUtZGM3MWFkOGM4MzU0In0.ME8ndwspnTB-U1XjEvNdk3HRmEMbuAyq_LT_Js3TsCY"

    let currentURL = CurrentURL.shared.url
    
    func nextPage() {
        page += 1
        let strPageValue = String(page)
        urlLastSegmentForPage.insert(strPageValue, at: 1)
    }
    
    func loadJson(completion: @escaping (Result<Data, Error>) -> Void) {
        let convertedCut = urlLastSegmentForPage.joined(separator: "")
        if let url = URL(string: currentURL + convertedCut + region + inn) {
            let sessionConfig = URLSessionConfiguration.default
           
            let authValue = "Bearer \(key)"
            sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ]
            
            let urlSession = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
}


