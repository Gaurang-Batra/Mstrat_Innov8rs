//
//  CensusViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 15/01/25.
//

import UIKit

class CensusViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var expenses: [Expense] = []
        var groupedExpenses: [[Expense]] = []  // Array to store grouped expenses by date
        var sectionDates: [String] = []  // Dates for sections
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Assign delegates
            tableView.delegate = self
            tableView.dataSource = self

            // Load expenses from the shared data model
            expenses = ExpenseDataModel.shared.getAllExpenses()

            // Sort and group expenses by date
            groupExpensesByDate()

            // Remove the separator lines between table cells
            tableView.separatorStyle = .none

            // Round corners of the table view
            tableView.layer.cornerRadius = 15  // Adjust the corner radius as needed
            tableView.clipsToBounds = true      // Ensure content is clipped to rounded corners

            // Set row height for table view
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
        }

        // MARK: - Table View Delegate Methods

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100 // Fixed height for each row
        }

        // MARK: - Table View Data Source Methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return groupedExpenses.count  // Return the number of sections based on the grouped expenses
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return groupedExpenses[section].count  // Return the number of rows for the current section
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAllCensusTableViewCell", for: indexPath) as? ViewAllCensusTableViewCell else {
                fatalError("Unable to dequeue ViewAllCensusTableViewCell")
            }

            let expense = groupedExpenses[indexPath.section][indexPath.row]

            // Configure the cell with expense data
            cell.expenseimage.image = expense.image
            cell.pricelabel.text = "$\(expense.amount)"
//            cell.categorylabel.text = expense.category
            cell.titlelabel.text = expense.itemName

            return cell
        }

        // MARK: - Custom Header Setup

        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionDates[section]  // Return the date for the current section
        }

        // MARK: - Grouping and Sorting Expenses by Date

        private func groupExpensesByDate() {
            // First, sort the expenses by date
            let sortedExpenses = expenses.sorted { (expense1, expense2) -> Bool in
                guard let date1 = expense1.duration, let date2 = expense2.duration else {
                    return false
                }
                return date1 < date2  // Sort by date in ascending order
            }
            
            // Group expenses by date after sorting
            var grouped: [String: [Expense]] = [:]
            
            for expense in sortedExpenses {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"  // Format the date to display in a readable format
                let dateString = dateFormatter.string(from: expense.duration ?? Date())
                
                if grouped[dateString] == nil {
                    grouped[dateString] = []
                }
                
                grouped[dateString]?.append(expense)
            }

            // Assign grouped expenses to the groupedExpenses array
            groupedExpenses = Array(grouped.values)
            
            // Assign section titles (dates)
            sectionDates = Array(grouped.keys).sorted()  // Sort the section dates (headers)
        }

}
