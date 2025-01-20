import UIKit

class SignUpViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet var circleview: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add underline to text fields
        [nameTextField, emailTextField, passwordTextField].forEach {
            addUnderline(to: $0)
            $0?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        // Disable the sign-up button initially
        signUpButton.isEnabled = false
        
        // Make views circular
        for view in circleview {
            let size = min(view.frame.width, view.frame.height)
            view.frame.size = CGSize(width: size, height: size)
            view.layer.cornerRadius = size / 2
            view.layer.masksToBounds = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nameTextField, emailTextField, passwordTextField].forEach {
            addUnderline(to: $0)
        }
    }
    
    // Action for the Sign Up button
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Please enter your name.")
            return
        }
        
        guard let email = emailTextField.text, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return
        }
        
        guard let password = passwordTextField.text, password.count >= 8 else {
            showAlert(message: "Password must be at least 8 characters long.")
            return
        }
        
        // Save user data to UserDefaults
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        
        // Navigate to the verification screen
        guard let storyboard = storyboard else { return }
        let verifyVC = storyboard.instantiateViewController(withIdentifier: "verifycode")
        navigationController?.pushViewController(verifyVC, animated: true)
    }

    // Helper function to show alerts
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Input Required", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Helper function to add underline to text fields
    private func addUnderline(to textField: UITextField?) {
        guard let textField = textField else { return }
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        underline.backgroundColor = UIColor.black.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(underline)
    }
    
    // Helper function to validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // Enable the sign-up button only when all fields are filled
    @objc private func textFieldDidChange() {
        let isFormFilled = !(nameTextField.text?.isEmpty ?? true) &&
                           !(emailTextField.text?.isEmpty ?? true) &&
                           !(passwordTextField.text?.isEmpty ?? true)
        signUpButton.isEnabled = isFormFilled
    }
}
