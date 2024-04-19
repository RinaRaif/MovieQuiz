//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Рина Райф on 24.03.2024.
//
//

import UIKit

//MARK: - AlertPresenter
final class AlertPresenter: AlertPresenterProtocol {
    
    // MARK: - Private properties
    private weak var viewController: UIViewController?
    
    //MARK: - Inizializers
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Methods
    func show(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.completion?()
        }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
