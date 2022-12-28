//
//  HomeRepo.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 26/12/22.
//

import Foundation
import Alamofire
import Combine

final class HomeRepo: HomeUseCase {
    
    var service: NetworkProtocol
    var storage: DatabaseManager
    
    init(service: NetworkProtocol, storage: DatabaseManager) {
        self.service = service
        self.storage = storage
    }
    
    func getAllPairs() -> AnyPublisher<[AllPairModel], Error> {
        return Future<[AllPairModel], Error> { [weak self] completion in
            guard let self else { return }
            self.service.request(config: APIConfiguration.getAllPairs, object: [AllPairsResponse].self) { (response, error) in
                if let response {
                    let allPairModel = AllPairModel.mapResponseToModel(array: response)
                    completion(.success(allPairModel))
                }
                
                if let error {
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func saveToFavorite(pair: AllPairEntity) -> AnyPublisher<String, FavoriteErrorEnum> {
        return Future<String, FavoriteErrorEnum> { [weak self] completion in
            guard let self else { return }
            if var array = self.storage.getData(type: [AllPairEntity].self, forKey: "favorite") {
                if !array.contains(where: {$0.coinID == pair.coinID}) {
                    array.append(pair)
                    DatabaseManager.shared.setData(value: array, key: "favorite")
                    completion(.success("Success add to favorite"))
                } else {
                    completion(.failure(.duplicateItem("Item already on favorite")))
                }
            } else {
                var newArray: [AllPairEntity] = [AllPairEntity]()
                newArray.append(pair)
                DatabaseManager.shared.setData(value: newArray, key: "favorite")
                completion(.success("Success add to favorite"))
            }
        }.eraseToAnyPublisher()
    }

}
