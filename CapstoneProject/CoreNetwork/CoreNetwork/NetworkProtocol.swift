//
//  NetworkProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import Alamofire
import Combine

public protocol NetworkProtocol {
    func request<T: Codable>(config: APIConfiguration, object: T.Type, completion: @escaping (T?, AFError?) -> Void)
}


