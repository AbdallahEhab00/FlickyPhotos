//
//  PhotosModel.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 19/05/2022.
//

import Foundation

struct PhotosModel: Codable {
    let photos: Photos
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}
