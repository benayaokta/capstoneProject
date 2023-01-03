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
   
    var data: [AllPairUIModel] = []
    var repo: HomeUseCase
    
    var isLoading: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
    var errorSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    var normalSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    
    var cancellables: Set<AnyCancellable> = []
    
    init(repo: HomeUseCase) {
        self.repo = repo
    }

    func getAllPairs() -> AnyPublisher<[AllPairUIModel], Error> {
        self.isLoading.send(true)
        return Future<[AllPairUIModel], Error> { [weak self] completion in
            guard let self else { return }
            self.repo.getAllPairs().sink { getAllPair in
                switch getAllPair {
                case .failure(let error):
                    self.isLoading.send(false)
                    completion(.failure(error))
                default:
                    break
                }
            } receiveValue: { response in
                self.isLoading.send(false)
                let entity = AllPairUIModel.mapModelToUIModel(array: response)
                self.data = entity
                completion(.success(entity))
            }.store(in: &self.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func addToFavorite(pair: AllPairUIModel) {
        let pair: AllPairEntity = AllPairEntity.mapUIModelToEntity(pair: pair)
        repo.saveToFavorite(pair: pair).sink { [weak self] errorHandler in
            guard let self else { return }
            switch errorHandler {
            case .failure(let error):
                switch error {
                case .duplicateItem(let text):
                    self.errorSnackbar.send(text)
                }
            default:
                break
            }
        } receiveValue: { [weak self] message in
            guard let self else { return }
            self.normalSnackbar.send(message)
        }.store(in: &cancellables)
    }
}
