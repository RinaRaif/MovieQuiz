//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Рина Райф on 28.03.2024.
//

import Foundation

protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}
