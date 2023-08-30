//
//  ListOfProductsService.swift
//  AvitoTech
//
//  Created by Руслан  on 27.08.2023.
//

import UIKit

protocol ListOfAdvertisementsServiceProtocol {
    func fetchListAdvertisements(completion: @escaping (Result<[Items], Error>) -> Void)
    func fetchDetailAdvertisement(id: String, completion: @escaping (Result<AdvertisementsDetails, Error>) -> Void)
}

final class ListOfAdvertisementsService: ListOfAdvertisementsServiceProtocol {
    static let shared = ListOfAdvertisementsService()
    private let urlSession = URLSession.shared
    private let configuration = AuthConfiguration.standard
    
    private(set) var advertisements: [Advertisements]?
    private var currentTask: URLSessionTask?
    
    private init() {}
    
    func fetchListAdvertisements(completion: @escaping (Result<[Items], Error>) -> Void) {
        guard currentTask == nil else { return }
        guard let urlString = configuration.defaultBaseURL?.appendingPathComponent(configuration.mainPage) else { return }
        let url = urlString
        let task = urlSession.dataTask(with: url) { data, responce, error in
            if let data = data,
               let responce = responce,
               let statusCode = (responce as? HTTPURLResponse)?.statusCode {
                if 200..<300 ~= statusCode {
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(Advertisements.self, from: data) {
                        DispatchQueue.main.async {
                            completion(.success(json.advertisements))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.httpStatusCode(statusCode)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    guard let error = error else { return }
                    completion(.failure(NetworkError.urlSessionError(error)))
                }
            }
            self.currentTask = nil
        }
        self.currentTask = task
        task.resume()
    }
    
    func fetchDetailAdvertisement(id: String, completion: @escaping (Result<AdvertisementsDetails, Error>) -> Void) {
        guard currentTask == nil else { return }
        guard let urlString = configuration.defaultBaseURL?.appendingPathComponent("/details/\(id).json") else { return }
        let url = urlString
        let task = urlSession.dataTask(with: url) { data, responce, error in
            if let data = data,
               let responce = responce,
               let statusCode = (responce as? HTTPURLResponse)?.statusCode {
                if 200..<300 ~= statusCode {
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(AdvertisementsDetails.self, from: data) {
                        DispatchQueue.main.async {
                            completion(.success(json))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.httpStatusCode(statusCode)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    guard let error = error else { return }
                    completion(.failure(NetworkError.urlSessionError(error)))
                }
            }
            self.currentTask = nil
        }
        self.currentTask = task
        task.resume()
    }
}
