//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Рина Райф on 28.03.2024.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
}
