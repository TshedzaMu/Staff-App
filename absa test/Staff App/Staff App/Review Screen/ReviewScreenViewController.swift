//
//  ReviewScreenViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation
import UIKit

class ReviewScreenViewController: UIViewController {
    
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var personalDetailsStack: UIStackView!
    @IBOutlet private weak var informationLabel: UILabel!
    @IBOutlet private weak var additionaInformationLabel: UILabel!
    
    @IBOutlet private weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        personalDetailsStack.applyProfileStyle()
        additionaInformationLabel.applyProfileStyle()
        submitButton.applyProfileStyle()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmationSegue" {
            if segue.destination is ReviewScreenViewController {
            }
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "confirmationSegue", sender: nil)
    }
}
