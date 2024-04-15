//
//  NetworkRequests.swift
//  ProductLists
//
//  Created by Valter Louro on 11/04/2024.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}

protocol ProductProtocol {
    func getProductList(completionHandler: @escaping (Result<(ProductApiResponse)>) -> Void)
}

class NetworkRequests: ProductProtocol {
    
    // MARK: Variables
    static let shared = NetworkRequests()
    
    // MARK: Methods
    
    /**
     // General request method
     */
    func request(baseUrl: String, encode: Bool, completionHandler: @escaping (Data) -> Void) {
        
        // Create URL
        let urlToUse: URL?
        
        if encode {
            guard let urlString = baseUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
            
            urlToUse = URL(string: urlString)
            
        } else {
            urlToUse = URL(string: baseUrl)
        }
        
        guard let url = urlToUse else {
            fatalError("Could not create URL")
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            // Check response status is 200 OK
            if let res = response as? HTTPURLResponse {
                if res.statusCode != 200 {
                }
            }
            
            // If returned data is nil
            guard let data = data else {
                return
            }
            
            completionHandler(data)
            
        }).resume()
    }
    
    //MARK: Get Product List
    func getProductList(completionHandler: @escaping (Result<(ProductApiResponse)>) -> Void) {
        let url = "\(NetworkConstants.mainUrl)"
        
        self.request(baseUrl: url, encode: true) { (data) in
            
            do {
                self.saveJsonDataToLocal(data: data)
                let response = try JSONDecoder().decode(ProductApiResponse.self, from: data)
                completionHandler(.success(response))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }
    
    //MARK: Save Json Data
    func saveJsonDataToLocal(data: Data) {
        if
            let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent("productJsonData.json")
            do {
                try data.write(to: pathWithFileName)
            } catch {
                // handle error
            }
        }
    }
    
}
