//
//  ForgotPasswordViewController.swift
//  loginpg
//
//  Created by Gaurav on 17/01/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet var circleview: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUnderline(to: emailTextField)
        
        for view in circleview {
                   // Ensure the view is a square by setting equal width and height
                   let size = min(view.frame.width, view.frame.height)
                   view.frame.size = CGSize(width: size, height: size)
                   
                   // Make the view circular
                   view.layer.cornerRadius = size / 2
                   view.layer.masksToBounds = true
               }
               
           }
           
           // Function to add underline to a text field
        private func addUnderline(to textField: UITextField) {
               let underline = CALayer()
               underline.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
               underline.backgroundColor = UIColor.black.cgColor
               textField.borderStyle = .none
               textField.layer.addSublayer(underline)
           }
    
    @IBAction func sendEmailButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        // Perform segue to the Recovery Password screen
        performSegue(withIdentifier: "goToRecoveryPassword", sender: self)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

