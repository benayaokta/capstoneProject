//
//  ProfileViewModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 13/12/22.
//

import UIKit.UIImage
import Combine

class ProfileViewModel: ProfileViewModelProtocol {
    var profileData: ProfileEntity = ProfileEntity()
    var repo: ProfileUseCase
    
    init(repo: ProfileUseCase) {
        self.repo = repo
    }
    
    func getProfile() -> AnyPublisher<ProfileEntity, Never> {
        return Future<ProfileEntity, Never> { [weak self] completion in
            guard let self else { return }
            self.repo.getProfile { [weak self] data in
                guard let self else { return }
                self.profileData = data
                completion(.success(data))
            }
        }.eraseToAnyPublisher()
    }

    func generateProfileDesc() -> AnyPublisher<String, Never> {
        return Future<String, Never> { [weak self] completion in
            guard let self else { return }
            self.repo.generateProfileDesc { data in
                completion(.success(data))
            }
        }.eraseToAnyPublisher()
    }
}
