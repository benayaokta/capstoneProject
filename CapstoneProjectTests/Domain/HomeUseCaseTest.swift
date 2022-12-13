//
//  HomeUseCaseTest.swift
//  CapstoneProjectTests
//
//  Created by Benaya Oktavianus on 13/12/22.
//

import Foundation
import Combine
import XCTest

@testable import CapstoneProject

class HomeUseCaseTest: XCTestCase {
    
    func testAPI() throws {
        let expectation = self.expectation(description: "testAPI")
        var answer: [AllPairEntity] = []
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
        
        init() { }
        
        let entity = [
            AllPairEntity(
                coinSymbol: "BTCIDR",
                baseCurrency: "idr",
                description: "BTC/IDR",
                coinID: "btcidr",
                coinGeckoID: "bitcoin",
                tickerID: "btc_idr",
                priceRound: 8,
                hasMemo: false,
                imageURL: "https://indodax.com/v2/logo/png/color/btc.png",
                tradeCurrencyUnit: "BTC",
                isMaintenance: false),
            AllPairEntity(
                coinSymbol : "ETHIDR",
                baseCurrency : "idr",
                description : "ETH/IDR",
                coinID : "ethidr",
                coinGeckoID : "ethereum",
                tickerID : "eth_idr",
                priceRound : 8,
                hasMemo : false,
                imageURL : "https://indodax.com/v2/logo/png/color/eth.png",
                tradeCurrencyUnit : "ETH",
                isMaintenance : false
            ),
            AllPairEntity(
                coinSymbol : "IDKIDR",
                baseCurrency : "idr",
                description : "IDK/IDR",
                coinID : "idkidr",
                coinGeckoID : "idk",
                tickerID : "idk_idr",
                priceRound : 8,
                hasMemo : false,
                imageURL : "https://indodax.com/v2/logo/png/color/idk.png",
                tradeCurrencyUnit : "IDK",
                isMaintenance : false
            )
        ]
        
        var isLoading: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
        
        var errorSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
        
        var normalSnackbar: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
        
        var data: [CapstoneProject.AllPairEntity] = []
        
        func getAllPairs() -> AnyPublisher<[CapstoneProject.AllPairEntity], Error> {
            return Future<[AllPairEntity], Error> { completion in
                completion(.success(self.entity))
//                completion(.success([AllPairEntity]()))
            }.eraseToAnyPublisher()
        }
        
        func addToFavorite(pair: CapstoneProject.AllPairEntity) {
            
        }
        
            
    }
}
