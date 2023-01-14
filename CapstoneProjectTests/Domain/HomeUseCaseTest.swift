//
//  HomeUseCaseTest.swift
//  CapstoneProjectTests
//
//  Created by Benaya Oktavianus on 13/12/22.
//

import Foundation
import Combine
import XCTest
import CoreModel

@testable import CapstoneProject

class HomeUseCaseTest: XCTestCase {
    
    func testAPI() throws {
        let expectation = self.expectation(description: "testAPI")
        var answer: [AllPairUIModel] = []
        let usecase = HomeMock()
        
        let _ = usecase.getAllPairs().sink { _ in

        } receiveValue: { value in
            answer = value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.5)
        
        XCTAssertNotNil(answer)
 
        XCTAssert(answer.contains(where: {$0.coinSymbol == "BTCIDR"}))
        XCTAssert(answer.contains(where: {$0.coinSymbol == "IDKIDR"}))
        XCTAssert(answer.contains(where: {$0.coinSymbol == "ETHIDR"}))
        
    }
}

extension HomeUseCaseTest {
    
    class HomeMock: HomeViewModelProtocol {
        var cancellables: Set<AnyCancellable> = []
        
        
        init() { }
        
        let entity = [
            AllPairModel(coinID: "btcidr",
                         coinSymbol: "BTCIDR",
                         baseCurrency: "idr",
                         tradedCurrency: "btc",
                         tradedCurrencyUnit: "BTC",
                         coinDescription: "BTC/IDR",
                         tickerID: "btc_idr",
                         volumePrecision: 0,
                         pricePrecision: 1000,
                         priceRound: 8,
                         pricescale: 1000,
                         tradeMinBaseCurrency: 10000,
                         tradeMinTradedCurrency: 3.805e-05,
                         hasMemo: false,
                         tradeFeePercent: 0.3,
                         urlLogoPNG: "https://indodax.com/v2/logo/png/color/btc.png",
                         isMaintenance: 0,
                         coinGeckoID: nil),
            
            AllPairModel(coinID: "idkidr",
                         coinSymbol: "IDKIDR",
                         baseCurrency: "idr",
                         tradedCurrency: "idk",
                         tradedCurrencyUnit: "IDK",
                         coinDescription: "IDK/IDR",
                         tickerID: "idk_idr",
                         volumePrecision: 0,
                         pricePrecision: 1,
                         priceRound: 8,
                         pricescale: 1,
                         tradeMinBaseCurrency: 10000,
                         tradeMinTradedCurrency: 10.0,
                         hasMemo: false,
                         tradeFeePercent: 0.0,
                         urlLogoPNG: "https://indodax.com/v2/logo/png/color/idk.png",
                         isMaintenance: 0,
                         coinGeckoID: nil),
            
            AllPairModel(coinID: "ethidr",
                         coinSymbol: "ETHIDR",
                         baseCurrency: "idr",
                         tradedCurrency: "eth",
                         tradedCurrencyUnit: "ETH",
                         coinDescription: "ETH/IDR",
                         tickerID: "eth_idr",
                         volumePrecision: 0,
                         pricePrecision: 1000,
                         priceRound: 8,
                         pricescale: 1000,
                         tradeMinBaseCurrency: 10000,
                         tradeMinTradedCurrency: 0.00053319,
                         hasMemo: false,
                         tradeFeePercent: 0.3,
                         urlLogoPNG: "https://indodax.com/v2/logo/png/color/eth.png",
                         isMaintenance: 0,
                         coinGeckoID: nil)
        ]
                
        var isLoading: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
        
        var errorSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
        
        var normalSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
        
        var data: [AllPairUIModel] = []
        
        func getAllPairs() -> AnyPublisher<[AllPairUIModel], Error> {
            return Future<[AllPairUIModel], Error> { completion in
                let uiModel = AllPairUIModel.mapModelToUIModel(array: self.entity)
                completion(.success(uiModel))
            }.eraseToAnyPublisher()
        }
        
        func addToFavorite(pair: AllPairUIModel) {
            
        }
        
            
    }
}
