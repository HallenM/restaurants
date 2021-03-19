//
//  RestaurantInfoViewController.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit
import Kingfisher

class RestaurantInfoViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UILabel!
    @IBOutlet private weak var descriptionTextField: UITextView!
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var addressTextField: UILabel!
    
    weak var viewModel: RestaurantInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = viewModel?.getName()
        
        descriptionTextField.text = viewModel?.getDescription()
        
        let url = URL(string: viewModel?.getMainImage() ?? "")
        mainImage.kf.setImage(with: url)
        
        let address = viewModel?.getAddress() ?? ""
        addressTextField.text = addressTextField.text ?? "" + " " + address
        
    }

}
