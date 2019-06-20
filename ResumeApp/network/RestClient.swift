//
//  RestClientProtocol.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import Foundation

typealias ErrorHandler = (String) -> Void
typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol RestClientProtocol {
    func get<T: Decodable>(urlString: String, successHandler: @escaping (T) -> Void, errorHandler: @escaping ErrorHandler)
}

class RestClient: RestClientProtocol {
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get<T>(urlString: String, successHandler: @escaping (T) -> Void, errorHandler: @escaping ErrorHandler) where T: Decodable {
        
        let completionHandler: CompletionHandler = { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    errorHandler(NetworkError.genericError)
                    return
                }
                
                if self.isSuccessful(urlResponse) {
                    guard let data = data else {
                        print("Unable to parse the response in given type \(T.self)")
                        return errorHandler(NetworkError.noDataError)
                    }
                    
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        successHandler(responseObject)
                        return
                    } catch {
                        print(error)
                    }
                    
                }
                errorHandler(NetworkError.genericError)
            }
        }
        
        guard let url = URL(string: urlString) else {
            return errorHandler("Invalid Url")
        }
        let request = URLRequest(url: url)
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }

    
    private func isSuccessful(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }

    private func isSuccessful(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessful(urlResponse.statusCode)
    }
}
