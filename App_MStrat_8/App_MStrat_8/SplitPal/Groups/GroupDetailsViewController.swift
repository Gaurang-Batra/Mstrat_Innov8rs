//
//  inGroupViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 23/12/24.
//

import UIKit

struct Balance {
    let payer: String
    let payee: String
    let amount: Double
    let isMine: Bool // True if it's "My Balances," false otherwise
}

struct Expens {
    var name: String
    var dateAdded: Date
}


class GroupDetailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    ///--------------------------
    let balances = [
            Balance(payer: "friend1", payee: "Ajay (You)", amount: 30, isMine: true),
            Balance(payer: "friend2", payee: "friend1", amount: 30, isMine: false),
            Balance(payer: "friend1", payee: "Ajay (You)", amount: 30, isMine: true),
            Balance(payer: "Ajay (You)", payee: "friend2", amount: 30, isMine: true),
            Balance(payer: "friend2", payee: "friend1", amount: 30, isMine: false),
            Balance(payer: "friend2", payee: "friend1", amount: 30, isMine: false),
            Balance(payer: "friend2", payee: "friend1", amount: 30, isMine: false)
        ]
    let expence = [
        Expens(name: " ", dateAdded: Date()),
        Expens(name: " ", dateAdded: Date())
    ]
    var myBalances: [Balance] = []
      var othersBalances: [Balance] = []
    
    //////-------------------
   
  

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var groupimageoutlet: UIImageView!
    
    @IBOutlet weak var groupnamelabel: UILabel!
    
    @IBOutlet weak var memberslabel: UILabel!
    
    @IBOutlet weak var amountlabel: UILabel!
    
    @IBOutlet weak var GroupInfoView: UIView!
    
    @IBOutlet weak var SegmentedControllerforgroup: UISegmentedControl!
    
    @IBAction func SegmentedControllerforgroup(_ sender: UISegmentedControl) {
        tableView.reloadData()  // Reload the table to reflect the selected segment
    }
    var groupItem: Group?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Filter balances
          myBalances = balances.filter { $0.payer == "Ajay (You)" || $0.payee == "Ajay (You)" }
          othersBalances = balances.filter { $0.payer != "Ajay (You)" && $0.payee != "Ajay (You)" }
          
          // Set up group information if available
          if let item = groupItem {
              groupnamelabel.text = item.groupName
              groupimageoutlet.image = item.category
          } else {
              print("groupItem is nil")
          }
          
          GroupInfoView.layer.cornerRadius = 20
          GroupInfoView.layer.masksToBounds = true
          
          // Initially set the separator style based on the selected segment
          updateSeparatorStyle()
          
          // Set up the segment control action
          SegmentedControllerforgroup.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
      }
      
      @objc func segmentControlChanged() {
          updateSeparatorStyle()
          tableView.reloadData()
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
              return expence.count
          } else {
              return section == 0 ? myBalances.count : othersBalances.count
          }
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          if SegmentedControllerforgroup.selectedSegmentIndex == 0 {
              let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath)
              let expense = expence[indexPath.row]
              cell.textLabel?.text = expense.name
              return cell
          } else {
              let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell", for: indexPath) as! BalanceCellTableViewCell
              let balance: Balance
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
              
              // Format the date as a string
              let formatter = DateFormatter()
              formatter.dateStyle = .medium
              let dateString = formatter.string(from: expence.first?.dateAdded ?? Date())
              headerLabel.text = "\(dateString)"
              
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
      
      func navigateToSettlement(with amount: Double) {
          performSegue(withIdentifier: "Settlement", sender: amount)
      }
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "Settlement" {
              if let destinationVC = segue.destination as? SettlementViewController,
                 let amount = sender as? Double {
                  print("send amount \(amount)")
                  destinationVC.labelText = amount
              }
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
