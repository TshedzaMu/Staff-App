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
    
    var dataTransporter =  EmployeeInformationDataTransporter()
    

    private lazy var viewModel = EmployeeInfomationViewModel(dataTransporter: dataTransporter)
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        navigationItem.rightBarButtonItem = nextButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        print(TokenManager.shared.getToken())
        setupView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "additionalInformationSegue" {
            if let additionalInfoVC = segue.destination as? AdditionalInformationViewController {
                additionalInfoVC.dataTransporter = self.dataTransporter
            }
        }
    }
    
    @objc func nextButtonTapped() {
        updateDataTransporter()
        performSegue(withIdentifier: "additionalInformationSegue", sender: nil)
    }
    
    @objc func profileStackviewClicked() {
         print("works")
        let storyBoard : UIStoryboard = UIStoryboard(name: "EmployessListScreen", bundle:nil)
        let employeeViewController = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! EmployessListViewController
        employeeViewController.delegate = self
        self.present(employeeViewController, animated:true, completion:nil)
    }
    
    private func setupView() {
        profileStackView.applyProfileStyle()
        dateOfBirthTextField.applyProfileStyle()
        placeOfBirthTextField.applyProfileStyle()
        
        profileStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileStackviewClicked)))
    }
    
    private func updateDataTransporter() {
        viewModel.dataTransporter.id = viewModel.selectedEmployee?.id
        viewModel.dataTransporter.email = viewModel.selectedEmployee?.email
        viewModel.dataTransporter.firstName = viewModel.selectedEmployee?.first_name
        viewModel.dataTransporter.lastName = viewModel.selectedEmployee?.last_name
        viewModel.dataTransporter.avatar = viewModel.selectedEmployee?.avatar
        viewModel.dataTransporter.dateOfBirth = dateOfBirthTextField.text
        viewModel.dataTransporter.placeOfBirth = placeOfBirthTextField.text
    }
}

extension EmployeeInfomationViewController: EmployeeSelectionDelegate {
    func didSelectEmployee(_ employee: Employee) {
        viewModel.selectedEmployee = employee
        updateViewWithDetails()
    }
    
     private func updateViewWithDetails() {
        profileImageView.load(urlString: viewModel.imageURL)
        nameLabel.text = viewModel.fullName
        emailLabel.text = viewModel.email
    }
}
