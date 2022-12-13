//
//  ProfileViewController.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 13/12/22.
//

import UIKit
import Stevia
import Combine

class ProfileViewController: UIViewController {
    private let profilePicture: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private var viewModel: ProfileViewModelProtocol!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injection()
        setupCombine()
        setupHierarchy()
        setupStyle()
    }
    
    private func injection() {
        viewModel = ProfileViewModel()
    }
    
    private func setupCombine() {
        let _ = viewModel.getProfile().sink { [weak self] value in
            guard let self else { return }
            self.viewModel.generateProfileDesc().sink { text in
                self.profilePicture.image = value.photo
                self.nameLabel.text = value.name
                self.descriptionLabel.text = text
            }.store(in: &self.cancellables)
        }.store(in: &cancellables)
    }
    
    private func setupHierarchy() {
        view.subviews {
            profilePicture
            nameLabel
            descriptionLabel
        }
        
        profilePicture.centerHorizontally().Top == self.view.layoutMarginsGuide.Top + 20
        profilePicture.width(<=160).height(<=240)
        
        nameLabel.centerHorizontally().fillHorizontally(padding: 16).Top == profilePicture.Bottom + 16
        descriptionLabel.centerHorizontally().fillHorizontally(padding: 16).bottom(>=16).Top == nameLabel.Bottom + 16
    }
    
    private func setupStyle() {
        self.title = "Profile"
        self.view.backgroundColor = .white
        
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textAlignment = .center

        descriptionLabel.numberOfLines = 0
    }
}
