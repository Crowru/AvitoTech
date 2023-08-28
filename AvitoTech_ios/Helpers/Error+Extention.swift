//
//  URLSession+Extention.swift
//  AvitoTech
//
//  Created by Руслан  on 27.08.2023.
//

import Foundation

// MARK: - Network Connection
enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlSessionError(Error)
    case decodeError(Error)
    case unknownError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .httpStatusCode(let code):
            return NSLocalizedString("Response code - \(code)", comment: "Network error")
        case .urlSessionError(let error):
            return NSLocalizedString("Failed with session - \(error)", comment: "Network error")
        case .decodeError(let error):
            return NSLocalizedString("Failed with decode model - \(error)", comment: "Network error")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "URL Session error")
        }
    }
}
