//
//  LoginViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func didLoginSuccessfully()
    func didFailToLogin(withError error: String)
}

class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    private lazy var service = Service()
    
    func login(email: String, password: String) {
        let loginRequest = LoginRequest(email: email, password: password)
        service.login(body: loginRequest) { response, error in
            if let response = response {
                print("Login successful, token: \(response.token)")
                TokenManager.shared.saveToken(response.token ?? "")
                if response.token == nil {
                    self.delegate?.didFailToLogin(withError: "Invalid token")
                } else {
                    self.delegate?.didLoginSuccessfully()
                }
            } else {
                self.delegate?.didFailToLogin(withError: error ?? "Unknown error")
            }
        }
    }
}
