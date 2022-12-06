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
    
    let repo: HomeUseCase
    
    init(repo: HomeUseCase) {
        self.repo = repo
    }
   
    var isLoading: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
    
    func getAllPairs(name: String) -> String {
        return repo.getAllPars(name: name)
    }
    
    func getAllPairs() -> AnyPublisher<[AllPairs], Error> {
        self.isLoading.send(true)
        return Future<[AllPairs], Error> { completion in
            NetworkService().request(config: APIConfiguration.getAllPairs, object: [AllPairs].self) { [weak self] responseData, afError in
                if let afError {
                    completion(.failure(afError))
                } else {
                    completion(.success(responseData!))
                }
                self?.isLoading.send(false)
            }
        }.eraseToAnyPublisher()
    }
}
