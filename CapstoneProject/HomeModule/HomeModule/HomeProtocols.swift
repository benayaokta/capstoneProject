//
//  HomeProtocols.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import Combine
import CoreModel
import CoreManager
import CoreNetwork

protocol HomeViewModelProtocol {
    var isLoading: PassthroughSubject<Bool, Never> { get set }
    var errorSnackbar: PassthroughSubject<String, Never> { get set }
    var normalSnackbar: PassthroughSubject<String, Never> { get set }
    
    var data: [AllPairUIModel] { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
    func getAllPairs() -> AnyPublisher<[AllPairUIModel], Error>
    func addToFavorite(pair: AllPairUIModel)
}


protocol HomeUseCase {    
    func getAllPairs() -> AnyPublisher<[AllPairModel], Error>
    func saveToFavorite(pair: AllPairEntity) -> AnyPublisher<String, FavoriteErrorEnum>
    
    var service: NetworkProtocol { get set }
    var storage: DatabaseManager { get set }
}

enum FavoriteErrorEnum: Error {
    case duplicateItem(String)
}
