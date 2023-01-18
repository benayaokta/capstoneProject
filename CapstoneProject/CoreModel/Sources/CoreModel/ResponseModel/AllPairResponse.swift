//
//  AllPairsModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 24/11/22.
//

public struct AllPairsResponse: Codable {
    public let coinID, coinSymbol, baseCurrency, tradedCurrency: String
    public let tradedCurrencyUnit, coinDescription, tickerID: String
    public let volumePrecision, pricePrecision, priceRound, pricescale: Int
    public let tradeMinBaseCurrency: Int
    public let tradeMinTradedCurrency: Double
    public let hasMemo: Bool
    public let tradeFeePercent: Double
    public let urlLogoPNG: String
    public let isMaintenance: Int
    public let coinGeckoID: String?
    
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
    
    public init(coinID: String,
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
    
}
