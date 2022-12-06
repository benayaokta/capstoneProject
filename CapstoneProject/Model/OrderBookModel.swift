//
//  OrderBookModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//


struct OrderBookModel: Codable {
    let date: String
    let price: String
    let amount: String
    let transactionID: String
    let type: TypeEnum
    
    enum CodingKeys: String, CodingKey {
        case date
        case price
        case amount
        case transactionID = "tid"
        case type
    }
    
    init(date: String, price: String, amount: String, transactionID: String, type: TypeEnum) {
        self.date = date
        self.price = price
        self.amount = amount
        self.transactionID = transactionID
        self.type = type
    }
}

typealias OrderBookArray = [OrderBookModel]

enum TypeEnum: String, Codable {
    case buy = "buy"
    case sell = "sell"
}
