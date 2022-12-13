//
//  ProfileProtocol.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 13/12/22.
//

import Combine

protocol ProfileViewModelProtocol {
    var profileData: ProfileEntity { get set }

    func getProfile() -> AnyPublisher<ProfileEntity, Never>
    func generateProfileDesc() -> AnyPublisher<String, Never>
}
