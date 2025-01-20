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

        override func viewDidLoad() {
            super.viewDidLoad()

            // Set initial state for password fields (hidden dots by default)
            passwordTextField1.isSecureTextEntry = true
            passwordTextField2.isSecureTextEntry = true
            passwordTextField3.isSecureTextEntry = true

            // Set initial images for eye buttons (showing the password hidden by dots initially)
            eyeButton1.setImage(UIImage(named: "icons8-blind-50"), for: .normal)
            eyeButton2.setImage(UIImage(named: "icons8-blind-50"), for: .normal)
            eyeButton3.setImage(UIImage(named: "icons8-blind-50"), for: .normal)
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
                button.setImage(UIImage(named: "icons8-eye-50"), for: .normal)  // Change image to show eye (password visible)
            } else {
                // If the text is currently visible, hide it (dots)
                textField.isSecureTextEntry = true
                button.setImage(UIImage(named: "icons8-blind-50"), for: .normal)  // Change image to show eye with a line through it (password hidden)
            }
        }
    }
