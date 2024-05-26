//
//  TextInputView.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/26.
//

import Foundation
import UIKit

class TextInputView: UIView {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TextInputView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}

