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
