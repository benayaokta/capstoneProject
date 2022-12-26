//
//  FavoriteUseCase.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 26/12/22.
//

import UIKit

final class FavoriteRepo: FavoriteUseCase {
    var database: DatabaseManager
    var favoriteData: [AllPairEntity] = []
    
    init(database: DatabaseManager) {
        self.database = database
    }
    
    func populateFavorite(completion: @escaping ([AllPairEntity]) -> Void) {
        if let value = database.getData(type: [AllPairEntity].self, forKey: "favorite") {
            self.favoriteData = value
            completion(value)
        }
    }
    
    func removeFromFavorite(pair: AllPairEntity) {
        if let index = favoriteData.firstIndex(where: {$0.coinID == pair.coinID}) {
            favoriteData.remove(at: index)
            database.setData(value: favoriteData, key: "favorite")
        }
    }
    
    func goToDetail(pair: AllPairEntity, from: UIViewController) {
        let detail: DetailViewController = DetailViewController(data: pair)
        from.navigationController?.pushViewController(detail, animated: true)
    }

}
