//
//  ModalViewController.swift
//  restaurantsManager
//
//  Created by developer on 24.03.2021.
//

import UIKit

protocol ModalViewDelegateProtocol: class {
    func buttonEnabled(isEnabled: Bool)
    func closeModalWindow()
    func errorAlert(title: String, message: String)
}

class ModalViewController: UIViewController {
    
    @IBOutlet private weak var newReview: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    
    var viewModel: ModalViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        nameTextField.delegate = self
        reviewTextView.delegate = self
        
        newReview.layer.cornerRadius = 24
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        viewModel?.setReviewAuthor(reviewAuthor: nameTextField.text ?? "")
    }
    
    @IBAction private func closeWindow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func saveReview(_ sender: Any) {
        viewModel?.didTapButtonAdd()
    }
}

extension ModalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
    }
}

extension ModalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.setReviewText(reviewText: reviewTextView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
                textView.endEditing(true)
                return false
        }
        return true
    }
}

extension ModalViewController: ModalViewDelegateProtocol {
    func buttonEnabled(isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
    }
    
    func closeModalWindow() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
