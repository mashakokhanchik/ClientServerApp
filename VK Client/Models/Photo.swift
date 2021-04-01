//
//  Photo.swift
//  VK Client
//
//  Created by Мария Коханчик on 30.03.2021.
//

import Foundation
import RealmSwift

class Photo: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    @objc dynamic var sizes: [Size] = [Size]()
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
}

class Size: Object, Codable {
    @objc dynamic var type: String = ""
    @objc dynamic var url: String = ""
}
