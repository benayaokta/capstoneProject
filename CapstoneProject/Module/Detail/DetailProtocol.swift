//
//  DetailProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import Foundation

protocol DetailViewModelProtocol {
    var repo: DetailUseCase { get set }
    func goToCoinGecko(id: String)
}

protocol DetailUseCase {
    func goToCoinGecko(id: String)
}
