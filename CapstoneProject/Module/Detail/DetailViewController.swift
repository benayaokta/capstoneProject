//
//  DetailViewController.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import Stevia
import UIImageColors

final class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModelProtocol?
    private let imageView: UIImageView = UIImageView()
    private let coinUnit: UILabel = UILabel()
    private let textDescription: UILabel = UILabel()
    private let goToCoinGecko: UIButton = UIButton()
    
    let data: AllPairEntity
    
    init(data: AllPairEntity) {
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
    }
    
    private func injection() {
        viewModel = DetailViewModel()
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
        textDescription.text = constructDescription()
        
        imageView.image?.getColors({ [weak self] color in
            guard let self else { return }
            self.goToCoinGecko.backgroundColor = color?.primary
        })
        
        goToCoinGecko.setTitleColor(.white, for: .normal)
        goToCoinGecko.setTitle("See on Coin Gecko", for: .normal)
        goToCoinGecko.layer.cornerRadius = 10
        
        if data.coinGeckoID != "" {
            goToCoinGecko.isHidden = false
            goToCoinGecko.addTarget(self, action: #selector(redirectToCoinGecko), for: .touchUpInside)
        } else {
            goToCoinGecko.isHidden = true
        }
    }
    
    @objc private func redirectToCoinGecko() {
        viewModel?.goToCoinGecko(id: self.data.coinGeckoID)
    }
    
    private func constructDescription() -> String {
        var paragraph: String = String()
        
        let baseCurrency: String = "This coin base currency is \(data.baseCurrency.uppercased()). "
        let tickerID: String = "This coin Ticker ID is \(data.tickerID). "
        
        let hasMemo: String = data.hasMemo ? "has memo." : "does not have a memo."
        let memoParagraph: String = "This coin \(hasMemo) "
        
        let digitPriceRound: String = "This coin have \(data.priceRound) digit(s) price round."
        
        paragraph.append(baseCurrency)
        paragraph.append(tickerID)
        paragraph.append(memoParagraph)
        paragraph.append(digitPriceRound)
        
        return paragraph
    }
    
}
