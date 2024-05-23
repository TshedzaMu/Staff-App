//
//  AdditionalInfomationViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation
import UIKit

class AdditionalInfomationViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    @IBOutlet private weak var profileStackView: UIStackView!
    
    @IBOutlet private weak var dateOfBirthTextField: UITextField!
    @IBOutlet private weak var placeOfBirthTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    @objc func profileStackviewClicked() {
         print("works")
        let storyBoard : UIStoryboard = UIStoryboard(name: "EmployessListScreen", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! EmployessListViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    private func setupView() {
        profileStackView.layer.cornerRadius = 5
        profileStackView.layer.borderColor = UIColor.black.cgColor
        profileStackView.layer.borderWidth = 1
        
        dateOfBirthTextField.layer.cornerRadius = 5
        dateOfBirthTextField.layer.borderColor = UIColor.black.cgColor
        dateOfBirthTextField.layer.borderWidth = 1
        
        placeOfBirthTextField.layer.cornerRadius = 5
        placeOfBirthTextField.layer.borderColor = UIColor.black.cgColor
        placeOfBirthTextField.layer.borderWidth = 1
        
        profileStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileStackviewClicked)))
    }
    
    
    
}

