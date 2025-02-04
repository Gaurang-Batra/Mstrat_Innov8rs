//
//  GroupDetailViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 23/12/24.
//

import UIKit


class GroupDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var balances: [ExpenseSplitForm] = []
    var myBalances: [ExpenseSplitForm] = []
    var othersBalances: [ExpenseSplitForm] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupimageoutlet: UIImageView!
    @IBOutlet weak var groupnamelabel: UILabel!
    @IBOutlet weak var amountlabel: UILabel!
    @IBOutlet weak var GroupInfoView: UIView!
    @IBOutlet weak var SegmentedControllerforgroup: UISegmentedControl!
    
    @IBOutlet weak var membersbutton: UIButton!
    
    
    var groupItem: Group?
    var members : String = ""
    
    @IBAction func addedmemberbuttontapped(_ sender: UIButton) {
        print(groupItem?.groupName)
        print(groupItem?.id)
        balances = SplitExpenseDataModel.shared.getExpenseSplits(forGroup: groupItem?.id ?? 0)
           filterBalances()
           tableView.reloadData()
    }
    private var expenses: [ExpenseSplitForm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if groupItem is set, if not, print a message
        guard let group = groupItem else {
            print("groupItem is nil")
            return
        }

        // Assuming groupItem has a members array with user IDs
        var memberNames: [String] = []

        // Loop through each member in the group and get their name
        for userId in group.members {
            if let user = UserDataModel.shared.getUser(by: userId) {
                memberNames.append(user.fullname)  // Add the user's name to the array
            }
        }

        // Limit the list to two members and add "..." if there are more
        let limitedNames = memberNames.prefix(1).joined(separator: ", ")
        let displayText = memberNames.count > 1 ? limitedNames + "..." : limitedNames

        // Set the button title to the limited list of member names
        membersbutton.setTitle(displayText.isEmpty ? "No Members" : displayText, for: .normal)



        


        
        // Load balances from the SplitExpenseDataModel for the group
        balances = SplitExpenseDataModel.shared.getExpenseSplits(forGroup: group.id)
        
        // Filter balances for myBalances and othersBalances
        filterBalances()
        
        // Set up group information
        groupnamelabel.text = group.groupName
        groupimageoutlet.image = group.category
        
        // Set up GroupInfoView
        GroupInfoView.layer.cornerRadius = 20
        GroupInfoView.layer.masksToBounds = true
        
        // Initially set the separator style based on the selected segment
        updateSeparatorStyle()
        
        // Set up the segment control action
        SegmentedControllerforgroup.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .newExpenseAddedInGroup, object: nil)


        
        updateExpenseSum()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Reload balances and filter them
        balances = SplitExpenseDataModel.shared.getExpenseSplits(forGroup: groupItem?.id ?? 0)
        filterBalances()
        
        // Reload the table view
        tableView.reloadData()

        // Update the total expense sum
        updateExpenseSum()

        // Optionally update the segmented control state if needed
        updateSeparatorStyle()
    }


    @objc func reloadTableView() {
        print("Reloading table view...")
        balances = SplitExpenseDataModel.shared.getExpenseSplits(forGroup: groupItem?.id ?? 0)
        filterBalances()
        tableView.reloadData()
        updateExpenseSum()
    }

    // Ensure the method is marked with @objc so it can be used as a selector
    @objc func segmentControlChanged() {
        filterBalances()
        updateSeparatorStyle()
        tableView.reloadData()
    }
    
    func updateExpenseSum() {
            let totalAmount = balances.reduce(0) { $0 + $1.totalAmount }
            amountlabel.text = "Rs.\(Int(totalAmount))" // Update the label with the sum
        }
    
    // Method to filter balances into myBalances and othersBalances
    func filterBalances() {
        myBalances = balances.filter { $0.paidBy.contains("Ajay (You)") || $0.payee.contains("Ajay (You)") }
        othersBalances = balances.filter { !$0.paidBy.contains("Ajay (You)") && !$0.payee.contains("Ajay (You)") }
    }

    func updateSeparatorStyle() {
        if SegmentedControllerforgroup.selectedSegmentIndex == 0 {
            tableView.separatorStyle = .singleLine // Show separator for Expense
        } else {
            tableView.separatorStyle = .none // Hide separator for Balance
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SegmentedControllerforgroup.selectedSegmentIndex == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if SegmentedControllerforgroup.selectedSegmentIndex == 0 {
            return nil // No title for the Expense section
        } else {
            return section == 0 ? "My Balances" : "Other's Balances"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SegmentedControllerforgroup.selectedSegmentIndex == 0 {
            return balances.count
        } else {
            return section == 0 ? myBalances.count : othersBalances.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if SegmentedControllerforgroup.selectedSegmentIndex == 0 {
            // Dequeue the custom ExpenseAddedTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseAddedTableViewCell
            
            // Get the relevant expense data for the row
            let expense = balances[indexPath.row]
            
            // Configure the custom cell
            cell.ExpenseAddedlabel.text = expense.name
            cell.Paidbylabel.text = expense.paidBy
            cell.ExoenseAmountlabel.text = "Rs.\(Int(expense.totalAmount))"
            
            // Set image if available
            if let image = expense.image {
                cell.Expenseaddedimage.image = image
            } else {
                cell.Expenseaddedimage.image = nil // Or set a placeholder image if needed
            }
            
            // Return the custom configured cell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell", for: indexPath) as! BalanceCellTableViewCell
            let balance: ExpenseSplitForm
            if indexPath.section == 0 {
                balance = myBalances[indexPath.row]
            } else {
                balance = othersBalances[indexPath.row]
            }
            cell.configure(with: balance)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if SegmentedControllerforgroup.selectedSegmentIndex == 0 {
            return 60
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if SegmentedControllerforgroup.selectedSegmentIndex == 0 {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            
            let headerLabel = UILabel()
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            headerLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            headerLabel.textColor = .black
            headerLabel.text = "Expense List"
            
            headerView.addSubview(headerLabel)
            
            NSLayoutConstraint.activate([
                headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
            ])
            
            return headerView
        }
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerLabel.textColor = .black
        headerLabel.text = section == 0 ? "My Balances" : "Other's Balances"
        
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func navigateToSettlement(with amount: Double, expense: ExpenseSplitForm?) {
        performSegue(withIdentifier: "Settlement", sender: amount)
    }
    
    @IBAction func ExpenseSplitbuttontapped(_ sender: Any) {
        performSegue(withIdentifier: "ExpenseSplit", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Settlement" {
                    if let destinationVC = segue.destination as? SettlementViewController,
                       let selectedExpense = sender as? ExpenseSplitForm {
                        destinationVC.labelText = selectedExpense.totalAmount
                        destinationVC.selectedExpense = selectedExpense
                        destinationVC.delegate = self  // Set the delegate to self
                    }
            }
        else if segue.identifier == "ExpenseSplit" {
            if let navigationController = segue.destination as? UINavigationController,
               let destinationVC = navigationController.topViewController as? BillViewController {
                if let member = groupItem?.members {
                    destinationVC.groupMembers = member
                    print("Sending groupItem IDs: \(member)")
                }
                if let id = groupItem?.id {
                    destinationVC.groupid = id
                    print("Sending groupItem IDs: \(id)")
                }
            }
        }
        else if segue.identifier == "invitedmemberlist" {
            if let destinationVC = segue.destination as? MembersListTableViewController {
                if let member = groupItem?.members {
                    destinationVC.members = member
                    print("Sending groupItem IDs: \(member)")
                }
            }
        }
    }
}
