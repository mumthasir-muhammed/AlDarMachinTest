//
//  APIService.swift
//  AlDarMachinTest
//
//  Created by Mumthasir VP on 06/08/24.
//

import Foundation

class APIService {
    static var shared = APIService()
    private init() {}
    
    // MARK: - Generic API service call
    func apiCall<T: Codable>(
        urlString: String,
        type:T.Type,
        completion: @escaping (Result<T, Error>) -> Void)
    {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { result, _, error in
            do {
                let response = try JSONDecoder().decode(type.self, from: result!)
                DispatchQueue.main.async { completion(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
}
