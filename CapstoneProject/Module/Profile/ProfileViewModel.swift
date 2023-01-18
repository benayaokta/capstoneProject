////
////  ProfileViewModel.swift
////  CapstoneProject
////
////  Created by Benaya Oktavianus on 13/12/22.
////
//
//import UIKit.UIImage
//import Combine
//import CoreModel
//
//class ProfileViewModel: ProfileViewModelProtocol {
//    var profileData: ProfileUIModel = ProfileUIModel()
//    var cancellables: Set<AnyCancellable> = []
//    var repo: ProfileUseCase
//    
//    init(repo: ProfileUseCase) {
//        self.repo = repo
//    }
//    
//    func getProfile() -> AnyPublisher<ProfileUIModel, Never> {
//        return Future<ProfileUIModel, Never> { [weak self] completion in
//            guard let self else { return }
//            self.repo.getProfile().sink { data in
//                let uiModel = ProfileUIModel.mapEntityToUIModel(model: data)
//                self.profileData = uiModel
//                completion(.success(uiModel))
//            }.store(in: &self.cancellables)
//        }.eraseToAnyPublisher()
//    }
//
//    func generateProfileDesc() -> AnyPublisher<String, Never> {
//        return Future<String, Never> { [weak self] completion in
//            guard let self else { return }
//            self.repo.generateProfileDesc().sink { data in
//                completion(.success(data))
//            }.store(in: &self.cancellables)
//        }.eraseToAnyPublisher()
//    }
//}
