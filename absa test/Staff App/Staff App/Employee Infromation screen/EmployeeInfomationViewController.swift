//
//  AdditionalInfomationViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation
import UIKit

class EmployeeInfomationViewController: UIViewController {
    
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
//        let vc = ColorViewController() //change this to your class name
//        self.present(vc, animated: true, completion: nil)
    }
    
    private func setupView() {
        profileStackView.applyProfileStyle()
        dateOfBirthTextField.applyProfileStyle()
        placeOfBirthTextField.applyProfileStyle()
        
        profileStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileStackviewClicked)))
    }
}

