//
//  DetailViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit

final class DetailViewModel: DetailViewModelProtocol {
    var repo: DetailUseCase
    
    init(repo: DetailUseCase) {
        self.repo = repo
    }

    func goToCoinGecko(id: String) {
        repo.goToCoinGecko(id: id)
    }

}
