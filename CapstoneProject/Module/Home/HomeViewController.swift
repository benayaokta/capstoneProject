//
//  ViewController.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import UIKit
import Combine
import Stevia
import NVActivityIndicatorView
import SnackBar
import SDWebImage
import CoreModel

final class HomeViewController: UIViewController {
    
    private let tableView: UITableView = UITableView(frame: .zero, style: .plain)
    private var cancellables: Set<AnyCancellable> = []
    private var viewModel: HomeViewModelProtocol!
    private var filteredData: [AllPairUIModel] = [AllPairUIModel]()
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private let indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .black, padding: .zero)
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchResult: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteButtonn()
        injection()
        setupHierarchy()
        setupStyle()
        setupComponent()
        setupCombine()
        getAllPairs()
    }
    
    private func injection() {
        viewModel = HomeViewModel(repo: HomeRepo(service: NetworkService(), storage: DatabaseManager.shared))
    }
    
    private func setupHierarchy() {
        view.subviews {
            tableView
            indicator
        }
        
        tableView.fillContainer()
        indicator.width(40).heightEqualsWidth().centerHorizontally().centerVertically()
    }

    private func setupStyle() {
        self.title = "home.title".localized(id: AppDelegate.mainBundle)
    }
    
    private func setupComponent() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellClass(type: CapstoneTableViewCell.self)
        
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        
        refreshControl.attributedTitle = NSAttributedString(string: "general.pull.refresh".localized(id: AppDelegate.mainBundle))
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupFavoriteButtonn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "profile.title".localized(id: AppDelegate.mainBundle), style: .plain, target: self, action: #selector(goToProfile))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "favorite.title".localized(id: AppDelegate.mainBundle), style: .plain, target: self, action: #selector(goToFavorite))
    }
    
    @objc private func goToFavorite() {
        self.navigationController?.pushViewController(FavoriteViewController(), animated: true)
    }
    
    @objc private func goToProfile() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    @objc private func reloadData() {
        getAllPairs()
    }
    
    private func setupCombine() {
        let loading = viewModel.isLoading
            .receive(on: RunLoop.main)
        loading.sink(receiveValue: { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                self.indicator.startAnimating()
                self.refreshControl.beginRefreshing()
            } else {
                self.indicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        }).store(in: &cancellables)
        
        let search = searchResult
            .receive(on: RunLoop.main)
            .throttle(for: .milliseconds(700),
                      scheduler: DispatchQueue.main,
                      latest: true)
            .map({$0.lowercased()})
        
        search.sink { [weak self] text in
            guard let self else { return }
            if text.isEmpty {
                self.filteredData = self.viewModel.data
            } else {
                self.filteredData = self.viewModel.data.filter({$0.coinID.contains(text) || $0.description.contains(text) || $0.coinSymbol.contains(text)})
            }
            self.tableView.reloadData()
        }.store(in: &cancellables)
        
        let _ = viewModel.errorSnackbar.sink { [weak self] string in
            guard let self else { return }
            CapstoneErrorSnackbar.make(in: self.view, message: "\(string)", duration: .lengthShort).show()
        }.store(in: &cancellables)
        
        let _ = viewModel.normalSnackbar.sink { [weak self] string in
            guard let self else { return }
            CapstoneSnackbar.make(in: self.view, message: "\(string)", duration: .lengthShort).show()
        }.store(in: &cancellables)
        
    }
    
    private func getAllPairs() {
        viewModel.getAllPairs()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    CapstoneErrorSnackbar.make(in: self.view, message: "\(error)", duration: .lengthShort).show()
                case .finished:
                    return
                }
        }, receiveValue: { [weak self] responseData in
            guard let self else { return }
            self.filteredData = responseData
            self.tableView.reloadData()
        }).store(in: &cancellables)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "favorite.action.add".localized(id: AppDelegate.mainBundle)) { _, _, completionHandler in
            self.viewModel.addToFavorite(pair: self.filteredData[indexPath.row])
            
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(DetailViewController(data: self.filteredData[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CapstoneTableViewCell.self, for: indexPath) as? CapstoneTableViewCell else { return UITableViewCell() }
        let cryptoData: AllPairUIModel = filteredData[indexPath.row]
        
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

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchResult.send(text)
    }
}
