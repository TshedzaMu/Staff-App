//
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
    
    var numberOfColors: Int?
    var colorList: [Color]?
    
    private lazy var service = Service()
    
    var onColorsFetched: (() -> Void)?
    
    func getColors() {
        service.getColors { [weak self] response, error in
            if let response = response {
                if let colors = response.data,
                   let numberOfColors = response.total {
                    self?.numberOfColors = numberOfColors
                    self?.colorList = colors
                    self?.onColorsFetched?()
                }
            } else {
                print("Failed to fetch colors, error: \(error ?? "Unknown error")")
            }
        }
    }
}

