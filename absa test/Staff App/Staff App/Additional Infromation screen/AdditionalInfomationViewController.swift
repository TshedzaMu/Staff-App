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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var profileStackView: UIStackView!
    
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var placeOfBirthTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileStackviewClicked)))
    }
    
    @objc func profileStackviewClicked() {
         print("works")
        let storyBoard : UIStoryboard = UIStoryboard(name: "EmployessListScreen", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! EmployessListViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
}
