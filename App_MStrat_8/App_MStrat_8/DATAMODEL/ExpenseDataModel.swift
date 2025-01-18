//
//  ExpenseDataModel.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//

import Foundation
import UIKit

enum ExpenseCategory: String, CaseIterable {
    case car = "Car rent "
    case rent = "home Rent"
    case grocery = "Grocery"
    case gym = "Gym"
    case other = "Other"
}

struct Expense {
    let id: Int
    var itemName: String
    var amount: Int
    var image: UIImage
//    var category: ExpenseCategory
    var category : String
    var duration: Date?
    var isRecurring: Bool
}

let firstExpense = Expense(
    id: 1,
    itemName: "Buy a New Laptop",
    amount: 1200,
    image: UIImage(named: "icons8-car-16") ?? UIImage(),
    category: "Car",
    duration: DateFormatter().date(from: "2024-01-15"),
    isRecurring: false
)

let secondExpense = Expense(
    id: 2,
    itemName: "Vacation Fund",
    amount: 3000,
    image: UIImage(named: "icons8-grocery-50") ?? UIImage(),
    category: "home Rent",
    duration: DateFormatter().date(from: "2024-06-01"),
    isRecurring: true
)

let thirdExpense = Expense(
    id: 3,
    itemName: "Emergency Savings",
    amount: 5000,
    image: UIImage(named: "icons8-grocery-50") ?? UIImage(),
    category: "Grocery",
    duration: DateFormatter().date(from: "2025-12-31"),
    isRecurring: true
)

let forthExpense = Expense(
    id: 1,
    itemName: "Buy a New Laptop",
    amount: 1200,
    image: UIImage(named: "icons8-car-16") ?? UIImage(),
    category: "Car",
    duration: DateFormatter().date(from: "2020-01-15"),
    isRecurring: false
)

let FifthExpense = Expense(
    id: 2,
    itemName: "Vacation Fund",
    amount: 3000,
    image: UIImage(named: "icons8-grocery-50") ?? UIImage(),
    category: "home Rent",
    duration: DateFormatter().date(from: "2025-06-01"),
    isRecurring: true
)

let sixthExpense = Expense(
    id: 3,
    itemName: "Emergency Savings",
    amount: 5000,
    image: UIImage(named: "icons8-grocery-50") ?? UIImage(),
    category: "Grocery",
    duration: DateFormatter().date(from: "2025-12-31"),
    isRecurring: true
)

let seventhExpense = Expense(
    id: 1,
    itemName: "Buy a New Laptop",
    amount: 1200,
    image: UIImage(named: "icons8-car-16") ?? UIImage(),
    category: "Car",
    duration: DateFormatter().date(from: "2025-01-15"),
    isRecurring: false
)

let eightthExpense = Expense(
    id: 2,
    itemName: "Vacation Fund",
    amount: 3000,
    image: UIImage(named: "icons8-grocery-50") ?? UIImage(),
    category: "home Rent",
    duration: DateFormatter().date(from: "2025-06-01"),
    isRecurring: true
)

let ninethExpense = Expense(
    id: 3,
    itemName: "Emergency Savings",
    amount: 5000,
    image: UIImage(named: "icons8-grocery-50") ?? UIImage(),
    category: "Grocery",
    duration: DateFormatter().date(from: "2025-12-31"),
    isRecurring: true
)

class ExpenseDataModel {
    private var expenses: [Expense] = []
    static let shared = ExpenseDataModel()

    private init() {
        expenses.append(firstExpense)
        expenses.append(secondExpense)
        expenses.append(thirdExpense)
        expenses.append(forthExpense)
        expenses.append(FifthExpense)
        expenses.append(sixthExpense)
        expenses.append(seventhExpense)
        expenses.append(eightthExpense)
        expenses.append(ninethExpense)
    }

    func getAllExpenses() -> [Expense] {
        return self.expenses
    }

//    func addExpense(_ expense: Expense) {
//        if ExpenseCategory.allCases.contains(expense.category) {
//            expenses.append(expense)
//            AllowanceDataModel.shared.deductExpense(fromAllowance: 0, expenseAmount: Double(expense.amount))
//        } else {
//            print("Invalid category. Expense not added.")
//        }
//    }
    
        

    func checkRecurringExpenses() {
        let currentDate = Date()

        for expense in expenses {
            if expense.isRecurring, let duration = expense.duration {
                if Calendar.current.isDate(currentDate, inSameDayAs: duration) {
                    promptUserForRecurringExpense(expense)
                }
            }
        }
    }

    private func promptUserForRecurringExpense(_ expense: Expense) {
        print("Do you want to add \(expense.itemName) again?")
    }
}
