//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Рина Райф on 10.04.2024.
//

import Foundation

/// Отвечает за загрузку данных по URL
   
//MARK: - NetworkRouting
protocol NetworkRouting {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
}

//MARK: - NetworkClient
struct NetworkClient: NetworkRouting {
    
    //MARK: - Private properties
    private enum NetworkError: Error {
        case codeError
    }
    
    //MARK: - Methods
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            if let responce = responce as? HTTPURLResponse,
               responce.statusCode < 200 || responce.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            
            guard let data = data else { return }
            handler(.success(data))
        }
        
        task.resume()
    }
}
