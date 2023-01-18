//
//  NetworkService.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 24/11/22.
//

import Foundation
import Alamofire
import Combine

public final class NetworkService: NetworkProtocol {
    public init() { }
    
    public func request<T>(config: APIConfiguration,
                    object: T.Type,
                    completion: @escaping (T?, AFError?) -> Void) where T : Decodable, T : Encodable {
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

}
