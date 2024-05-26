//
//  ConfirmationViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation
import UIKit

class ConfirmationViewController: UIViewController {
    
    @IBOutlet private weak var resultsLabel: UILabel!
    @IBOutlet private weak var resultsMessageLabel: UILabel!
    
    var dataTransporter: EmployeeInformationDataTransporter!
    
    private lazy var viewModel = ConfirmationViewModel(dataTransporter: dataTransporter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultsMessageLabel.text = viewModel.message
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue" {
            if segue.destination is LoginViewController {
               
            }
        }
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        TokenManager.shared.clearToken()
        navigateToLogin()
        
    }
    
//    private func navigateToLogin() {
//        let loginViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
//        loginViewController.modalPresentationStyle = .fullScreen
//        loginViewController.modalTransitionStyle = .crossDissolve
//        loginViewController.presentRootViewController()
//    }
    
    private func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.modalTransitionStyle = .crossDissolve
        loginViewController.presentRootViewController()
    }


}
