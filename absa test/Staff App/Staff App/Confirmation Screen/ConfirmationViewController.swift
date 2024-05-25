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
    }
}
