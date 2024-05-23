//
//  ProfileViewTableViewCell.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation
import UIKit

class ProfileViewTableViewCell: UITableViewCell {
    @IBOutlet weak var employeeView: EmployeeView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
