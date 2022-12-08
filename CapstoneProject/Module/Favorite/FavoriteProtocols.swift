//
//  FavoriteProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 08/12/22.
//

import UIKit.UIViewController
import Combine

protocol FavoriteViewModelProtocol {
    func removeFromFavorite(pair: AllPairEntity)
    func goToDetail(pair: AllPairEntity, from: UIViewController)
    func populateFavorite()
//    func populateFavorite() -> AnyPublisher<[AllPairs], FavoriteError>
    var favoriteList: [AllPairEntity] { get set }
    var favoriteArrayPublisher: Published<[AllPairEntity]>.Publisher { get }
}

enum FavoriteError: Error {
    case noFavorite
}
