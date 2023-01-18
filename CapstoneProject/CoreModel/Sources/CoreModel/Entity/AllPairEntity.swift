//
//  HomeEntity.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 08/12/22.
//

public struct AllPairEntity: Codable {
    public let coinSymbol: String
    public let baseCurrency: String
    public let description: String
    public let coinID: String
    public let coinGeckoID: String
    public let tickerID: String
    public let priceRound: Int
    public let hasMemo: Bool
    public let imageURL: String
    public let tradeCurrencyUnit: String
    public let isMaintenance: Bool

    public init(coinSymbol: String,
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
    
    public init() {
        self.coinSymbol = ""
        self.baseCurrency = ""
        self.description = ""
        self.coinID = ""
        self.coinGeckoID = ""
        self.tickerID = ""
        self.priceRound = 0
        self.hasMemo = false
        self.imageURL = ""
        self.tradeCurrencyUnit = ""
        self.isMaintenance = false
    }
    
    public static func mapUIModelToEntity(array: [AllPairUIModel]) -> [AllPairEntity] {
        var entity: [AllPairEntity] = []
        entity = array.compactMap({ AllPairEntity(coinSymbol: $0.coinSymbol,
                                                  baseCurrency: $0.baseCurrency,
                                                  description: $0.description,
                                                  coinID: $0.coinID,
                                                  coinGeckoID: $0.coinGeckoID,
                                                  tickerID: $0.tickerID,
                                                  priceRound: $0.priceRound,
                                                  hasMemo: $0.hasMemo,
                                                  imageURL: $0.imageURL,
                                                  tradeCurrencyUnit: $0.tradeCurrencyUnit,
                                                  isMaintenance: $0.isMaintenance) })

        return entity
    }
    
    public static func mapUIModelToEntity(pair: AllPairUIModel) -> AllPairEntity {
        let entity: AllPairEntity = AllPairEntity(coinSymbol: pair.coinSymbol,
                                                  baseCurrency: pair.baseCurrency,
                                                  description: pair.description,
                                                  coinID: pair.coinID,
                                                  coinGeckoID: pair.coinGeckoID,
                                                  tickerID: pair.tickerID,
                                                  priceRound: pair.priceRound,
                                                  hasMemo: pair.hasMemo,
                                                  imageURL: pair.imageURL,
                                                  tradeCurrencyUnit: pair.tradeCurrencyUnit,
                                                  isMaintenance: pair.isMaintenance)
        return entity
    }

}
