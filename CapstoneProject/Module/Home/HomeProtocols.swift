//
//  HomeProtocols.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import Combine

protocol HomeViewModelProtocol {
    var isLoading: PassthroughSubject<Bool, Never> { get set }
    var errorSnackbar: PassthroughSubject<String, Never> { get set }
    var normalSnackbar: PassthroughSubject<String, Never> { get set }
    
    var data: [AllPairEntity] { get set }
    
    func getAllPairs() -> AnyPublisher<[AllPairEntity], Error>
    func addToFavorite(pair: AllPairEntity)
}


protocol HomeUseCase {
    func getAllPairs(completion: @escaping ([AllPairEntity]) -> Void, errorHandler: @escaping (Error) -> Void)
    func saveToFavorite(pair: AllPairEntity, completion: (Bool, String) -> Void)
    
    var service: NetworkProtocol { get set }
    var storage: DatabaseManager { get set }
}
