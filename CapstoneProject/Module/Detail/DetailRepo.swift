//
//  DetailRepo.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 26/12/22.
//

import UIKit.UIApplication
import Combine

final class DetailRepo: DetailUseCase {
    func goToCoinGecko(id: String) {
        guard let url = URL(string: "https://www.coingecko.com/en/coins/\(id)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func constructDescription(pair: AllPairUIModel) -> AnyPublisher<String, Never> {
        return Future<String, Never> { completion in
            var paragraph: String = String()
            
            let baseCurrency: String = "This coin base currency is \(pair.baseCurrency.uppercased()). "
            let tickerID: String = "This coin Ticker ID is \(pair.tickerID). "
            
            let hasMemo: String = pair.hasMemo ? "has memo." : "does not have a memo."
            let memoParagraph: String = "This coin \(hasMemo) "
            
            let digitPriceRound: String = "This coin have \(pair.priceRound) digit(s) price round."
            
            paragraph.append(baseCurrency)
            paragraph.append(tickerID)
            paragraph.append(memoParagraph)
            paragraph.append(digitPriceRound)
            
            completion(.success(paragraph))
        }.eraseToAnyPublisher()
    }
}
