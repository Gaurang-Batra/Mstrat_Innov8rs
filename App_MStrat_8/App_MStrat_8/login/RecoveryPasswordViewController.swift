//
//  RecoveryPasswordViewController.swift
//  loginpg
//
//  Created by Gaurav on 17/01/25.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var resetCodeTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet var circleview: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUnderline(to: resetCodeTextField)
        addUnderline(to: newPasswordTextField)
        addUnderline(to: confirmPasswordTextField)
        
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
        guard let resetCode = resetCodeTextField.text, !resetCode.isEmpty else {
            showAlert(message: "Please enter the reset code.")
            return
        }
        
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty else {
            showAlert(message: "Please enter a new password.")
            return
        }
        
        guard let confirmPassword = confirmPasswordTextField.text, confirmPassword == newPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }
        
        // Handle password recovery logic here
        showAlert(message: "Password reset successful!")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
