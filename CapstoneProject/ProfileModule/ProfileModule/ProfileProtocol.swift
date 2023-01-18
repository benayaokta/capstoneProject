//
//  ProfileProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 13/12/22.
//

import Combine
import CoreModel

protocol ProfileViewModelProtocol {
    var profileData: ProfileUIModel { get set }
    var repo: ProfileUseCase { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
    func getProfile() -> AnyPublisher<ProfileUIModel, Never>
    func generateProfileDesc() -> AnyPublisher<String, Never>
}

protocol ProfileUseCase {
    var profileData: ProfileEntity { get set }
    
    func getProfile() -> AnyPublisher<ProfileEntity, Never>
    func generateProfileDesc() -> AnyPublisher<String, Never>
}
