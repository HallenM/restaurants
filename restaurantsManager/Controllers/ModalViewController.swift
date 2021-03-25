//
//  PopViewController.swift
//  restaurantsManager
//
//  Created by developer on 24.03.2021.
//

import UIKit

class ModalViewController: UIViewController {
    
    @IBOutlet private weak var newReview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newReview.layer.cornerRadius = 24
    }
    
    @IBAction func closeWindow(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    @IBAction func saveReview(_ sender: Any) {
    }
}
