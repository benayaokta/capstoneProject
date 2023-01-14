//
//  FavoriteViewController.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import Stevia
import SDWebImage
import Combine
import CoreModel
import CoreExtension

final class FavoriteViewController: UIViewController {
    
    private let favoriteTableView: UITableView = UITableView()
    private let emptyView: UIView = FavoriteEmptyView()
    private var viewModel: FavoriteViewModelProtocol!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injection()
        setupCombine()
        setupHierarchy()
        setupComponent()
        viewModel.populateFavorite()
    }
    
    private func injection() {
        viewModel = FavoriteViewModel(repo: FavoriteRepo(database: DatabaseManager.shared))
    }
    
    private func setupHierarchy() {
        view.subviews {
            favoriteTableView
        }
        
        favoriteTableView.fillContainer()
        favoriteTableView.backgroundView = emptyView
    }
    
    private func setupComponent() {
        self.title = "favorite.title".localized(id: AppDelegate.mainBundle)
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.registerCellClass(type: CapstoneTableViewCell.self)
    }
    
    private func setupCombine() {
        viewModel.favoriteArrayPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                if value.isEmpty {
                    self.favoriteTableView.backgroundView = self.emptyView
                } else {
                    self.favoriteTableView.backgroundView = nil
                }
                self.favoriteTableView.reloadData()
            }).store(in: &cancellables)
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToDetail(pair: viewModel.favoriteList[indexPath.row], from: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "favorite.action.remove".localized(id: AppDelegate.mainBundle)) { _, _, completionHandler in
            self.viewModel.removeFromFavorite(pair: self.viewModel.favoriteList[indexPath.row])
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CapstoneTableViewCell.self, for: indexPath) as? CapstoneTableViewCell else { return UITableViewCell() }
        let cryptoData: AllPairUIModel = viewModel.favoriteList[indexPath.row]
        
        cell.coinDesc.text = cryptoData.description
        cell.coinImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.coinImage.sd_setImage(with: URL(string: cryptoData.imageURL), placeholderImage: UIImage(), options: [.progressiveLoad])
        cell.coinCurrencyUnit.text = cryptoData.tradeCurrencyUnit
        
        if cryptoData.isMaintenance {
            cell.setMaintenanceView()
        } else {
            cell.setNormalCell()
        }
        
        return cell
    }
    
    
}
