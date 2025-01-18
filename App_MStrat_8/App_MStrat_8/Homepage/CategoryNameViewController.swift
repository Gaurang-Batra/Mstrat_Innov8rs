//
//  CategoryNameViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 14/01/25.
//

import UIKit

class CategoryNameViewController: UIViewController {

    @IBOutlet var CategoryButton: [UIButton]!
    
  
    
    
       @IBOutlet weak var recurringSwitch: UISwitch!
    
      // StackView containing Duration label and textField
       @IBOutlet weak var calendarButton: UIButton!
    
    @IBOutlet weak var durationlabel: UILabel!
    
    @IBOutlet weak var Enterdedline: UILabel!
    
    @IBOutlet weak var deadlineview: UIView!
    
    
    // Properties
       private let datePicker = UIDatePicker()
       let images = ["icons8-car-16", "icons8-house-16", "icons8-food-bar-16", "icons8-shopping-cart-16", "icons8-multiple-choice-16", "icons8-gym-16"]
       var selectedImage: UIImage?

       // MARK: - Lifecycle
       override func viewDidLoad() {
           super.viewDidLoad()

           // Set initial visibility of duration-related views to hidden
           
           recurringSwitch.isOn = false
           deadlineview.isHidden = true
           calendarButton.isHidden = true
           durationlabel.isHidden = true
           Enterdedline.isHidden = true

           // Setup category buttons with images
           for (index, button) in CategoryButton.enumerated() {
               if index < images.count {
                   let image = UIImage(named: images[index])
                   button.setImage(image, for: .normal)
               }
           }

           // Add target for switch toggle
           recurringSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
       }

       // MARK: - Actions
     

       @objc func switchToggled() {
           // Toggle visibility based on switch state
           let isSwitchOn = recurringSwitch.isOn
           deadlineview.isHidden = !isSwitchOn
           calendarButton.isHidden = !isSwitchOn
           durationlabel.isHidden = !isSwitchOn
           Enterdedline.isHidden = !isSwitchOn
       }
       @IBAction func cancelButtonTapped(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }
    
    @IBAction func calendarButtonTapped(_ sender: UIButton) {
           // Present the DatePicker
           showDatePicker()
       }

       // Function to present the DatePicker
       func showDatePicker() {
           // Add the date picker to the view
           view.addSubview(datePicker)
           
           // Set the date picker's frame position
           datePicker.frame = CGRect(x: 0, y: view.frame.height - datePicker.frame.height, width: view.frame.width, height: datePicker.frame.height)
           
           // Animate its appearance
           UIView.animate(withDuration: 0.3) {
               self.datePicker.frame.origin.y -= self.datePicker.frame.height
           }
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
