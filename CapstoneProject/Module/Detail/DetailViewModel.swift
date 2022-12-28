//
//  DetailViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import Combine

final class DetailViewModel: DetailViewModelProtocol {
    var cancellables: Set<AnyCancellable> = []
    var repo: DetailUseCase
    
    init(repo: DetailUseCase) {
        self.repo = repo
    }

    func goToCoinGecko(id: String) {
        repo.goToCoinGecko(id: id)
    }
    
    func constructDescription(pair: AllPairUIModel) -> AnyPublisher<String, Never> {
        return Future<String, Never> { [weak self] completion in
            guard let self else { return }
            self.repo.constructDescription(pair: pair).sink { data in
                completion(.success(data))
            }.store(in: &self.cancellables)
        }.eraseToAnyPublisher()
    }

}
