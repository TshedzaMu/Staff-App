//  ColorViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import UIKit

class ColorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var viewModel = ColorViewModel()
    weak var delegate: ColorSelectionDelegate?
    
    private let tableView = UITableView()
    private let cellIdentifier = "ColorCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableHeaderView()
        
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startActivityIndicator()
        
        viewModel.onColorsFetched = { [weak self] in
            self?.stopActivityIndicator()
            self?.tableView.reloadData()
        }
        
        viewModel.onFetchFailed = { [weak self] errorMessage in
            self?.stopActivityIndicator()
            self?.showErrorAlert(message: errorMessage)
        }
        
        viewModel.getColors()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupTableHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        
        let titleLabel = UILabel()
        titleLabel.text = "Select Preferred Color"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        tableView.tableHeaderView = headerView
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfColors
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ColorTableViewCell else {
            return UITableViewCell()
        }
        if let colorInfo = viewModel.colorList?[indexPath.row] {
            cell.colorView.backgroundColor = UIColor(hex: colorInfo.color ?? "")
            cell.colorNameLabel.text = colorInfo.name
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let colorInfo = viewModel.colorList?[indexPath.row] {
            delegate?.didSelectColor(colorInfo)
            dismiss(animated: true)
        }
    }
}
