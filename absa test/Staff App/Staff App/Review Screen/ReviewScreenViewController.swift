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
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var dateOfBirthLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var residentialAddressLabel: UILabel!
    @IBOutlet private weak var placeOfBirth: UILabel!
    @IBOutlet private weak var prefferedColor: UILabel!
    
    @IBOutlet private weak var additionalInfoStack: UIStackView!
    @IBOutlet private weak var submitButton: UIButton!
    
    var dataTransporter: EmployeeInformationDataTransporter!
    
    private lazy var viewModel = ReviewScreenViewModel(dataTransporter: dataTransporter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewWithData()
        print(dataTransporter.description)
        setupView()
    }
    
    private func setupView() {
        personalDetailsStack.applyProfileStyle()
        additionalInfoStack.applyProfileStyle()
        submitButton.applyProfileStyle()
    }
    
    private func updateViewWithData() {
        profileImage.load(urlString: viewModel.imageURL)
        nameLabel.text = viewModel.fullName
        genderLabel.text = viewModel.gender
        dateOfBirthLabel.text = viewModel.dateOfBirth
        emailLabel.text = viewModel.email
        residentialAddressLabel.text = viewModel.residentialAddress
        placeOfBirth.text =  viewModel.placeOfBirth
        prefferedColor.text =  viewModel.prefferedColor
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmationSegue" {
            if let confirmationVC = segue.destination as? ConfirmationViewController {
                confirmationVC.dataTransporter = self.dataTransporter
            }
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        startActivityIndicator()
        viewModel.updateDetails()
        viewModel.onUpdateComplete = { [weak self] in
            if self?.viewModel.updateTimeStamp != nil {
                self?.stopActivityIndicator()
                self?.dataTransporter.updateTimeStamp = self?.viewModel.updateTimeStamp
                self?.performSegue(withIdentifier: "confirmationSegue", sender: nil)
            }
        }
    }
}
