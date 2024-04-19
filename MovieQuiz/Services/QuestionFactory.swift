//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Рина Райф on 19.03.2024.
//

import Foundation
import UIKit

//MARK: - QuestionFactory
final class QuestionFactory: QuestionFactoryProtocol {
    
    //MARK: - Private properties
    private let moviesLoader: MoviesLoading
    private weak var delegate: QuestionFactoryDelegate?
    private var movies: [MostPopularMovie] = []
    
    //MARK: - Initialisers
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    //MARK: - Public methods
    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                    case .success(let mostPopularMovie):
                        self.movies = mostPopularMovie.items
                        self.delegate?.didLoadDataFromServer()
                    case .failure(let error):
                        self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
    }
    
    func requestNextQuestion() {
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return }
            
            var imageData = Data()
            
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL)
                
                let randomQuestion = ["больше", "меньше"].randomElement() ?? ""
                
                let rating = Float(movie.rating) ?? 0
                let randomRating = Float(round(10 * Float.random(in: 4.1...9.9)) / 10)
                let text = "Рейтинг этого фильма \(randomQuestion) чем \(randomRating)?"
                
                let correctAnswer: Bool
                
                switch randomQuestion {
                    case "больше":
                        correctAnswer = rating > randomRating
                    case "меньше":
                        correctAnswer = rating < randomRating
                    default:
                        correctAnswer = false
                }
                let question = QuizQuestion(image: imageData,
                                            text: text,
                                            correctAnswer: correctAnswer)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didReceiveNextQuestion(question: question)
                }
            } catch {
                print("Failed to load image")
                DispatchQueue.main.async {
                    //                    self.delegate?.didFailedToLoadImage(with: error)
                    
                    let alert = UIAlertController(title: "Что-то пошло не так(", message: "Не удалось загрузить изображение", preferredStyle: .alert)
                    
                    let action = UIAlertAction(
                        title: "Попробовать ещё раз",
                        style: .default) { [weak self] _ in
                            guard let self = self else { return }
                            loadData()
                        }
                    alert.addAction(action)
                    
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

//    private let questions: [QuizQuestion] = [
//        QuizQuestion(
//            image: "The Godfather",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "The Dark Knight",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "Kill Bill",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "The Avengers",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "Deadpool",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "The Green Knight",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "Old",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: false),
//        QuizQuestion(
//            image: "The Ice Age Adventures of Buck Wild",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: false),
//        QuizQuestion(
//            image: "Tesla",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: false),
//        QuizQuestion(
//            image: "Vivarium",
//            text: "Рейтинг этого фильма больше чем 6?",
//            correctAnswer: false)]


