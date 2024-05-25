//
//  TokenManager.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/25.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    private let tokenKey = "authToken"
    
    private init() {}
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
