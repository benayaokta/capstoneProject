//
//  FavoriteUseCase.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 26/12/22.
//

import UIKit
import Combine
import CoreModel
import CoreManager
import DetailModule

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
    
    func populateFavorite() -> AnyPublisher<[AllPairEntity], Never> {
        return Future<[AllPairEntity], Never> { [weak self] completion in
            guard let self else { return }
            if let value = self.database.getData(type: [AllPairEntity].self, forKey: "favorite") {
                self.favoriteData = value
                completion(.success(value))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeFromFavorite(pair: AllPairEntity) {
        if let index = favoriteData.firstIndex(where: {$0.coinID == pair.coinID}) {
            favoriteData.remove(at: index)
            database.setData(value: favoriteData, key: "favorite")
        }
    }
    
    func goToDetail(pair: AllPairUIModel, from: UIViewController) {
        let detail: DetailViewController = DetailViewController(data: pair)
        from.navigationController?.pushViewController(detail, animated: true)
    }

}
