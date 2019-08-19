//
//  APIRequest.swift
//  SwiftPost
//
//  Created by David Rossouw on 2019-08-17.
//  Copyright © 2019 David Rossouw. All rights reserved.
//

import Foundation

enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "http://localhost:5000/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }
    
    func send (_ messageToSave:Message, completion: @escaping(Result<Message, APIError>) -> Void) {
        var request = URLRequest(url: resourceURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(messageToSave)
        }catch {
            completion(.failure(.decodingProblem))
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }}

