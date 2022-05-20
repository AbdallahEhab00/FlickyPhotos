//
//  parseJson.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 19/05/2022.
//

import Foundation

struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
