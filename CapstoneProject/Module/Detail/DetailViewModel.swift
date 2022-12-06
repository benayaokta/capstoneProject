//
//  DetailViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import Foundation

final class DetailViewModel: DetailViewModelProtocol {
    let repo: DetailRepo
    
    init(repo: DetailRepo) {
        self.repo = repo
    }
    
    func getOrderBook(id: String) {
        repo.fetchOrderBook(id: id)
    }
    
    func getTicker() {
        repo.fetchTicker()
    }
    
    func getDepth(id: String) {
        repo.fetchDepth(id: id)
    }
    
}
