//  EmployessListViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation
import UIKit

class EmployessListViewController: UIViewController {
    
    private lazy var viewModel = EmployessListViewModel()
    weak var delegate: EmployeeSelectionDelegate?
    
    @IBOutlet private var employeesListTableView: UITableView!
    @IBOutlet private weak var employeeSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startActivityIndicator()
        viewModel.onEmployeesFetched = { [weak self] in
            self?.stopActivityIndicator()
            self?.employeesListTableView.reloadData()
        }
        
        viewModel.onFetchFailed = { [weak self] errorMessage in
            self?.stopActivityIndicator()
            self?.showErrorAlert(message: errorMessage)
        }
        
        viewModel.getEmployeeList()
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension EmployessListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeListNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PROFILE_CELL", for: indexPath) as! ProfileViewTableViewCell
        guard let view = EmployeeView.loadView() else { return UITableViewCell() }
        if let employeeInfo = viewModel.employeeList?[indexPath.row],
           let firstName = employeeInfo.first_name,
           let lastName = employeeInfo.last_name {
            
            view.setupView(name: "\(firstName) \(lastName)",
                           email: employeeInfo.email ?? "",
                           urlString: employeeInfo.avatar ?? "")
        }
        cell.contentView.addSubview(view)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let employeeInfo = viewModel.employeeList?[indexPath.row] {
            delegate?.didSelectEmployee(employeeInfo)
            self.dismiss(animated: true)
        }
    }
}

extension EmployessListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterTableView(text: "")
        searchBar.resignFirstResponder()
        employeesListTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterTableView(text: searchText)
        employeesListTableView.reloadData()
    }
}
