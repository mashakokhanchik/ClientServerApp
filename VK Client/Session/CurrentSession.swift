//
//  CurrentSession.swift
//  VK Client
//
//  Created by Мария Коханчик on 16.03.2021.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var token = ""
    var userId = 0

}
