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
    
    var dataTransporter = EmployeeInformationDataTransporter()
    private lazy var viewModel = EmployeeInfomationViewModel(dataTransporter: dataTransporter)
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
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
        if validateInputs() {
            updateDataTransporter()
            performSegue(withIdentifier: "additionalInformationSegue", sender: nil)
        }
    }
    
    @objc func profileStackviewClicked() {
        print("works")
        let storyBoard: UIStoryboard = UIStoryboard(name: "EmployessListScreen", bundle: nil)
        let employeeViewController = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! EmployessListViewController
        employeeViewController.delegate = self
        self.present(employeeViewController, animated: true, completion: nil)
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateOfBirthTextField.text = dateFormatter.string(from: sender.date)
    }
    
    private func setupView() {
        dateOfBirthTextField.inputView = datePicker
        profileStackView.applyProfileStyle()
        placeOfBirthTextField.applyProfileStyle()
        dateOfBirthTextField.applyProfileStyle()
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
        viewModel.dataTransporter.selectedEmployee = viewModel.selectedEmployee
    }
    
    private func validateInputs() -> Bool {
        var errorMessage = ""
        
        if viewModel.selectedEmployee == nil {
            errorMessage += "Please select an employeer.\n\n"
        }
        
        if let dateOfBirth = dateOfBirthTextField.text, !isValidDateOfBirth(dateOfBirth) {
            errorMessage += "Please enter a valid date of birth in the format YYYY-MM-DD.\n\n"
        }
        
        if placeOfBirthTextField.text?.isEmpty ?? true {
            errorMessage += "Please enter the place of birth.\n\n"
        }
        
        if !errorMessage.isEmpty {
            showAlert(message: errorMessage)
            return false
        }
        
        return true
    }
    
    private func isValidDateOfBirth(_ dateOfBirth: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateOfBirth) != nil
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
