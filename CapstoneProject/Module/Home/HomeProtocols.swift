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
