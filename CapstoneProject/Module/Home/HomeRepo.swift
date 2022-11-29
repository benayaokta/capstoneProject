//
//  HomeRepo.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import Foundation

final class HomeRepo: HomeUseCase {
    
    
    init() {
        
    }
    
    func getAllPars(name: String) -> String {
        return "tes pair is \(name)"
    }
}


final class NewHomeRepo: HomeUseCase {
    
    init() {
        
    }
    
    func getAllPars(name: String) -> String {
        return "ini class baru, return \(name)"
    }
}
