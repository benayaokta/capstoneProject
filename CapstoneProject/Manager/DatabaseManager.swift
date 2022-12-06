//
//  DatabaseManager.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import Foundation

final class DatabaseManager {
    static let shared: DatabaseManager = DatabaseManager()
    private let userDefault: UserDefaults
    
    enum AllPairError: String {
        case duplicateItem = "Already have this item"
        case noPair = "Cannot find this item"
    }
    
    private init() {
        userDefault = UserDefaults.init(suiteName: "CapstoneProject")!
    }
    
//    func getFavoriteList() -> [AllPairs]? {
//        if let object = userDefault.object(forKey: "favorite") as? [AllPairs] {
//            return object
//        } else {
//            return nil
//        }
//    }
//    
//    func setFavorite(pair: AllPairs, completion: @escaping (Bool?, AllPairError?) -> Void ) {
//        if var favorite: [AllPairs] = getFavoriteList() {
//            if favorite.contains(where: {$0.coinID == pair.coinID}) {
//                completion(false, .duplicateItem)
//                return
//            } else {
//                favorite.append(pair)
//            }
//            userDefault.set(favorite, forKey: "favorite")
//            completion(true, nil)
//        } else {
//            userDefault.set(pair, forKey: "favorite")
//            completion(true, nil)
//        }
//    }
//    
//    func deleteFavorite(pair: AllPairs, completion: @escaping (Bool?, AllPairError?) -> Void) {
//        if var favorite = getFavoriteList() {
//            if let favoriteIndex = favorite.firstIndex(where: {$0.coinID == pair.coinID}) {
//                favorite.remove(at: favoriteIndex)
//                userDefault.set(favorite, forKey: "favorite")
//                completion(true, nil)
//            } else {
//                completion(false, .noPair)
//                return
//            }
//        }
//    }
//    
//    func deleteAllFavorite() {
//        userDefault.removeObject(forKey: "favorite")
//    }
    
    func setData<T: Codable>(value: T, key: String) {
            let encoder: JSONEncoder = JSONEncoder()
            if let encoded = try? encoder.encode(value) {
                userDefault.set(encoded, forKey: key)
            }
        }
    func getData<T: Codable>(type: T.Type, forKey: String) -> T? {
            if let data = userDefault.object(forKey: forKey) as? Data {
                let decoder: JSONDecoder = JSONDecoder()
                if let value = try? decoder.decode(T.self, from: data) {
                    return value
                } else {
                    return nil
                }
            }
            return nil
        }
}
