//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Рина Райф on 21.03.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {               
    func didReceiveNextQuestion(question: QuizQuestion?)
}
