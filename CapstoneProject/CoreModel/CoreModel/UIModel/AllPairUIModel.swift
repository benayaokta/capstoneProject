//
//  AllPairUIModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 28/12/22.
//

import Foundation

public struct AllPairUIModel: Codable {
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

    public static func mapEntityToUIModel(array: [AllPairEntity]) -> [AllPairUIModel] {
        var entity: [AllPairUIModel] = []
        entity = array.compactMap({ AllPairUIModel(coinSymbol: $0.coinSymbol,
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
    
    public static func mapModelToUIModel(array: [AllPairModel]) -> [AllPairUIModel] {
        var entity: [AllPairUIModel] = []
        entity = array.compactMap({ AllPairUIModel(coinSymbol: $0.coinSymbol,
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
