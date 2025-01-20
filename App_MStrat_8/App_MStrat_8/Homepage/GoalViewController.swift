//
//  GoalViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 15/01/25.
//
import UIKit

protocol GoalViewControllerDelegate: AnyObject {
    func didAddGoal(title: String, amount: Int, deadline: Date)
}

class GoalViewController: UIViewController {
    @IBOutlet weak var savebutton: UIBarButtonItem!
    @IBOutlet weak var Goaltitletextfield: UITextField!
    @IBOutlet weak var GoalAmount: UITextField!
    @IBOutlet weak var Goaldeadline: UIDatePicker!
    
    weak var delegate: GoalViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func savebuttonTapped(_ sender: Any) {
        guard let title = Goaltitletextfield.text, !title.isEmpty,
              let amountText = GoalAmount.text, let amount = Int(amountText) else {
            print("Please enter valid title and amount")
            return
        }
        
        let deadline = Goaldeadline.date
        print("Goal details: Title: \(title), Amount: \(amount), Deadline: \(deadline)")
        delegate?.didAddGoal(title: title, amount: amount, deadline: deadline)
        self.dismiss(animated: true, completion: nil)
    }
}
