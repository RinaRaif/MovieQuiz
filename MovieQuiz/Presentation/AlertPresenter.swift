//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Рина Райф on 24.03.2024.
//
//
import Foundation
import UIKit
 
class AlertPresenter {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func show(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )

        let action = UIAlertAction(
            title: alertModel.buttonText,
            style: .default) { _ in
            alertModel.completion?()
        }

        alert.addAction(action)
        
        self.viewController?.present(alert, animated: true, completion: nil)
    }
}

