//
//  ViewController.swift
//  restaurantsManager
//
//  Created by developer on 11.03.2021.
//

import UIKit

class RestaurantsListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    weak var viewModel: RestaurantsListViewModel?
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // Add refreshControll (TableView has own refreshControl)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating...")
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        // Send request for VM to initialize data for table
        viewModel?.initData(completion: {
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
        })
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.addTarget(self, action: #selector(openKeyBoard), for: .touchDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // Sender for refreshing data in table
    @objc func handleRefreshControl(sender: AnyObject) {
        viewModel?.getDataForTable(completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        })
    }
    
    // Sender for textField text changing
    @objc func textFieldDidChange(sender: AnyObject) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(findRestaurant), userInfo: nil, repeats: false)
    }
    
    // Callback for timer
    @objc func findRestaurant(sender: AnyObject) {
        guard let searchText = textField.text else { return }
        
        viewModel?.searchRestaurants(searchText: searchText, completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    @objc func openKeyBoard(sender: AnyObject) {
        // Add in view tapGestureRecognizer
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // Sender for single tap on view anywhere except textField
    @objc func handleTap(sender: UITapGestureRecognizer) {
        textField.endEditing(true)
        self.view.removeGestureRecognizer(self.view.gestureRecognizers?.last ?? UIGestureRecognizer())
    }
}

extension RestaurantsListViewController: RestaurantsListViewDelegateProtocol {
    
}

extension RestaurantsListViewController: UITableViewDelegate {
    // Method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell: \(indexPath.row + 1), name: \(viewModel?.getRestaurant(index: indexPath.row))")
        viewModel?.didTapOnCell(with: indexPath.row)
    }
    
    // Get the height to use for a row in a specified location.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
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

extension RestaurantsListViewController: UITextFieldDelegate {
    func textFieldNewSymbol() {}
}
