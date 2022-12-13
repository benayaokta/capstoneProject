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
    
    func getProfile() -> AnyPublisher<ProfileEntity, Never> {
        return Future<ProfileEntity, Never> { [weak self] completion in
            guard let self else { return }
            let profile: ProfileEntity = ProfileEntity(name: "Benaya Oktavianus",
                                                       age: 24,
                                                       occupation: "iOS Developer",
                                                       workAt: "Indodax",
                                                       photo: UIImage(named: "profile-pic-dicoding")!)
            self.profileData = profile
            completion(.success(self.profileData))
        }.eraseToAnyPublisher()
    }

    func generateProfileDesc() -> AnyPublisher<String, Never> {
        return Future<String, Never> { [weak self] completion in
            guard let self else { return }
            let initial: String = "Hi, my name is \(self.profileData.name). "
            let age: String = "I am \(self.profileData.age) years old. "
            let job: String = "Currently, I work as \(self.profileData.occupation) at \(self.profileData.workAt)."
            let description: String = initial + age + job
            completion(.success(description))
        }.eraseToAnyPublisher()
    }
}
