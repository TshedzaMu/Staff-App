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
    @IBOutlet weak var colorStack: UIStackView!
    
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
        colorNameLabel.applyProfileStyle()
    
        colorStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorStackviewClicked)))
    }
    
    @objc func colorStackviewClicked() {
        let viewController = ColorViewController()
        self.present(viewController, animated: true, completion: nil)
    }
}
