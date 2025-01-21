//
//  VerifyotpViewController.swift
//  App_MStrat_8
//
//  Created by Gaurang  on 17/01/25.
//

import UIKit

class VerifyotpViewController: UIViewController {

    @IBOutlet weak var EnterOtptextfield: UITextField!
    @IBOutlet weak var ResendOtpbutton: UIButton!
    @IBOutlet weak var ContinueButton: UIButton!
    @IBOutlet var circleview: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set placeholder for the OTP text field
        EnterOtptextfield.placeholder = "Enter OTP"
        addUnderline(to: EnterOtptextfield)
        
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
    
    @IBAction func resendOtpButtonTapped(_ sender: UIButton) {
        // Change the button title to "Sending..."
        ResendOtpbutton.setTitle("Sending...", for: .normal)
        ResendOtpbutton.isEnabled = false // Disable the button temporarily
        
        // Simulate a delay for sending the OTP
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.ResendOtpbutton.setTitle("Resend OTP", for: .normal)
            self.ResendOtpbutton.isEnabled = true
            // Notify the user that the OTP has been sent
            self.showAlert(message: "A new OTP has been sent.")
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        guard let enteredOTP = EnterOtptextfield.text, !enteredOTP.isEmpty else {
            showAlert(message: "Please enter the OTP.")
            return
        }
        
        if isValidOTP(enteredOTP) {
            // OTP is valid, navigate to the home screen
            navigateToHomeScreen()
        } else {
            // OTP is invalid, show an alert
            showAlert(message: "Invalid OTP. Please retry.")
        }
    }
    
    // Function to validate if the OTP is exactly 4 digits
    private func isValidOTP(_ otp: String) -> Bool {
        let otpPattern = "^[0-9]{4}$" // Regular expression for exactly 4 digits
        let otpPredicate = NSPredicate(format: "SELF MATCHES %@", otpPattern)
        return otpPredicate.evaluate(with: otp)
    }
    
    // Function to navigate to the home screen
    private func navigateToHomeScreen() {
        if let homeScreenVC = storyboard?.instantiateViewController(withIdentifier: "homescreen") {
            // Push to the home screen using the navigation controller
            navigationController?.pushViewController(homeScreenVC, animated: true)
        } else {
            showAlert(message: "Unable to navigate to the home screen.")
        }
    }
    
    // Function to show an alert with a message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
