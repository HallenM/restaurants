//
//  ViewController.swift
//  restaurantsManager
//
//  Created by developer on 11.03.2021.
//

import UIKit
import Kingfisher

class RestaurantsListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    weak var viewModel: RestaurantsListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
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
        
        cell.backgroundColor = UIColor(red: 255, green: 247, blue: 232, alpha: 100)
        
        let link = viewModel?.getRestaurantImage(index: indexPath.row)

        let url = URL(string: link ?? "")
        cell.restaurantImage?.kf.setImage(with: url)
        
        cell.restaurantName?.text = viewModel?.getRestaurantName(index: indexPath.row)
        cell.restaurantDescription?.text = viewModel?.getRestaurantDescription(index: indexPath.row)
                
        return cell
    }
}
