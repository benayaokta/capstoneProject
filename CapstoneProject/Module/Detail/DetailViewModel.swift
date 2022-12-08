//
//  DetailViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit

final class DetailViewModel: DetailViewModelProtocol {
    
    init() {
        
    }

    func goToCoinGecko(id: String) {
        guard let url = URL(string: "https://www.coingecko.com/en/coins/\(id)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

}
