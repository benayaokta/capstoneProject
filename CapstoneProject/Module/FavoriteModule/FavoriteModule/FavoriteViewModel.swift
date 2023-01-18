//
//  FavoriteViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 08/12/22.
//

import UIKit
import Combine
import CoreModel

final class FavoriteViewModel: FavoriteViewModelProtocol {
    @Published var favoriteList: [AllPairUIModel] = []
    
    var favoriteArrayPublisher: Published<[AllPairUIModel]>.Publisher { $favoriteList }
    var cancellables: Set<AnyCancellable> = []
    var repo: FavoriteUseCase
    
    init(repo: FavoriteUseCase) {
        self.repo = repo
    }
    
    func populateFavorite() {
        repo.populateFavorite().sink { [weak self] data in
            guard let self else { return }
            self.favoriteList = AllPairUIModel.mapEntityToUIModel(array: data)
        }.store(in: &cancellables)
    }

    func removeFromFavorite(pair: AllPairUIModel) {
        let entityPair = AllPairEntity.mapUIModelToEntity(pair: pair)
        if let index = favoriteList.firstIndex(where: {$0.coinID == entityPair.coinID}) {
            favoriteList.remove(at: index)
            repo.removeFromFavorite(pair: entityPair)
        }
    }

    func goToDetail(pair: AllPairUIModel, from: UIViewController) {
        repo.goToDetail(pair: pair, from: from)
    }
}
