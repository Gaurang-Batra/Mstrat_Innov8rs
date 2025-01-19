//
//  PersonalInformationViewController.swift
//  App_MStrat_8
//
//  Created by Gaurang on 20/12/24.
//

import UIKit

class PersonalInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    let identities = ["a","b","c"]
    
    var isEmailVerified = false
    var val = ["Personal Information", "Sign In & Security", "Privacy Policy"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure profile image to be circular
        configureProfileImage()

        // Set table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    func configureProfileImage() {
        profileimage.layer.cornerRadius = profileimage.frame.size.width / 2
        profileimage.clipsToBounds = true
        profileimage.layer.borderWidth = 2.0
        profileimage.layer.borderColor = UIColor.systemBlue.cgColor
        profileimage.contentMode = .scaleAspectFill
    }
    func configureSignOutButton() {
            signOutButton.setTitle("Sign Out", for: .normal)
            signOutButton.setTitleColor(.white, for: .normal)
            signOutButton.backgroundColor = UIColor.systemRed
            signOutButton.layer.cornerRadius = 8
        }

    // MARK: - Profile Image Editing
    

    @IBAction func profilebuttonedit(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }

        present(alertController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        profileimage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return val.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)

        // Configure the text for the cell
        cell.textLabel?.text = val[indexPath.row]

        // Set the icon for each row
        switch indexPath.row {
        case 0:
            cell.imageView?.image = UIImage(named: "icons8-user-50") // Personal Information icon
        case 1:
            cell.imageView?.image = UIImage(named: "icons8-security-lock-50") // Sign In & Security icon
        case 2:
            cell.imageView?.image = UIImage(named: "icons8-privacy-policy-50") // Privacy Policy icon
        default:
            cell.imageView?.image = nil // No icon for other rows
        }

        return cell
    }

    @IBAction func goToLoginScreenButtonTapped(_ sender: UIButton) {
        
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: "Openpage") as? SplashViewController {
                // Set it as the root view controller
                let navigationController = UINavigationController(rootViewController: loginVC)
                navigationController.setNavigationBarHidden(true, animated: false)

                // Replace the entire navigation stack
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController = navigationController
            }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vcname = identities[indexPath.row]
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcname)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
//            switch indexPath.row {
//            case 0:
//                let personalInfoVC = storyboard?.instantiateViewController(withIdentifier: "PersonalInfo") as! PersonalInfoViewController
//                navigationController?.pushViewController(personalInfoVC, animated: true)
//            case 1:
//                let signInSecurityVC = storyboard?.instantiateViewController(withIdentifier: "SignInSecurityViewController") as! SignInSecurityViewController
//                navigationController?.pushViewController(signInSecurityVC, animated: true)
//            case 2:
//                let privacyPolicyVC = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
//                navigationController?.pushViewController(privacyPolicyVC, animated: true)
//            default:
//                break
//            }
        }
    
   
    
}
