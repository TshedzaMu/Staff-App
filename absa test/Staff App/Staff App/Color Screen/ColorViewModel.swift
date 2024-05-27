//  ColorViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

protocol ColorSelectionDelegate: AnyObject {
    func didSelectColor(_ color: Color)
}

class ColorViewModel {
    
    var colorList: [Color]?
    private lazy var service = Service()
    
    var onColorsFetched: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    var numberOfColors: Int {
        return colorList?.count ?? 0
    }
    
    func getColors() {
        service.getColors { [weak self] response, error in
            if let colors = response?.data {
                self?.colorList = colors
                self?.onColorsFetched?()
            } else {
                let errorMessage = error ?? "Unknown error"
                print("Failed to fetch colors, error: \(errorMessage)")
                self?.onFetchFailed?(errorMessage)
            }
        }
    }
}
