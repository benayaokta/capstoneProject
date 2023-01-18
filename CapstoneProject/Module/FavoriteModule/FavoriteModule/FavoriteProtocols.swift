//
//  FavoriteProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 08/12/22.
//

import UIKit.UIViewController
import Combine
import CoreModel
import CoreManager

protocol FavoriteViewModelProtocol {
    var favoriteList: [AllPairUIModel] { get set }
    var repo: FavoriteUseCase { get set }
    
    var favoriteArrayPublisher: Published<[AllPairUIModel]>.Publisher { get }
    var cancellables: Set<AnyCancellable> { get set }
    
    func removeFromFavorite(pair: AllPairUIModel)
    func goToDetail(pair: AllPairUIModel, from: UIViewController)
    func populateFavorite()
}

protocol FavoriteUseCase {
    var database: DatabaseManager { get set }
    var favoriteData: [AllPairEntity] { get set }
    
    func removeFromFavorite(pair: AllPairEntity)
    func populateFavorite() -> AnyPublisher<[AllPairEntity], Never>
    func goToDetail(pair: AllPairUIModel, from: UIViewController)
}

enum FavoriteError: Error {
    case noFavorite
}
