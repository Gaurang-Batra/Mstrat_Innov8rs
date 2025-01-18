//
//  LoginViewController.swift
//  loginpg
//
//  Created by Gaurav on 17/01/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Connect these outlets from your storyboard
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUnderline(to: emailTextField)
               addUnderline(to: passwordTextField)
           }
           
           // Function to add underline to a text field
        private func addUnderline(to textField: UITextField) {
               let underline = CALayer()
               underline.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
               underline.backgroundColor = UIColor.black.cgColor
               textField.borderStyle = .none
               textField.layer.addSublayer(underline)
           }
    
    // Action for the Login button
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
                    showAlert(message: "Please enter your email.")
                    return
                }
                
                // Validate password
                guard let password = passwordTextField.text, !password.isEmpty else {
                    showAlert(message: "Please enter your password.")
                    return
                }
                
                // If both fields are filled, proceed to the next screen
                if let signupVC = storyboard?.instantiateViewController(withIdentifier: "homescreen") {
                    navigationController?.pushViewController(signupVC, animated: true)
                } else {
                    showAlert(message: "Unable to navigate to the next screen. Please check your storyboard configuration.")
                }
    }
    
    // Helper function to show alert messages
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Input Required", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

