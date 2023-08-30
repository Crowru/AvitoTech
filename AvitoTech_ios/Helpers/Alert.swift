//
//  Alert.swift
//  AvitoTech
//
//  Created by Руслан  on 30.08.2023.
//

import UIKit

extension UIViewController {
    func presentErrorAlert(message: String, retryHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        if let retryHandler = retryHandler {
            let refresh = UIAlertAction(title: "Повторить", style: .default, handler: { _ in
                retryHandler()
            })
            alertController.addAction(refresh)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
