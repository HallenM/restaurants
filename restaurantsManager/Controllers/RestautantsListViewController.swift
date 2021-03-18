//
//  ViewController.swift
//  restaurantsManager
//
//  Created by developer on 11.03.2021.
//

import UIKit

class RestaurantsListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    weak var viewModel: RestaurantsListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // Add refreshControll (TableView has own refreshControl)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating...")
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        viewModel?.initData(completion: {
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
        })
    }
    
    @objc func handleRefreshControl(sender: AnyObject) {
        
    }
}

extension RestaurantsListViewController: RestaurantsListViewDelegateProtocol {
    
}

extension RestaurantsListViewController: UITableViewDelegate {
    // Method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // Get the height to use for a row in a specified location.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension RestaurantsListViewController: UITableViewDataSource {
    // Get number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getRestaurantsCount() ?? 0
    }
    
    // Create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomTableViewCell else {
            return CustomTableViewCell()
        }
        
        let link = viewModel?.getRestaurantImage(index: indexPath.row)
        guard let url = URL(string: link ?? "") else {
            return CustomTableViewCell()
        }
        guard let name = viewModel?.getRestaurantName(index: indexPath.row) else {
            return CustomTableViewCell()
        }
        guard let description = viewModel?.getRestaurantDescription(index: indexPath.row)  else {
            return CustomTableViewCell()
        }
        
        cell.customCell(cell: cell, imageURL: url, name: name, description: description)
                
        return cell
    }
}
