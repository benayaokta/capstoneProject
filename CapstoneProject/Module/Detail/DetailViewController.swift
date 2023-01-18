//
//  DetailViewController.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import Stevia
import SDWebImage
import Combine
import CoreModel

final class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModelProtocol?
    private let imageView: UIImageView = UIImageView()
    private let coinUnit: UILabel = UILabel()
    private let textDescription: UILabel = UILabel()
    private let goToCoinGecko: UIButton = UIButton()
    var cancellables: Set<AnyCancellable> = []
    
    let data: AllPairUIModel
    
    init(data: AllPairUIModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init coder must be initialize")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injection()
        setupHierarchy()
        setupComponent()
        setupCombine()
    }
    
    private func injection() {
        viewModel = DetailViewModel(repo: DetailRepo())
    }
    
    private func setupHierarchy() {
        self.view.subviews {
            imageView
            coinUnit
            textDescription
            goToCoinGecko
        }
        
        imageView.centerHorizontally().fillHorizontally(padding: 120).heightEqualsWidth().Top == self.view.layoutMarginsGuide.Top + 20
        coinUnit.centerHorizontally().Top == imageView.Bottom + 8
        textDescription.fillHorizontally(padding: 16).centerHorizontally().Top == coinUnit.Bottom + 16
        
        goToCoinGecko.top(>=16).fillHorizontally(padding: 16).height(50).Bottom == self.view.safeAreaLayoutGuide.Bottom - 16
    }
    
    private func setupComponent() {
        self.title = data.description
        self.view.backgroundColor = .white
        
        imageView.sd_setImage(with: URL(string: self.data.imageURL), placeholderImage: UIImage.init(systemName: "photo"), options: [.progressiveLoad])
        coinUnit.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        coinUnit.text = self.data.tradeCurrencyUnit
        
        textDescription.numberOfLines = 0
        
        goToCoinGecko.backgroundColor = .systemBlue
        goToCoinGecko.setTitleColor(.white, for: .normal)
        goToCoinGecko.setTitle("general.see.on.coin.gecko".localized(id: "com.dicoding.expert.CapstoneProject"), for: .normal)
        goToCoinGecko.layer.cornerRadius = 10
        
        if data.coinGeckoID != "" {
            goToCoinGecko.isHidden = false
            goToCoinGecko.addTarget(self, action: #selector(redirectToCoinGecko), for: .touchUpInside)
        } else {
            goToCoinGecko.isHidden = true
        }
    }
    
    private func setupCombine() {
        viewModel?.constructDescription(pair: data).sink(receiveValue: { [weak self] desc in
            guard let self else { return }
            self.textDescription.text = desc
        }).store(in: &cancellables)
    }
    
    @objc private func redirectToCoinGecko() {
        viewModel?.goToCoinGecko(id: self.data.coinGeckoID)
    }
    
}
