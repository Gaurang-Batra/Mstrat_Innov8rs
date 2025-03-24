import UIKit

class SignInSecurityViewController: UIViewController {

    // Outlets for password text fields
    @IBOutlet weak var passwordTextField1: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    @IBOutlet weak var passwordTextField3: UITextField!

    // Variables to track password visibility
    @IBOutlet weak var eyeButton1: UIButton!  // Eye button for passwordTextField1
    @IBOutlet weak var eyeButton2: UIButton!  // Eye button for passwordTextField2
    @IBOutlet weak var eyeButton3: UIButton!  // Eye button for passwordTextField3

    // Fetch the stored password (previously set during login)
    var storedPassword: String {
        return UserDefaults.standard.string(forKey: "userPassword") ?? ""
    }
    
    var userId :Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("this id ins int he sign in & securty : \(userId)")

        // Set initial state for password fields (hidden dots by default)
        passwordTextField1.isSecureTextEntry = true
        passwordTextField2.isSecureTextEntry = true
        passwordTextField3.isSecureTextEntry = true

        // Set initial images for eye buttons (showing the password hidden by dots initially)
        eyeButton1.setImage(UIImage(named: "icons8-blind-50"), for: .normal)
        eyeButton2.setImage(UIImage(named: "icons8-blind-50"), for: .normal)
        eyeButton3.setImage(UIImage(named: "icons8-blind-50"), for: .normal)
        
        passwordTextField1.placeholder = "Enter your current password"
        passwordTextField2.placeholder = "Enter your new password"
        passwordTextField3.placeholder = "Re-enter your new password"
    }

    // Action for eye button 1 (current password visibility toggle)
    @IBAction func togglePasswordVisibility1(_ sender: UIButton) {
        togglePasswordVisibility(for: passwordTextField1, button: eyeButton1)
    }

    // Action for eye button 2 (new password visibility toggle)
    @IBAction func togglePasswordVisibility2(_ sender: UIButton) {
        togglePasswordVisibility(for: passwordTextField2, button: eyeButton2)
    }

    // Action for eye button 3 (verify new password visibility toggle)
    @IBAction func togglePasswordVisibility3(_ sender: UIButton) {
        togglePasswordVisibility(for: passwordTextField3, button: eyeButton3)
    }

    // Method to toggle password visibility and change the button image
    func togglePasswordVisibility(for textField: UITextField, button: UIButton) {
        if textField.isSecureTextEntry {
            // If the text is currently hidden (dots), show it
            textField.isSecureTextEntry = false
            button.setImage(UIImage(named: "icons8-eye-50"), for: .normal)
        } else {
            // If the text is currently visible, hide it (dots)
            textField.isSecureTextEntry = true
            button.setImage(UIImage(named: "icons8-blind-50"), for: .normal)
        }
    }

    @IBAction func saveAndContinueTapped(_ sender: UIButton) {
        // Check if the old password entered matches the stored password
        if passwordTextField1.text != storedPassword {
            // Show alert if the old password doesn't match
            let alertController = UIAlertController(
                title: "Error",
                message: "Old password does not match the current password.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        // Check if the new password and the confirmation match
        if passwordTextField2.text == passwordTextField3.text {
            // Passwords match, update the password in UserDefaults
            UserDefaults.standard.set(passwordTextField2.text, forKey: "userPassword")
            
            // Show success alert
            let alertController = UIAlertController(
                title: "Password Changed",
                message: "Your password has been changed successfully.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            // Passwords do not match, show error alert
            let alertController = UIAlertController(
                title: "Error",
                message: "Please re-enter your new password carefully.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}
