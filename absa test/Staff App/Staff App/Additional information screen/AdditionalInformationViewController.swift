//
//  AdditionalInformationViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation
import UIKit

class AdditionalInformationViewController: UIViewController {
    
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var colorNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func genderSegment(_ sender: Any) {
    }
    
    private func setupView() {
        colorNameLabel.applyProfileStyle()
    }
}
