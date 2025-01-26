//
//  BillViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 20/12/24.
//
import UIKit



enum ExpenseCate: String, CaseIterable {
    case food = "Food"
    case grocery = "Grocery"
    case fuel = "Fuel"
    case bills = "Bills"
    case travel = "Travel"
    case other = "Other"
    
    var associatedImage: UIImage {
        switch self {
        case .food:
            return UIImage(named: "icons8-kawaii-pizza-50") ?? UIImage()
        case .grocery:
            return UIImage(named: "icons8-vegetarian-food-50") ?? UIImage()
        case .fuel:
            return UIImage(named: "icons8-fuel-50") ?? UIImage()
        case .bills:
            return UIImage(named: "icons8-cheque-50") ?? UIImage()
        case .travel:
            return UIImage(named: "icons8-holiday-50") ?? UIImage()
        case .other:
            return UIImage(named: "icons8-more-50-2") ?? UIImage()
        }
    }
}
class Cellclass: UITableViewCell {
    // You can customize this cell further if needed.
}

class BillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var categorybutton: UIButton!
    @IBOutlet weak var titletextfield: UITextField!
    @IBOutlet weak var pricetextfield: UITextField!

    @IBOutlet weak var payerbutton: UIButton!
    
    @IBOutlet weak var segmentedcontroller: UISegmentedControl!
    
    
    let transparentview = UIView()
    let tableview = UITableView()
    var selectedbutton = UIButton()
    
    
    var membersdataSource = [String]()
    var dataSource: [(name: String, image: UIImage?)] = []
// List of items to show in the tableview
    
    var groupMembers : [Int] = []
    var selectedimage : UIImage?
    
    private var expenses: [ExpenseSplitForm] = []
    
    @IBOutlet weak var mytableview: UITableView!
    var groupid : Int?

    private let users = UserDataModel.shared.getAllUsers()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mytableview.reloadData()
       
        // Customizing the text fields
        customizeTextField(titletextfield)
        customizeTextField(pricetextfield)
     

        // Setting up the tableview
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(Cellclass.self, forCellReuseIdentifier: "Cell")

        // Customizing the category button with underline
        addUnderlineToButton(categorybutton)
        addUnderlineToButton(payerbutton)
        NotificationCenter.default.addObserver(self, selector: #selector(onNewExpenseAdded), name: .newExpenseAddedInGroup, object: nil)

                loadExpenses()
        


    }
    
    private func loadExpenses() {
           expenses = SplitExpenseDataModel.shared.getAllExpenseSplits()
           mytableview.reloadData()
       }

       @objc private func onNewExpenseAdded() {
           loadExpenses()
       }

    private var underlineLayers: [UIButton: CALayer] = [:]

    private func addUnderlineToButton(_ button: UIButton) {
        // Remove any existing underline for the specific button
        underlineLayers[button]?.removeFromSuperlayer()
        
        // Add a new underline using CALayer
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: button.frame.height - 2, width: button.frame.width, height: 2)
        underline.backgroundColor = UIColor.lightGray.cgColor
        button.layer.addSublayer(underline)
        
        // Store the reference to the underline layer for the button
        underlineLayers[button] = underline
    }



    private func customizeTextField(_ textField: UITextField) {
        // Remove border
        textField.borderStyle = .none
        
        // Add underline to the textfield
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        underline.backgroundColor = UIColor.lightGray.cgColor
        textField.layer.addSublayer(underline)
    }

    // Method to show the transparent view and table when category button is clicked
    func addtransparentView(frames: CGRect) {
        // Get the active window in the current scene.
        guard let windowScene = view.window?.windowScene else {
            return
        }
        
        // Get the key window of the current scene
        if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            transparentview.frame = window.frame
            self.view.addSubview(transparentview)
            
            // Set the table view position and size
            tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            self.view.addSubview(tableview)
            tableview.layer.cornerRadius = 8

            tableview.reloadData()

            // Set the background color of the transparent view
            transparentview.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            
            // Add a tap gesture to remove the transparent view
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
            transparentview.addGestureRecognizer(tapgesture)
            
            // Initially hide the table
            transparentview.alpha = 0
            
            // Animate the appearance of the transparent view and table
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentview.alpha = 0.5
                self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
            }, completion: nil)
        }
    }

    @objc func removeTransparentView(){
        let frames = selectedbutton.frame
        
        // Animate the disappearance of the transparent view and table
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentview.alpha = 0
            self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
    @IBAction func Payerbuttontapped(_ sender: Any) {
        // Clear the existing `membersdataSource` to avoid duplicate entries
        membersdataSource.removeAll()
        
        // Map `groupMembers` IDs to their respective names and append them to `membersdataSource`
        membersdataSource.append("Ajay (You)")
        for memberId in groupMembers {
            if let user = users.first(where: { $0.id == memberId }) {
                membersdataSource.append(user.fullname)
            }
        }
        
        // Debug log to verify the updated `membersdataSource`
        print("Members Data Source: \(membersdataSource)")
        print(groupMembers)
        
        // Set the `dataSource` for the table view and show the transparent view
        dataSource = membersdataSource.map { (name: $0, image: UIImage(named: "defaultImage")) }
        selectedbutton = payerbutton
        addtransparentView(frames: payerbutton.frame)
    }

    // Action when category button is clicked
    @IBAction func Categorybutton(_ sender: Any) {
           // Populate dataSource using the enum values
           dataSource = ExpenseCategory.allCases.map { category in
               (category.rawValue, category.associatedImage)
           }
           
           print(dataSource)
           selectedbutton = categorybutton
           addtransparentView(frames: categorybutton.frame)
       }
    
    var selectedPayer: String?

    // MARK: - TableView DataSource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check if the tableview's identifier corresponds to "Cell"
        if tableView.dequeueReusableCell(withIdentifier: "Cell") != nil {
            return dataSource.count
        }
        
        // Check if the tableview's identifier corresponds to "members"
         if tableView.dequeueReusableCell(withIdentifier: "members") != nil{
            return groupMembers.count // Assuming groupMembers is an array
        }

        // Default case
        return 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if tableView.dequeueReusableCell(withIdentifier: "Cell") != nil{
            // Dequeue cell for "Cell" identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cellclass
            let item = dataSource[indexPath.row]
            cell.textLabel?.text = item.name
            cell.imageView?.image = item.image
            return cell
        }
           if tableView.dequeueReusableCell(withIdentifier: "members") != nil {
            // Dequeue cell for "members" identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: "members", for: indexPath)
        let memberId = groupMembers[indexPath.row]
               
               // Use UserDataModel to find the user by ID
               if let user = UserDataModel.shared.getUser(by: memberId) {
                   cell.textLabel?.text = user.fullname // Display user's fullname
               } else {
                   cell.textLabel?.text = "Unknown User" // Fallback if user not found
               }
               return cell
        }
        else {
            // Fallback for unknown identifier
            let cell = UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
            cell.textLabel?.text = "Unknown Identifier"
            return cell
        }
    }


    // Action when a table row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected item (payer) from the data source
        let selectedItem = dataSource[indexPath.row]
        
        // Update the title of the selected button to reflect the chosen payer
        selectedbutton.setTitle(selectedItem.name, for: .normal)
        
        // Update the payer button title to include "Paid By"
//        payerbutton.setTitle(" paid by:\(selectedItem.name)", for: .normal)
        if selectedbutton == payerbutton {
                payerbutton.setTitle("\(selectedItem.name)", for: .normal)
                selectedPayer = selectedItem.name
                print("Selected payer: \(selectedItem.name)")
            }
        
        // Store the selected payer for later use when creating the expense
        selectedPayer = selectedItem.name
        print("Selected payer: \(selectedItem.name)")
        
        // Remove the transparent view to hide the selection UI
        removeTransparentView()
    }

    // Set the height of each row in the tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func cancelbuttontapped(_ sender: Any) {
        self.dismiss(animated: true , completion: nil)
    }
    
    @IBAction func addExpenseButtonTapped(_ sender: Any) {
        // Extract the data from the input fields
        guard let title = titletextfield.text, !title.isEmpty,
              let priceString = pricetextfield.text, let price = Double(priceString),
              let categoryString = categorybutton.titleLabel?.text,
              let category = ExpenseCate(rawValue: categoryString), // Convert to ExpenseCate enum
              let paidBy = selectedPayer else { // Ensure a payer has been selected
            print("Error: Missing data (title, price, category, or payer)")
            return
        }
        
        // Check if the segmented control is at index 0
        let payee = (segmentedcontroller.selectedSegmentIndex == 0) ? "All members" : "Ajay (You)"
        
        // Get the current date
        let currentDate = Date()
        
        // Create the new expense split
        let newExpense = ExpenseSplitForm(
            name: title,
            category: categoryString,  // Use the category string for the expense
            totalAmount: price,
            paidBy: paidBy,  // Dynamically set the selected payer
            groupId: groupid,  // Assuming groupId is 1 for simplicity
            image: category.associatedImage,  // Get the associated image from the enum
            splitOption: .equally,  // You can change this to a different split option
            splitAmounts: nil,  // Provide split amounts if needed
            payee: payee,  // Payee based on segmented control
            date: currentDate,
            ismine: true  // Assuming it's always "mine" for this case
        )
        
        // Add the new expense to the model
        SplitExpenseDataModel.shared.addExpenseSplit(expense: newExpense)
        
        // Optionally, clear the input fields or update the UI
        print(newExpense)
        titletextfield.text = ""
        pricetextfield.text = ""
        categorybutton.setTitle("Select Category", for: .normal)
        payerbutton.setTitle("Select Payer", for: .normal)  // Reset payer button title
        
        // Close the view or update UI as necessary
        self.dismiss(animated: true, completion: nil)
    }

}
