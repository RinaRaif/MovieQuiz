//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Рина Райф on 10.04.2024.
//

import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading {
    // MARK: - NetworkClient
    private let networkClient = NetworkClient()
    
    // MARK: - URL
    private var mostPopularMoviesUrl: URL {
        guard let url = URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            do {
                let data = try result.get()
                let decodedData = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                if decodedData.errorMessage.isEmpty {
                    handler(.success(decodedData))
                } else {
                    let error = NSError(domain: decodedData.errorMessage, code: 0)
                    handler(.failure(error))
                }
            } catch let error {
                handler(.failure(error))
            }
        }
    }
}
