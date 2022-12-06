//
//  FavoriteEmptyView.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import Stevia

final class FavoriteEmptyView: UIView {
    
    private let emptyLabel: UILabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init coder must be implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        self.subviews {
            emptyLabel
        }
        
        self.backgroundColor = .white
        
        emptyLabel.centerHorizontally().centerVertically()
        
        emptyLabel.numberOfLines = 0
        emptyLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        emptyLabel.text = "No favorites"
    }
}
