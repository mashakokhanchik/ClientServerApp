//
//  VKPhoto.swift
//  VK Client
//
//  Created by Мария Коханчик on 23.03.2021.
//

import Foundation

class VKPhotoResponse: Decodable {
    let list: [VKPhoto]
}

class VKPhoto: Codable {
    var id: Int = 0
    var ownerID: Int = 0
    var sizes: [Size] = [Size]()
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ownerID = "owner_id"
        case sizes
    }
}

class Size: Codable {
    var type: String = ""
    var url: String = ""
}
