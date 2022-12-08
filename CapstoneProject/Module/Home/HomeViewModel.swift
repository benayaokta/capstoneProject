//
//  HomeViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import Foundation
import Combine
import Alamofire

final class HomeViewModel: HomeViewModelProtocol {
   
    var data: [AllPairEntity] = []
    
    var isLoading: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
    var errorSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    var normalSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    
    func getAllPairs() -> AnyPublisher<[AllPairEntity], Error> {
        self.isLoading.send(true)
        return Future<[AllPairEntity], Error> { completion in
            NetworkService().request(config: APIConfiguration.getAllPairs, object: [AllPairs].self) { [weak self] responseData, afError in
                guard let self else { return }
                if let afError {
                    completion(.failure(afError))
                } else {
                    let entity = AllPairEntity.mapResponseModelToEntity(array: responseData!)
                    completion(.success(entity))
                    self.data = entity
                }
                self.isLoading.send(false)
            }
        }.eraseToAnyPublisher()
    }
    
    func addToFavorite(pair: AllPairEntity) {
        if var array = DatabaseManager.shared.getData(type: [AllPairEntity].self, forKey: "favorite") {
            if !array.contains(where: {$0.coinID == pair.coinID}) {
                array.append(pair)
                DatabaseManager.shared.setData(value: array, key: "favorite")
                normalSnackbar.send("Success add to favorite")
            } else {
                errorSnackbar.send("Item already on favorite")
            }
        } else {
            var newArray: [AllPairEntity] = [AllPairEntity]()
            newArray.append(pair)
            DatabaseManager.shared.setData(value: newArray, key: "favorite")
            normalSnackbar.send("Success add to favorite")
        }
    }
}
