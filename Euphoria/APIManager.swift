//
//  APIManager.swift
//  Euphoria
//
//  Created by Annie Tung on 12/14/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPpoint: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: endPpoint) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data: Data?, _, error: Error?) in
            if error != nil {
                print("Error encountered at: \(error)")
            }
            guard let validData = data else { return }
            DispatchQueue.main.async {
                completion(validData)
            }
        }.resume()
    }
}
