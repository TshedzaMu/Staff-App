//
//  EmployeeView.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation
import UIKit

class EmployeeView: UIView, NibLoadable {
    
  //  @IBOutlet weak var flagImageView: UIImageView!
  //  @IBOutlet weak var countryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func styling() {
        self.layer.cornerRadius = 5
    }
    
    func setupView(countryName: String, urlString: String) {
        styling()
    //    flagImageView.load(urlString: urlString)
     //   countryNameLabel.text = countryName
    }
}
