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
    
    private lazy var viewModel = EmployeeInfomationViewModel()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        navigationItem.rightBarButtonItem = nextButton

    }
    
    @objc func nextButtonTapped() {
        performSegue(withIdentifier: "additionalInformationSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        setupView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "additionalInformationSegue" {
            if segue.destination is AdditionalInformationViewController {
            }
        }
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
