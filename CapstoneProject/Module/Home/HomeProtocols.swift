//
//  HomeProtocols.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import Combine

protocol HomeViewModelProtocol {
    func getAllPairs(name: String) -> String
    var isLoading: PassthroughSubject<Bool, Never> { get set }
    func getAllPairs() -> AnyPublisher<[AllPairs], Error>
}

protocol HomeUseCase {
    func getAllPars(name: String) -> String
}
