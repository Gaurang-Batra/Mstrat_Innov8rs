//
//  SettlementCellViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//

import UIKit

class SettlementViewController: UIViewController {

    @IBOutlet weak var settlementamounttextfield: UITextField!
    var labelText: Double?  // The variable that will receive the label text

        override func viewDidLoad() {
            super.viewDidLoad()

            // Check if the labelText is not nil and then set it to the text field
            if let labelText = labelText {
                settlementamounttextfield.text = "\(labelText)"
                print("Received label text: \(labelText)")  // Log to verify
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
