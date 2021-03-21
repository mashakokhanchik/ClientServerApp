//
//  CurrentSession.swift
//  VK Client
//
//  Created by Мария Коханчик on 16.03.2021.
//

import Foundation

class Session {
    
    static let instance = Session()

    var token: String = ""
    var userId = Int()
    
    private init() {}
}
