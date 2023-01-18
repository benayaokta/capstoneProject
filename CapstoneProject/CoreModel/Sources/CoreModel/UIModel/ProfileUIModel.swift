//
//  ProfileUIModel.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 28/12/22.
//

import UIKit.UIImage

public struct ProfileUIModel {
    public let name: String
    public let age: Int
    public let occupation: String
    public let workAt: String
    public let photo: UIImage
    

    public init(name: String, age: Int, occupation: String, workAt: String, photo: UIImage) {
        self.name = name
        self.age = age
        self.occupation = occupation
        self.workAt = workAt
        self.photo = photo
    }
    
    public init() {
        self.name = ""
        self.age = 0
        self.occupation = ""
        self.workAt = ""
        self.photo = UIImage()
    }
    
    public static func mapEntityToUIModel(model: ProfileEntity) -> ProfileUIModel {
        return ProfileUIModel(name: model.name,
                              age: model.age,
                              occupation: model.occupation,
                              workAt: model.workAt,
                              photo: model.photo)
    }
    
}
