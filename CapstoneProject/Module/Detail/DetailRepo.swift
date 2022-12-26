//
//  DetailRepo.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 26/12/22.
//

import UIKit.UIApplication

final class DetailRepo: DetailUseCase {
    func goToCoinGecko(id: String) {
        guard let url = URL(string: "https://www.coingecko.com/en/coins/\(id)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
