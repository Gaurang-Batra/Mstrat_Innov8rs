//
//  PersonalInfoViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 17/01/25.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    @IBOutlet weak var saveandcontinue: UIButton!
    
    @IBOutlet weak var Nametextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup
               configureSaveAndContinueButton()
        
    }
    
    // Function to add underline to a text field


           func configureSaveAndContinueButton() {
               saveandcontinue.setTitle("Save and Continue", for: .normal)
               saveandcontinue.setTitleColor(.white, for: .normal)
               saveandcontinue.backgroundColor = UIColor.systemBlue
               saveandcontinue.layer.cornerRadius = 8
           }

           @IBAction func saveAndContinueTapped(_ sender: UIButton) {
               let alertController = UIAlertController(
                          title: "Changes Saved",
                          message: "Your changes have been saved successfully.",
                          preferredStyle: .alert
                      )

                      // Add an OK action to dismiss the alert
                      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                      alertController.addAction(okAction)

                      // Present the alert
                      present(alertController, animated: true, completion: nil)
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
