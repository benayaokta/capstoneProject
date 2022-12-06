//
//  DetailRepo.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import Foundation
import Alamofire

final class DetailRepo: DetailRepoProtocol {
    let service: NetworkService = NetworkService()
    
    func fetchOrderBook(id: String) {
        service.request(config: APIConfiguration.orderBook(id), object: OrderBookArray.self) { responseData, error in
            guard error == nil else {
                print("error \(error)")
                return
            }
            
            print(responseData, " response data ===")
        }
    }
    
    func fetchTicker() {
        
    }
    
    func fetchDepth(id: String) {
        service.request(config: APIConfiguration.depth(id), object: DepthModel.self) { responseData, error in
            guard error == nil else {
                print("error \(error)")
                return
            }
            
            print(responseData, " response data ===")
        }
    }
    
    
}
