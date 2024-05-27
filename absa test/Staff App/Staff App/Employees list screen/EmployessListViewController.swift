//  EmployessListViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import UIKit

class EmployessListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private lazy var viewModel = EmployessListViewModel()
    weak var delegate: EmployeeSelectionDelegate?
    
    @IBOutlet private var employeesListTableView: UITableView!
    @IBOutlet private weak var employeeSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onEmployeesFetched = { [weak self] in
            self?.stopActivityIndicator()
            self?.employeesListTableView.reloadData()
        }
        
        viewModel.onFetchFailed = { [weak self] errorMessage in
            self?.stopActivityIndicator()
            self?.showErrorAlert(message: errorMessage)
        }
        
        startActivityIndicator()
        viewModel.getEmployeeList()
    }
    
    private func setupSearchBar() {
        employeeSearchBar.delegate = self
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
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
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let employeeInfo = viewModel.employeeList?[indexPath.row] {
            delegate?.didSelectEmployee(employeeInfo)
            dismiss(animated: true)
        }
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterEmployeeList(with: searchText)
        employeesListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.filterEmployeeList(with: "")
        searchBar.resignFirstResponder()
        employeesListTableView.reloadData()
    }
}
