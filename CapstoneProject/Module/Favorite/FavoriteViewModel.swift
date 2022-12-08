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
    
    init() {
        
    }
    
    func populateFavorite() {
        if let value = DatabaseManager.shared.getData(type: [AllPairEntity].self, forKey: "favorite") {
            self.favoriteList = value
        }
    }

    func removeFromFavorite(pair: AllPairEntity) {
        if let index = favoriteList.firstIndex(where: {$0.coinID == pair.coinID}) {
            favoriteList.remove(at: index)
            DatabaseManager.shared.setData(value: favoriteList, key: "favorite")
        }
    }

    func goToDetail(pair: AllPairEntity, from: UIViewController) {
        let detail: DetailViewController = DetailViewController(data: pair)
        from.navigationController?.pushViewController(detail, animated: true)
    }
}
