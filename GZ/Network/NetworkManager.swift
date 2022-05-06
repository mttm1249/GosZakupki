//
//  NetworkManager.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import Foundation

class NetworkManager {

    var page = 1
    var urlLastSegmentForPage = ["page=", "", "&per=5"]
    
    let currentURL = CurrentURL.shared.url
    let region = CurrentURL.shared.region
    let inn = CurrentURL.shared.inn
    let name = CurrentURL.shared.name
    let info = CurrentURL.shared.info
    let number = CurrentURL.shared.number
    let okpd2 = CurrentURL.shared.okpd2
    
    func nextPage() {
        page += 1
        let strPageValue = String(page)
        urlLastSegmentForPage.insert(strPageValue, at: 1)
    }
    
    func loadJson(completion: @escaping (Result<Data, Error>) -> Void) {
        let convertedSegment = urlLastSegmentForPage.joined(separator: "")
        
        let string = currentURL + okpd2 + convertedSegment + number + region + inn + name + info
        let encodedStr = string.encodeUrl
        
        if let url = URL(string: encodedStr) {
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



