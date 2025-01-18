//
//  SignUpViewController.swift
//  loginpg
//
//  Created by Gaurav on 17/01/25.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // Connect these outlets from your storyboard
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUnderline(to: emailTextField)
        addUnderline(to: nameTextField)
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
    
    // Action for the Sign Up button
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // Validate name
        guard let name = nameTextField.text, !name.isEmpty else {
                    showAlert(message: "Please enter your name.")
                    return
                }
                
                // Validate email
                guard let email = emailTextField.text, !email.isEmpty else {
                    showAlert(message: "Please enter your email.")
                    return
                }
                
                // Validate password
                guard let password = passwordTextField.text, !password.isEmpty else {
                    showAlert(message: "Please enter your password.")
                    return
                }
                
                // If all fields are filled, proceed to the next screen
        if let verifyVC = storyboard?.instantiateViewController(withIdentifier: "verifypage") {
            navigationController?.pushViewController(verifyVC, animated: true)
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
