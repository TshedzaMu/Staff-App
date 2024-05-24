//
//  LoginViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation

class LoginViewModel {
    
    let service = Service()
    let loginRequest = LoginRequest(email: "eve.holt@reqres.in", password: "cityslicka")
    
    func login()  {
        service.login(body: loginRequest) { response, error in
            if let response = response {
                print("Login successful, token: \(response.token)")
            } else {
                print("Login failed, error: \(error ?? "Unknown error")")
            }
        }
    }
}
