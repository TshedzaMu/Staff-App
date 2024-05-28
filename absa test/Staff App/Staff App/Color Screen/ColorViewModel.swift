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
    lazy var interactor: StaffInteractorProtocol = StaffInteractor(service: Service())
    
    var onColorsFetched: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    var numberOfColors: Int {
        return colorList?.count ?? 0
    }
    
    func getColors() {
        interactor.getColors { [weak self] result in
            switch result {
            case .success(let response):
                self?.colorList = response.data
                self?.onColorsFetched?()
            case .failure(let error):
                let errorMessage = error.localizedDescription
                print("Failed to fetch colors, error: \(errorMessage)")
                self?.onFetchFailed?(errorMessage)
            }
        }
    }
}

