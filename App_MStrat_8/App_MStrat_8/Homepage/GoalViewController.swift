import UIKit
import Foundation

// MARK: - Protocol for GoalViewControllerDelegate
protocol GoalViewControllerDelegate: AnyObject {
    
    func didAddGoal(title: String, amount: Int, deadline: Date, initialSavings: Int)
}

// MARK: - GoalViewController
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

        // Pass data to the delegate with initial savings set to 0
        delegate?.didAddGoal(title: title, amount: amount, deadline: deadline, initialSavings: 0)
//        print("Goal details: Title: \(title), Amount: \(amount), Deadline: \(deadline)")
        self.dismiss(animated: true, completion: nil)
    }
}
