//
//  ColorViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation
import UIKit

class ColorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var viewModel = ColorViewModel()
    weak var delegate: ColorSelectionDelegate?
    
    var tableView: UITableView!
    let cellIdentifier = "ColorCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
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
        
        viewModel.getColors()
    }
    
    func setupTableHeaderView() {
          let headerView = UIView()
          headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
          
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
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfEmployees = viewModel.numberOfColors else { return 0 }
        return numberOfEmployees
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
            self.dismiss(animated: true)
        }
    }
}

