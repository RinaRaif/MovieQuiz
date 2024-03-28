//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Рина Райф on 24.03.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)?
}
