//
//  VKUser.swift
//  VK Client
//
//  Created by Мария Коханчик on 23.03.2021.
//

import Foundation

class VKUserResponse: Decodable {
    let list: [VKUser]
}

class VKUser: Codable {
    var userId = 0
    var firstName = ""
    var lastName = ""
    var avatarURL = ""
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_50"
    }
}
