//
//  FavoriteProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 08/12/22.
//

import UIKit.UIViewController
import Combine

protocol FavoriteViewModelProtocol {
    var favoriteList: [AllPairEntity] { get set }
    var favoriteArrayPublisher: Published<[AllPairEntity]>.Publisher { get }
    
    func removeFromFavorite(pair: AllPairEntity)
    func goToDetail(pair: AllPairEntity, from: UIViewController)
    func populateFavorite()
}

enum FavoriteError: Error {
    case noFavorite
}
