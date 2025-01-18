//
//  VerifyotpViewController.swift
//  App_MStrat_8
//
//  Created by Gaurang  on 17/01/25.
//

import UIKit

class VerifyotpViewController: UIViewController {

    @IBOutlet weak var EnterOtptextfield: UITextField!
    
    @IBOutlet weak var ResendOtpbutton: UIButton!
    
    @IBOutlet weak var ContinueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addUnderline(to: EnterOtptextfield)
       
           }
           
           // Function to add underline to a text field
        private func addUnderline(to textField: UITextField) {
               let underline = CALayer()
               underline.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
               underline.backgroundColor = UIColor.black.cgColor
               textField.borderStyle = .none
               textField.layer.addSublayer(underline)
           }
    @IBAction func resendOtpButtonTapped(_ sender: UIButton) {
           // Change the button title to "Sending..."
           ResendOtpbutton.setTitle("Sending...", for: .normal)
           ResendOtpbutton.isEnabled = false // Disable the button temporarily

           // After 2 seconds, change the title back to "Resend OTP" and re-enable the button
           DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
               self.ResendOtpbutton.setTitle("Resend OTP", for: .normal)
               self.ResendOtpbutton.isEnabled = true
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
