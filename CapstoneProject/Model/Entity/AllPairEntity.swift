//
//  HomeEntity.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 08/12/22.
//

struct AllPairEntity: Codable {
    let coinSymbol: String
    let baseCurrency: String
    let description: String
    let coinID: String
    let coinGeckoID: String
    let tickerID: String
    let priceRound: Int
    let hasMemo: Bool
    let imageURL: String
    let tradeCurrencyUnit: String
    let isMaintenance: Bool

    init(coinSymbol: String,
         baseCurrency: String,
         description: String,
         coinID: String,
         coinGeckoID: String,
         tickerID: String,
         priceRound: Int,
         hasMemo: Bool,
         imageURL: String,
         tradeCurrencyUnit: String,
         isMaintenance: Bool) {
        self.coinSymbol = coinSymbol
        self.baseCurrency = baseCurrency
        self.description = description
        self.coinID = coinID
        self.coinGeckoID = coinGeckoID
        self.tickerID = tickerID
        self.priceRound = priceRound
        self.hasMemo = hasMemo
        self.imageURL = imageURL
        self.tradeCurrencyUnit = tradeCurrencyUnit
        self.isMaintenance = isMaintenance
    }

    static func mapResponseModelToEntity(array: [AllPairs]) -> [AllPairEntity] {
        var entity: [AllPairEntity] = []
        entity = array.compactMap({ AllPairEntity(coinSymbol: $0.coinSymbol,
                                                  baseCurrency: $0.baseCurrency,
                                                  description: $0.coinDescription,
                                                  coinID: $0.coinID,
                                                  coinGeckoID: $0.coinGeckoID ?? "",
                                                  tickerID: $0.tickerID,
                                                  priceRound: $0.priceRound,
                                                  hasMemo: $0.hasMemo,
                                                  imageURL: $0.urlLogoPNG,
                                                  tradeCurrencyUnit: $0.tradedCurrencyUnit,
                                                  isMaintenance: $0.isMaintenance.toBool) })

        return entity
        
    }

}
