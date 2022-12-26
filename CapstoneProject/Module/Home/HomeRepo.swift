//
//  HomeRepo.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 26/12/22.
//

import Foundation
import Alamofire

final class HomeRepo: HomeUseCase {
    
    var service: NetworkProtocol
    var storage: DatabaseManager
    
    init(service: NetworkProtocol, storage: DatabaseManager) {
        self.service = service
        self.storage = storage
    }
    
    
    func getAllPairs(completion: @escaping ([AllPairEntity]) -> Void, errorHandler: @escaping (Error) -> Void) {
        service.request(config: APIConfiguration.getAllPairs, object: [AllPairs].self) { (response, error) in
            if let response {
                let entity = AllPairEntity.mapResponseModelToEntity(array: response)
                completion(entity)
            }
            
            if let error {
                errorHandler(error)
            }
        }
    }
    
    func saveToFavorite(pair: AllPairEntity, completion: (Bool, String) -> Void) {
        if var array = storage.getData(type: [AllPairEntity].self, forKey: "favorite") {
            if !array.contains(where: {$0.coinID == pair.coinID}) {
                array.append(pair)
                DatabaseManager.shared.setData(value: array, key: "favorite")
                completion(true, "Success add to favorite")
            } else {
                completion(false, "Item already on favorite")
            }
        } else {
            var newArray: [AllPairEntity] = [AllPairEntity]()
            newArray.append(pair)
            DatabaseManager.shared.setData(value: newArray, key: "favorite")
            completion(true, "Success add to favorite")
        }
    }
}
