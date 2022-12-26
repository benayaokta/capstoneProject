//
//  FavoriteViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 08/12/22.
//

import UIKit
import Combine

final class FavoriteViewModel: FavoriteViewModelProtocol {
    @Published var favoriteList: [AllPairEntity] = []
    
    var favoriteArrayPublisher: Published<[AllPairEntity]>.Publisher { $favoriteList }
    
    var repo: FavoriteUseCase
    
    init(repo: FavoriteUseCase) {
        self.repo = repo
    }
    
    func populateFavorite() {
        repo.populateFavorite { [weak self] data in
            self?.favoriteList = data
        }
    }

    func removeFromFavorite(pair: AllPairEntity) {
        if let index = favoriteList.firstIndex(where: {$0.coinID == pair.coinID}) {
            favoriteList.remove(at: index)
            repo.removeFromFavorite(pair: pair)
        }
    }

    func goToDetail(pair: AllPairEntity, from: UIViewController) {
        repo.goToDetail(pair: pair, from: from)
    }
}
