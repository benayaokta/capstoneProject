//
//  CapstoneTableViewCell.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 24/11/22.
//

import UIKit
import Stevia

public final class CapstoneTableViewCell: UITableViewCell {
    
    public let coinDesc: UILabel = UILabel()
    public let coinImage: UIImageView = UIImageView()
    public let coinCurrencyUnit: UILabel = UILabel()
    public let blockerView: UIView = UIView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        // tes comemnnt
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func commonInit() {
        self.subviews {
            blockerView
            coinImage
            coinDesc
            coinCurrencyUnit
        }
        
        blockerView.fillContainer()
        
        coinImage.width(32).heightEqualsWidth().Leading == self.layoutMarginsGuide.Leading + 8
        coinImage.centerVertically()
        
        coinDesc.centerVertically().Leading == coinImage.Trailing + 16
        
        coinCurrencyUnit.centerVertically().Trailing == self.layoutMarginsGuide.Trailing - 8
        coinCurrencyUnit.left(>=16)
        
        coinCurrencyUnit.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        coinCurrencyUnit.textColor = UIColor.lightGray
    }
    
    public func setMaintenanceView() {
        self.isUserInteractionEnabled = false
        blockerView.backgroundColor = UIColor.lightGray
        blockerView.isHidden = false
        
        coinCurrencyUnit.text = "Maintenance"
        coinCurrencyUnit.textColor = UIColor.white
        coinDesc.textColor = UIColor.white
    }
    
    public func setNormalCell() {
        self.isUserInteractionEnabled = true
        blockerView.isHidden = true
        
        coinCurrencyUnit.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        coinCurrencyUnit.textColor = UIColor.lightGray
        coinDesc.textColor = UIColor.black
    }
}
