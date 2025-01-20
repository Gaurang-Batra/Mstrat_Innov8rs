import UIKit

class PersonalInfoViewController: UIViewController {

    @IBOutlet weak var saveandcontinue: UIButton!
    
    // Outlets for the text fields
    @IBOutlet weak var Nametextfield: UITextField!
    @IBOutlet weak var PhoneTextfield: UITextField!
    @IBOutlet weak var EmailTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup
        configureSaveAndContinueButton()
        configureTextFields()
    }
    
    // Function to configure the Save and Continue button
    func configureSaveAndContinueButton() {
        saveandcontinue.setTitle("Save and Continue", for: .normal)
        saveandcontinue.setTitleColor(.white, for: .normal)
        saveandcontinue.backgroundColor = UIColor.systemBlue
        saveandcontinue.layer.cornerRadius = 8
    }
    
    // Function to configure text fields
    func configureTextFields() {
        // Set placeholder text for the text fields
        Nametextfield.placeholder = "Enter your name"
        PhoneTextfield.placeholder = "Enter your phone number"
        EmailTextfield.placeholder = "Enter your email address"
        
        // Set text field appearance (optional)
//        Nametextfield.layer.borderWidth = 1.0
//        Nametextfield.layer.borderColor = UIColor.gray.cgColor
//        Nametextfield.layer.cornerRadius = 8
//        
//        PhoneTextfield.layer.borderWidth = 1.0
//        PhoneTextfield.layer.borderColor = UIColor.gray.cgColor
//        PhoneTextfield.layer.cornerRadius = 8
//        
//        EmailTextfield.layer.borderWidth = 1.0
//        EmailTextfield.layer.borderColor = UIColor.gray.cgColor
//        EmailTextfield.layer.cornerRadius = 8
    }
    
    @IBAction func saveAndContinueTapped(_ sender: UIButton) {
        // Perform simple validation for the text fields (can be extended with more detailed checks)
//        if let name = Nametextfield.text, name.isEmpty {
//            showAlert(title: "Error", message: "Please enter your name.")
//        } else if let phone = PhoneTextfield.text, phone.isEmpty {
//            showAlert(title: "Error", message: "Please enter your phone number.")
//        } else if let email = EmailTextfield.text, email.isEmpty {
//            showAlert(title: "Error", message: "Please enter your email address.")
//        } else {
            // Show success alert if all fields are filled
            let alertController = UIAlertController(
                title: "Changes Saved",
                message: "Your changes have been saved successfully.",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
//        }
    }
    
    // Function to display an alert with a custom title and message
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
