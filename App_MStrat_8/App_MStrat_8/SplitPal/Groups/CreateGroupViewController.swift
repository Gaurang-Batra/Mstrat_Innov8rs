//
//  CreateGroupViewController.swift
//  App_MStrat_8
//
//  Created by Gaurang  on 04/12/24.
//

import UIKit

//protocol CreateGroupDelegate: AnyObject {
//    func didCreateGroup(_ newGroup: GroupItem)
//}


struct cgroup {
    var name : String
    var image : UIImage
    init(name: String, image: UIImage?) {
           self.name = name
        self.image = image!
       }
    
   
}

class CreateGroupViewController: UIViewController {

    
    
    @IBOutlet weak var addmemberbutton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet var categoryButton: [UIButton]!
    
    @IBOutlet var creategroupbutton: UIView!
    
    let imageNames = ["traveler", "icons8-rent-50", "icons8-runners-crossing-finish-line-50", "icons8-grocery-50", "icons8-gym-50", "icons8-group-50"]
       
       var selectedImage: UIImage?
    var selectedMembers: [Int] = []

       override func viewDidLoad() {
           super.viewDidLoad()

           // Set up category buttons
           for (index, button) in categoryButton.enumerated() {
               if index < imageNames.count {
                   let image = UIImage(named: imageNames[index])
                   button.setImage(image, for: .normal)
               }
           }

           let newHeight: CGFloat = 50
           var frame = textField.frame
           frame.size.height = newHeight
           textField.frame = frame

           addSFSymbolToAddMemberButton()
       }

    @IBAction func categoryButtontapped(_ sender: UIButton) {
        // Reset button tint to gray
        for button in categoryButton {
            button.tintColor = .gray // Reset the tint color to gray for all buttons (or change to your default color)
            button.backgroundColor = .clear // Reset the background color if you want
        }
        
        // Highlight the clicked button by changing its tint color (or background color, etc.)
        sender.tintColor = .blue // Set the tint color to blue for the tapped button (or any highlight color)
        sender.backgroundColor = .lightGray // Optionally set a background color to show the selection
        
        // Optionally, you can also add an image to indicate that the button is selected
        // sender.setImage(UIImage(named: "selectedImage"), for: .normal)  // Uncomment this line if you want to change the image of the button
        
        // Store the selected button's image (if needed)
        selectedImage = sender.image(for: .normal)
        
        // Optionally disable other buttons if required (you already have the commented-out code for this)
        // for button in categoryButton {
        //     button.isEnabled = false
        // }
        
        // Enable the clicked button
        sender.isEnabled = true
    }

       @IBAction func cancelbuttontapped(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }

       @IBAction func createGroupButtonTapped(_ sender: Any) {
           // Dismiss the current view controller modally
           self.dismiss(animated: true, completion: nil)

           guard let groupName = textField.text, !groupName.isEmpty, let selectedImage = selectedImage else {
                       // Show error if group name is empty or no category selected
                       return
                   }

                   // Save the group data
           
           GroupDataModel.shared.createGroup(groupName: groupName, category: selectedImage, members: selectedMembers)
           
           
//           GroupDataModel.shared.createGroup(groupName: groupName, category: selectedImage)

                   // Navigate back or show success message
                   navigationController?.popViewController(animated: true)  // If using a navigation controller
               }

       // MARK: - Segue Preparation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "Groupsdetails",
              let destinationVC = segue.destination as? SplitpalViewController {
               // Pass the selected data (group image) to the SplitpalViewController
               destinationVC.selectedImage = selectedImage
           }
       }
   
       
       func addSFSymbolToAddMemberButton() {
           if let symbolImage = UIImage(systemName: "person.fill.badge.plus") {
               let symbolConfig = UIImage.SymbolConfiguration(weight: .regular)
               let outlinedSymbolImage = symbolImage.withConfiguration(symbolConfig).withRenderingMode(.alwaysTemplate)
               addmemberbutton.setImage(outlinedSymbolImage, for: .normal)
               addmemberbutton.tintColor = .blue
               
               var config = UIButton.Configuration.plain()
               config.imagePadding = 8
               config.imagePlacement = .leading
               addmemberbutton.configuration = config
           }
       }

       func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
           let size = image.size
           let widthRatio  = targetSize.width  / size.width
           let heightRatio = targetSize.height / size.height

           let scaleFactor = min(widthRatio, heightRatio)
           let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

           UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
           image.draw(in: CGRect(origin: .zero, size: newSize))
           let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

           return resizedImage ?? image
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
