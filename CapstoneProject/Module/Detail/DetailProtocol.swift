//
//  DetailProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import Foundation

protocol DetailViewModelProtocol {
    func getOrderBook(id: String)
    func getDepth(id: String)
    func getTicker()
}


protocol DetailRepoProtocol {
    func fetchOrderBook(id: String)
    func fetchDepth(id: String)
    func fetchTicker()
}
