import UIKit

class PersonalInfoViewController: UIViewController {

    @IBOutlet weak var saveandcontinue: UIButton!
    @IBOutlet weak var Nametextfield: UITextField!
    @IBOutlet weak var PhoneTextfield: UITextField!
    @IBOutlet weak var EmailTextfield: UITextField!
    
    private var isEditingEnabled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSaveAndContinueButton()
        configureTextFields()
        preFillUserData()
        disableEditing()
        configureNavigationBar()
        updateSaveAndContinueButtonState()
    }
    
    func configureNavigationBar() {
        let editButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonTapped() {
        isEditingEnabled.toggle()
        if isEditingEnabled {
            enableEditing()
            navigationItem.rightBarButtonItem?.title = "Done"
            updateSaveAndContinueButtonState()
        } else {
            disableEditing()
            navigationItem.rightBarButtonItem?.title = "Edit"
            updateSaveAndContinueButtonState()
        }
    }
    
    func enableEditing() {
        Nametextfield.isEnabled = true
        PhoneTextfield.isEnabled = true
        Nametextfield.borderStyle = .roundedRect
        PhoneTextfield.borderStyle = .roundedRect
    }
    
    func disableEditing() {
        Nametextfield.isEnabled = false
        PhoneTextfield.isEnabled = false
        Nametextfield.borderStyle = .none
        PhoneTextfield.borderStyle = .none
    }
    
    func updateSaveAndContinueButtonState() {
        saveandcontinue.isEnabled = !isEditingEnabled
        saveandcontinue.alpha = saveandcontinue.isEnabled ? 1.0 : 0.5
    }
    
    func configureSaveAndContinueButton() {
        saveandcontinue.setTitle("Save and Continue", for: .normal)
        saveandcontinue.setTitleColor(.white, for: .normal)
        saveandcontinue.backgroundColor = UIColor.systemBlue
        saveandcontinue.layer.cornerRadius = 8
    }
    
    func configureTextFields() {
        Nametextfield.placeholder = "Enter your name"
        PhoneTextfield.placeholder = "Enter your phone number"
        EmailTextfield.placeholder = "Email address cannot be changed"
        EmailTextfield.isEnabled = false
        EmailTextfield.textColor = UIColor.gray
    }
    
    func preFillUserData() {
        if let savedName = UserDefaults.standard.string(forKey: "userName"),
           let savedPhone = UserDefaults.standard.string(forKey: "userPhone"),
           let savedEmail = UserDefaults.standard.string(forKey: "userEmail") {
            Nametextfield.text = savedName
            PhoneTextfield.text = savedPhone
            EmailTextfield.text = savedEmail
        }
    }
    
    @IBAction func saveAndContinueTapped(_ sender: UIButton) {
        if let name = Nametextfield.text, name.isEmpty {
            showAlert(title: "Error", message: "Please enter your name.")
        } else if let phone = PhoneTextfield.text, phone.isEmpty {
            showAlert(title: "Error", message: "Please enter your phone number.")
        } else {
            UserDefaults.standard.set(Nametextfield.text, forKey: "userName")
            UserDefaults.standard.set(PhoneTextfield.text, forKey: "userPhone")
            
            NotificationCenter.default.post(
                name: Notification.Name("NameUpdated"),
                object: nil,
                userInfo: ["newName": Nametextfield.text ?? ""]
            )
            
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
