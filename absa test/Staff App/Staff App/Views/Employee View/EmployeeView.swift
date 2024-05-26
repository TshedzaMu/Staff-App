//
//  EmployeeView.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation
import UIKit

class EmployeeView: UIView, NibLoadable {
    
   @IBOutlet private weak var profileImageView: UIImageView!
   @IBOutlet private weak var nameLabel: UILabel!
   @IBOutlet private weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func styling() {
        self.layer.cornerRadius = 5
    }
    
    func setupView(name: String, email: String, urlString: String) {
        styling()
        profileImageView.load(urlString: urlString)
        nameLabel.text = name
        emailLabel.text = email
    }
}
