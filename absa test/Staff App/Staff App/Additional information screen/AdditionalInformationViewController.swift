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
    @IBOutlet private weak var colorStack: UIStackView!
    @IBOutlet private weak var residentialAddressTexField: UITextField!
    @IBOutlet private weak var genderSegmentControl: UISegmentedControl!
    
    private lazy var viewModel = AdditionalInformationViewModel(dataTransporter: dataTransporter)
    var dataTransporter: EmployeeInformationDataTransporter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        navigationItem.rightBarButtonItem = nextButton
        navigationItem.leftBarButtonItem?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateGenderSegmentControl()
        setupView()
    }
    
    @objc func nextButtonTapped() {
        guard validateInputs() else {
            return
        }
        
        if viewModel.dataTransporter.gender == nil || viewModel.dataTransporter.gender?.isEmpty == true {
            let selectedIndex = genderSegmentControl.selectedSegmentIndex
            if selectedIndex != UISegmentedControl.noSegment {
                let selectedGender = genderSegmentControl.titleForSegment(at: selectedIndex)
                viewModel.dataTransporter.gender = selectedGender
            }
        }
        
        updateDataTransporter()
        performSegue(withIdentifier: "reviewSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewSegue" {
            if let reviewScreenVC = segue.destination as? ReviewScreenViewController {
                reviewScreenVC.dataTransporter = self.dataTransporter
            }
        }
    }

    @IBAction private func genderSegment(_ sender: UISegmentedControl) {
        guard let selectedGender = Gender(rawValue: sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "") else {
            return
        }
        viewModel.dataTransporter.gender = selectedGender.rawValue
    }

    private func updateGenderSegmentControl() {
        guard let gender = Gender(rawValue: viewModel.dataTransporter.gender ?? "") else {
            return
        }
        
        switch gender {
        case .male:
            genderSegmentControl.selectedSegmentIndex = 0
        case .female:
            genderSegmentControl.selectedSegmentIndex = 1
        case .other:
            genderSegmentControl.selectedSegmentIndex = 2
        }
    }

    private func setupView() {
        colorStack.applyProfileStyle()
        residentialAddressTexField.applyProfileStyle()

        assert(colorView.frame.width == colorView.frame.height, "colorView must be a square")
 
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorView.layer.masksToBounds = true
    
        colorStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorStackviewClicked)))
    }
    
    private func validateInputs() -> Bool {
        var validationMessages: [String] = []
        
        if viewModel.selectedColor == nil {
            validationMessages.append("Please select a color.\n")
        }
        
        if residentialAddressTexField.text?.isEmpty ?? true {
            validationMessages.append("Please enter a valid residential address.\n")
        }
        
        if validationMessages.isEmpty {
            return true
        } else {
            let alert = UIAlertController(title: "Validation Error", message: validationMessages.joined(separator: "\n"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    private func updateDataTransporter() {
        viewModel.dataTransporter.residentialAddress = residentialAddressTexField.text
        viewModel.dataTransporter.preferredColor = viewModel.colorName
    }
    
    @objc func colorStackviewClicked() {
        let viewController = ColorViewController()
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
}

extension AdditionalInformationViewController: ColorSelectionDelegate {
    func didSelectColor(_ color: Color) {
        viewModel.selectedColor = color
        colorView.backgroundColor = UIColor(hex: viewModel.color ?? "")
        colorNameLabel.text = viewModel.colorName
    }
}
