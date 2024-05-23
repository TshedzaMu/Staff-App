//
//  Extensions.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation
import UIKit

public protocol NibLoadable {
   static func loadView() -> Self?
}

extension NibLoadable where Self: UIView {
   static func loadView() -> Self? {
        let bundle = Bundle.main
        let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
        guard let view = views?.first as? Self else { return nil }
        return view
    }
}

extension UIImageView {
    
    func load(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
