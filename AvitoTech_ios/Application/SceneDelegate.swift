//
//  SceneDelegate.swift
//  AvitoTech_ios
//
//  Created by Руслан  on 24.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let listOfProductsService = ListOfAdvertisementsService.shared
        let presenter = ListOfAdvertisementsPresenter(listOfProductsService: listOfProductsService)
        let listOfAdvertisementsViewController = ListOfAdvertisementsViewController(presenter: presenter)
        
        let rootVC = UINavigationController(rootViewController: listOfAdvertisementsViewController)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
}
