//
//  PopViewController.swift
//  restaurantsManager
//
//  Created by developer on 24.03.2021.
//

import UIKit

protocol ModalViewDelegateProtocol: class {
    func buttonEnabled(isEnabled: Bool)
}

class ModalViewController: UIViewController {
    
    @IBOutlet private weak var newReview: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    
    weak var viewModel: ModalViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        //nameTextField.delegate = self
        reviewTextView.delegate = self
        
        newReview.layer.cornerRadius = 24
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        viewModel?.setReviewAuthor(authorReview: nameTextField.text ?? "")
    }
    
    @IBAction func closeWindow(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    @IBAction func saveReview(_ sender: Any) {
        viewModel?.didTapButton()
        view.removeFromSuperview()
    }
}

/*extension ModalViewController: UITextFieldDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel?.setReviewAuthor(authorReview: nameTextField.text ?? "")
    }
}*/

extension ModalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.setReviewText(textReview: reviewTextView.text)
    }
}

extension ModalViewController: ModalViewDelegateProtocol {
    func buttonEnabled(isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
    }
}
