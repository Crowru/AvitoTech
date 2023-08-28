//
//  Configuration.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

private let DefaultBaseURL = URL(string: "https://www.avito.st/s/interns-ios")
private let MainPage = "/main-page.json"
private let DetailsPage = "/details/1.json"

struct AuthConfiguration {
    let defaultBaseURL: URL?
    let mainPage: String
    let detailsPage: String
    
    static var standard: AuthConfiguration {
        return AuthConfiguration(
            defaultBaseURL: DefaultBaseURL,
            mainPage: MainPage,
            detailsPage: DetailsPage
        )
    }
}
