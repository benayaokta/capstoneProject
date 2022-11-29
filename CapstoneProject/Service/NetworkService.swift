//
//  NetworkService.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 24/11/22.
//

import Foundation
import Alamofire
import Combine

final class NetworkService: NetworkProtocol {
    init() { }
    
    func request<T>(config: APIConfiguration, object: T.Type, completion: @escaping (T?, AFError?) -> Void) where T : Decodable, T : Encodable {
        AF.request(config)
            .validate()
            .responseDecodable(of: T.self,
                               queue: DispatchQueue.global(qos: .background)) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
//    func request<T: Codable>(config: APIConfiguration, object: T.Type) {
//        AF.request(config)
//            .validate()
//            .responseDecodable(of: T.self,
//                               queue: DispatchQueue.global(qos: .background)) { response in
//            switch response.result {
//            case .success(let value):
//                print("sukses \(value)")
//            case .failure(let error):
//                print("error \(error)")
//            }
//        }
//    }

}
