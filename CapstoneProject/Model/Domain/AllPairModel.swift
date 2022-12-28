//
//  AllPairModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 28/12/22.
//

import Foundation

struct AllPairModel: Codable {
    let coinID, coinSymbol, baseCurrency, tradedCurrency: String
    let tradedCurrencyUnit, coinDescription, tickerID: String
    let volumePrecision, pricePrecision, priceRound, pricescale: Int
    let tradeMinBaseCurrency: Int
    let tradeMinTradedCurrency: Double
    let hasMemo: Bool
    let tradeFeePercent: Double
    let urlLogoPNG: String
    let isMaintenance: Int
    let coinGeckoID: String?
    
    enum CodingKeys: String, CodingKey {
        case coinID = "id"
        case coinSymbol = "symbol"
        case baseCurrency = "base_currency"
        case tradedCurrency = "traded_currency"
        case tradedCurrencyUnit = "traded_currency_unit"
        case coinDescription = "description"
        case tickerID = "ticker_id"
        case volumePrecision = "volume_precision"
        case pricePrecision = "price_precision"
        case priceRound = "price_round"
        case pricescale
        case tradeMinBaseCurrency = "trade_min_base_currency"
        case tradeMinTradedCurrency = "trade_min_traded_currency"
        case hasMemo = "has_memo"
        case tradeFeePercent = "trade_fee_percent"
        case urlLogoPNG = "url_logo_png"
        case isMaintenance = "is_maintenance"
        case coinGeckoID = "coingecko_id"
    }
    
    init(coinID: String,
         coinSymbol: String,
         baseCurrency: String,
         tradedCurrency: String,
         tradedCurrencyUnit: String,
         coinDescription: String,
         tickerID: String,
         volumePrecision: Int,
         pricePrecision: Int,
         priceRound: Int,
         pricescale: Int,
         tradeMinBaseCurrency: Int,
         tradeMinTradedCurrency: Double,
         hasMemo: Bool,
         tradeFeePercent: Double,
         urlLogoPNG: String,
         isMaintenance: Int,
         coinGeckoID: String? = nil) {
        self.coinID = coinID
        self.coinSymbol = coinSymbol
        self.baseCurrency = baseCurrency
        self.tradedCurrency = tradedCurrency
        self.tradedCurrencyUnit = tradedCurrencyUnit
        self.coinDescription = coinDescription
        self.tickerID = tickerID
        self.volumePrecision = volumePrecision
        self.pricePrecision = pricePrecision
        self.priceRound = priceRound
        self.pricescale = pricescale
        self.tradeMinBaseCurrency = tradeMinBaseCurrency
        self.tradeMinTradedCurrency = tradeMinTradedCurrency
        self.hasMemo = hasMemo
        self.tradeFeePercent = tradeFeePercent
        self.urlLogoPNG = urlLogoPNG
        self.isMaintenance = isMaintenance
        self.coinGeckoID = coinGeckoID
    }
    
    static func mapResponseToModel(array: [AllPairsResponse]) -> [AllPairModel] {
        var model: [AllPairModel] = []
        model = array.compactMap({ list in
            return AllPairModel(coinID: list.coinID,
                                coinSymbol: list.coinSymbol,
                                baseCurrency: list.baseCurrency,
                                tradedCurrency: list.tradedCurrency,
                                tradedCurrencyUnit: list.tradedCurrencyUnit,
                                coinDescription: list.coinDescription,
                                tickerID: list.tickerID,
                                volumePrecision: list.volumePrecision,
                                pricePrecision: list.pricePrecision,
                                priceRound: list.priceRound,
                                pricescale: list.pricescale,
                                tradeMinBaseCurrency: list.tradeMinBaseCurrency,
                                tradeMinTradedCurrency: list.tradeMinTradedCurrency,
                                hasMemo: list.hasMemo,
                                tradeFeePercent: list.tradeFeePercent,
                                urlLogoPNG: list.urlLogoPNG,
                                isMaintenance: list.isMaintenance)
        })
        return model
    }
    
}
