//
//  HomeViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import Foundation
import Combine
import Alamofire

final class HomeViewModel: HomeViewModelProtocol {
   
    var data: [AllPairEntity] = []
    var repo: HomeUseCase
    
    var isLoading: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
    var errorSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    var normalSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    
    init(repo: HomeUseCase) {
        self.repo = repo
    }
    
    func getAllPairs() -> AnyPublisher<[AllPairEntity], Error> {
        self.isLoading.send(true)
        return Future<[AllPairEntity], Error> { completion in
            self.repo.getAllPairs { [weak self] data in
                self?.isLoading.send(false)
                completion(.success(data))
                self?.data = data
            } errorHandler: { error in
                self.isLoading.send(false)
                completion(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func addToFavorite(pair: AllPairEntity) {
        repo.saveToFavorite(pair: pair) { [weak self] success, message in
            guard let self else { return }
            if success {
                self.normalSnackbar.send(message)
            } else {
                self.errorSnackbar.send(message)
            }
        }
    }
}
