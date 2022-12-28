//
//  DetailProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import Foundation
import Combine

protocol DetailViewModelProtocol {
    var repo: DetailUseCase { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
    func goToCoinGecko(id: String)
    func constructDescription(pair: AllPairUIModel) -> AnyPublisher<String, Never>
}

protocol DetailUseCase {
    func goToCoinGecko(id: String)
    func constructDescription(pair: AllPairUIModel) -> AnyPublisher<String, Never>
}
