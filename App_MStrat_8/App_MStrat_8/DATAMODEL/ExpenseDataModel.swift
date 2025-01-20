//
//  ExpenseDataModel.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//
import Foundation
import UIKit

enum ExpenseCategory: String, CaseIterable {
    case car = "Car Rent"
    case rent = "Home Rent"
    case grocery = "Grocery"
    case gym = "Gym"
    case other = "Other"

    var associatedImage: UIImage {
        switch self {
        case .car: return UIImage(named: "icons8-car-50") ?? UIImage()
        case .rent: return UIImage(named: "icons8-home-50") ?? UIImage()
        case .grocery: return UIImage(named: "icons8-grocery-50 1") ?? UIImage()
        case .gym: return UIImage(named: "icons8-gym-50 1") ?? UIImage()
        case .other: return UIImage(named: "icons8-money-transfer-48") ?? UIImage()
        }
    }
}

struct Expense {
    let id: Int
    var itemName: String
    var amount: Int
    var image: UIImage
    var category: ExpenseCategory
    var duration: Date?
    var isRecurring: Bool
}

let firstExpense = Expense(
    id: 1,
    itemName: "Buy a New Laptop",
    amount: 1200,
    image: ExpenseCategory.car.associatedImage,
    category: .car,
    duration: DateFormatter().date(from: "2024-01-15"),
    isRecurring: false
)

let secondExpense = Expense(
    id: 2,
    itemName: "Vacation Fund",
    amount: 3000,
    image: ExpenseCategory.rent.associatedImage,
    category: .rent,
    duration: DateFormatter().date(from: "2024-06-01"),
    isRecurring: true
)

let thirdExpense = Expense(
    id: 3,
    itemName: "Emergency Savings",
    amount: 5000,
    image: ExpenseCategory.grocery.associatedImage,
    category: .grocery,
    duration: DateFormatter().date(from: "2025-12-31"),
    isRecurring: true
)

let fourthExpense = Expense(
    id: 4,
    itemName: "Pay Car Insurance",
    amount: 1500,
    image: ExpenseCategory.car.associatedImage,
    category: .car,
    duration: DateFormatter().date(from: "2020-01-15"),
    isRecurring: false
)

let fifthExpense = Expense(
    id: 5,
    itemName: "Monthly Rent",
    amount: 3000,
    image: ExpenseCategory.rent.associatedImage,
    category: .rent,
    duration: DateFormatter().date(from: "2025-06-01"),
    isRecurring: true
)

let sixthExpense = Expense(
    id: 6,
    itemName: "Grocery Shopping",
    amount: 200,
    image: ExpenseCategory.grocery.associatedImage,
    category: .grocery,
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
        expenses.append(fourthExpense)
        expenses.append(fifthExpense)
        expenses.append(sixthExpense)
    }

    func getAllExpenses() -> [Expense] {
        return self.expenses
    }

    func addExpense(itemName: String, amount: Int, image: UIImage, category: ExpenseCategory, duration: Date?, isRecurring: Bool) {
        // Generate a new ID by incrementing the last expense's ID (or default to 1 if the array is empty)
        let newId = (expenses.last?.id ?? 0) + 1

        // Create a new expense object
        let newExpense = Expense(id: newId, itemName: itemName, amount: amount, image: image, category: category, duration: duration, isRecurring: isRecurring)

        // Insert the new expense at the beginning of the array
        expenses.insert(newExpense,at: 0)

        // Optionally print or debug the new expense added
        print("New expense added: \(newExpense.itemName) with ID \(newExpense.id)")
    }

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
    
    func groupExpensesByDate() -> [String: [Expense]] {
           var groupedByDate: [String: [Expense]] = [:]
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd" // Format can be adjusted based on requirements
           
           // Grouping expenses by their duration
           for expense in expenses {
               guard let expenseDate = expense.duration else { continue } // Skip if there's no duration
               let dateKey = dateFormatter.string(from: expenseDate)
               
               if groupedByDate[dateKey] == nil {
                   groupedByDate[dateKey] = []
               }
               groupedByDate[dateKey]?.append(expense)
           }

           return groupedByDate
       }
    func groupedExpenses() -> [[Expense]] {
           let groupedByDate = groupExpensesByDate()
           return groupedByDate.values.map { $0 }
       }

       // Return section titles (date strings) sorted
       func sectionTitles() -> [String] {
           let groupedByDate = groupExpensesByDate()
           return groupedByDate.keys.sorted()
       }

    private func promptUserForRecurringExpense(_ expense: Expense) {
        print("Do you want to add \(expense.itemName) again?")
    }
}
