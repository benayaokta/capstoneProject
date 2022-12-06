//
//  FavoriteViewController.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import Stevia
import SDWebImage

final class FavoriteViewController: UIViewController {
    
    private let favoriteTableView: UITableView = UITableView()
    private let emptyView: UIView = FavoriteEmptyView()
    private var favoriteData: [AllPairs] = [AllPairs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponent()
        populateFavorite()
    }
    
    private func setupHierarchy() {
        view.subviews {
            favoriteTableView
            emptyView
        }
        
        favoriteTableView.fillContainer()
        
        emptyView.fillContainer()
    }
    
    private func setupComponent() {
        self.title = "Favorite"
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.registerCellClass(type: CapstoneTableViewCell.self)
    }
    
    private func populateFavorite() {
        
        if var data = DatabaseManager.shared.getData(type: [AllPairs].self, forKey: "favorite") {
            favoriteData = data
            emptyView.isHidden = true
            favoriteTableView.reloadData()
        } else {
            emptyView.isHidden = false
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(favoriteData[indexPath.row])
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
        return favoriteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CapstoneTableViewCell.self, for: indexPath) as? CapstoneTableViewCell else { return UITableViewCell() }
        let cryptoData: AllPairs = favoriteData[indexPath.row]
        
        cell.coinDesc.text = cryptoData.coinDescription
        cell.coinImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.coinImage.sd_setImage(with: URL(string: cryptoData.urlLogoPNG), placeholderImage: UIImage(), options: [.progressiveLoad])
        cell.coinCurrencyUnit.text = cryptoData.tradedCurrencyUnit
        
        if cryptoData.isMaintenance == 1 {
            cell.setMaintenanceView()
        } else {
            cell.setNormalCell()
        }
        
        return cell
    }
    
    
}
