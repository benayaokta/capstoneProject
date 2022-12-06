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

class HomeViewController: UIViewController {
    
    private let tableView: UITableView = UITableView(frame: .zero, style: .plain)
    private var cancellables: Set<AnyCancellable> = []
    private var viewModel: HomeViewModelProtocol?
    private var data: [AllPairs] = [AllPairs]()
    private var filteredData: [AllPairs] = [AllPairs]()
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
        indicator.startAnimating()
        getAllPairs()
    }
    
    private func injection() {
        viewModel = HomeViewModel(repo: NewHomeRepo())
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
        self.title = "Crypto List"
    }
    
    private func setupComponent() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellClass(type: CapstoneTableViewCell.self)
        
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupFavoriteButtonn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(goToFavorite))
    }
    
    @objc private func goToFavorite() {
        print("go to favorite")
//        DatabaseManager.shared.setFavorite(String: "tes tes tes")
//        DatabaseManager.shared.deleteFavorite()
        self.navigationController?.pushViewController(FavoriteViewController(), animated: true)
    }
    
    @objc private func reloadData() {
        getAllPairs()
    }
    
    private func setupCombine() {
//        let _ = message
//            .sink { error in
//                print("error \(error)")
//            } receiveValue: { value in
//                print("value \(value)")
//            }.store(in: &cancellables)
//
//        let newSubs = NotificationCenter.Publisher(center: .default, name: Notification.Name("testes"))
//            .map({ ($0.object as? Int) ?? 0 })
//
//
//        newSubs.sink { [weak self] value in
//            print("value notificatin center \(value)")
//            if value % 2 != 0 {
//                self?.tableView.backgroundColor = .red
//            } else {
//                self?.tableView.backgroundColor = .blue
//            }
//        }.store(in: &cancellables)
        
        let loading = viewModel?.isLoading
            .receive(on: RunLoop.main)
        loading?.sink(receiveValue: { [weak self] isLoading in
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
                self.filteredData = self.data
            } else {
                self.filteredData = self.data.filter({$0.coinID.contains(text) || $0.coinDescription.contains(text) || $0.coinSymbol.contains(text)})
            }
            self.tableView.reloadData()
        }.store(in: &cancellables)
        
    }
    
    private func getAllPairs() {
        viewModel?.getAllPairs()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    SnackBar.make(in: self.view, message: "\(error)", duration: .lengthShort).show()
                case .finished:
                    return
                }
        }, receiveValue: { [weak self] responseData in
            guard let self else { return }
            self.data = responseData
            self.filteredData = self.data
            self.tableView.reloadData()
        }).store(in: &cancellables)
    }
    
    private func addToFavorite(index: IndexPath) {
//        DatabaseManager.shared.setFavorite(pair: self.filteredData[index.row]) { success, error in
//            guard error == nil else {
//                if let error {
//                    SnackBar.make(in: self.view, message: error.rawValue, duration: .lengthShort).show()
//                }
//                return
//            }
//            SnackBar.make(in: self.view, message: "Success add to favorite", duration: .lengthShort).show()
//
//        }
        if var array = DatabaseManager.shared.getData(type: [AllPairs].self, forKey: "favorite") {
            if !array.contains(where: {$0.coinID == self.filteredData[index.row].coinID}) {
                array.append(self.filteredData[index.row])
                DatabaseManager.shared.setData(value: array, key: "favorite")
                CapstoneSnackbar.make(in: self.view, message: "Success add to favorite", duration: .lengthShort).show()

            } else {
                CapstoneSnackbar.make(in: self.view, message: "Item already on favorite", duration: .lengthShort).show()
            }
           
        } else {
            var newArray: [AllPairs] = [AllPairs]()
            newArray.append(self.filteredData[index.row])
            DatabaseManager.shared.setData(value: newArray, key: "favorite")
            CapstoneSnackbar.make(in: self.view, message: "Success add to favorite", duration: .lengthShort).show()
        }        
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Add To Favorite") { _, _, completionHandler in
            self.addToFavorite(index: indexPath)
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
        // go to detail
        
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
        let cryptoData: AllPairs = filteredData[indexPath.row]
        
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

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchResult.send(text)
    }
}
