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
    
    private lazy var viewModel = AdditionalInformationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        navigationItem.rightBarButtonItem = nextButton
        navigationItem.leftBarButtonItem?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    @objc func nextButtonTapped() {
        performSegue(withIdentifier: "reviewSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewSegue" {
            if segue.destination is ReviewScreenViewController {
            }
        }
    }

    @IBAction private func genderSegment(_ sender: Any) {
    }
    
    private func setupView() {
        
        colorStack.applyProfileStyle()
        residentialAddressTexField.applyProfileStyle()

        assert(colorView.frame.width == colorView.frame.height, "colorView must be a square")
 
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorView.layer.masksToBounds = true
    
        colorStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorStackviewClicked)))
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
