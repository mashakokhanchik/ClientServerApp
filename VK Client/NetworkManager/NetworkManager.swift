//
//  NetworkManager.swift
//  VK Client
//
//  Created by Мария Коханчик on 20.03.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
    }
    
    func loadGroups(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    func searchGroups(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": "swiftbook",
            "v": "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    func loadFriends(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "fields": "nickname",
            "count": 100,
            "v": "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    func loadPhotos(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.get"
        
        let params: Parameters = [
            "access_token": token,
            "album_id": "profile",
            "extended": 1,
            "v": "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
}
