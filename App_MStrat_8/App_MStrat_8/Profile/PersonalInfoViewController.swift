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
        preFillUserData()
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
        EmailTextfield.placeholder = "Email address cannot be changed"
        EmailTextfield.isEnabled = false // Disable email text field for editing
        EmailTextfield.textColor = UIColor.gray // Optionally, make the text visually distinct
    }
    
    // Function to pre-fill the data from UserDefaults
    func preFillUserData() {
        // Retrieve user data from UserDefaults
        if let savedName = UserDefaults.standard.string(forKey: "userName"),
           let savedPhone = UserDefaults.standard.string(forKey: "userPhone"),
           let savedEmail = UserDefaults.standard.string(forKey: "userEmail") {
            // Fill the text fields with the saved data
            Nametextfield.text = savedName
            PhoneTextfield.text = savedPhone
            EmailTextfield.text = savedEmail
        }
    }
    
    // Action when "Save and Continue" is tapped
    @IBAction func saveAndContinueTapped(_ sender: UIButton) {
        // Perform simple validation for the text fields (can be extended with more detailed checks)
        if let name = Nametextfield.text, name.isEmpty {
            showAlert(title: "Error", message: "Please enter your name.")
        } else if let phone = PhoneTextfield.text, phone.isEmpty {
            showAlert(title: "Error", message: "Please enter your phone number.")
        } else {
            // Save the entered data to UserDefaults
            UserDefaults.standard.set(Nametextfield.text, forKey: "userName")
            UserDefaults.standard.set(PhoneTextfield.text, forKey: "userPhone")
            
            // Show success alert
            let alertController = UIAlertController(
                title: "Changes Saved",
                message: "Your changes have been saved successfully.",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
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
