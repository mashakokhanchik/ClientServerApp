//
//  VKGroup.swift
//  VK Client
//
//  Created by Мария Коханчик on 23.03.2021.
//

import Foundation

class VKGroupResponse: Decodable {
    let list: [VKGroup]
}

class VKGroup: Codable {
    var id = 0
    var name = ""
    var avatarURL = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_50"
    }
}
