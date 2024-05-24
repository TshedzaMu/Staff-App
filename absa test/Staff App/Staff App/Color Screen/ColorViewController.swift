//
//  ColorViewController.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation
import UIKit

class ColorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    let cellIdentifier = "ColorCell"
    let colors: [(name: String, color: UIColor)] = [
        (name: "Red", color: .red),
        (name: "Green", color: .green),
        (name: "Blue", color: .blue),
        (name: "Yellow", color: .yellow),
        (name: "Purple", color: .purple)
    ]

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
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ColorTableViewCell else {
            return UITableViewCell()
        }
        let colorInfo = colors[indexPath.row]
        cell.colorView.backgroundColor = colorInfo.color
        cell.colorNameLabel.text = colorInfo.name
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let colorInfo = colors[indexPath.row]
        print("Selected \(colorInfo.name)")
    }
}

