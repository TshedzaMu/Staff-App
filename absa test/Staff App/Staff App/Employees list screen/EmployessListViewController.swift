//
//  EmployessListViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation
import UIKit

class EmployessListViewController: UIViewController {
    
    @IBOutlet private var EmployeesListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EmployessListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return viewModel.coutriesListNumber
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PROFILE_CELL", for: indexPath) as! ProfileViewTableViewCell
        guard let view = EmployeeView.loadView() else { return UITableViewCell() }
//        view.setupView(countryName: viewModel.countriesList?[indexPath.row].name ?? "", urlString: viewModel.countriesList?[indexPath.row].flags?.png ?? "")
        cell.contentView.addSubview(view)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCountry =  viewModel.countriesList?[indexPath.row]
//        delegate?.transitionToHomeScreen(with: selectedCountry)
//    }
}

