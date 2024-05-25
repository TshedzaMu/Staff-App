//
//  ViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private lazy var viewModel: LoginViewModel = {
           let viewModel = LoginViewModel()
           viewModel.delegate = self
           return viewModel
       }()
       
       override func viewDidLoad() {
           super.viewDidLoad()
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           setupView()
       }
       
       private func setupView() {
           emailTextField.applyProfileStyle()
           passwordTextField.applyProfileStyle()
           loginButton.applyProfileStyle()
       }
       
       @IBAction func loginButtonTapped(_ sender: Any) {
           guard let email = emailTextField.text, isValidEmail(email) else {
               showAlert(message: "Please enter a valid email address")
               return
           }
           
           guard let password = passwordTextField.text, !password.isEmpty else {
               showAlert(message: "Please enter a password")
               return
           }
           
           viewModel.login(email: email, password: password)
       }
       
       private func isValidEmail(_ email: String) -> Bool {
           // Simple regex for validating email
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
       }
       
       private func showAlert(message: String) {
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
   }

extension LoginViewController: LoginViewModelDelegate {
    func didLoginSuccessfully() {
        if TokenManager.shared.getToken() != nil {
            performSegue(withIdentifier: "employeeInformationSegue", sender: self)
        } else {
            showAlert(message: "Invalid token")
        }
    }
    
    func didFailToLogin(withError error: String) {
        showAlert(message: "Login failed: \(error)")
    }
}

