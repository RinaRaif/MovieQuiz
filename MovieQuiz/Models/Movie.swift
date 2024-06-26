//
//  Movie.swift
//  MovieQuiz
//
//  Created by Рина Райф on 28.03.2024.
//

import Foundation

struct Actor {
    let id: String
    let image: String
    let name: String
    let asCharacter: String
}
struct Movie {
    let id: String
    let title: String
    let year: Int
    let image: String
    let releaseDate: String
    let runtimeMins: Int
    let directors: String
    let actorList: [Actor]
}
