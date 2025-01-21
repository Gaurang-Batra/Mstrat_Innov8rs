//
//  ExpenseDataModel.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//
import Foundation
import UIKit

enum ExpenseCategory: String, CaseIterable {
    case food = "Food"
    case grocery = "Grocery"
    case fuel = "Fuel"
    case bills = "Bills"
    case travel = "Travel"
    case other = "Other"
    

    var associatedImage: UIImage {
        switch self {
        case .food:
//            print("inside food")
            return UIImage(named: "icons8-kawaii-pizza-50") ?? UIImage()
        case .grocery:
//            print("inside grocery")
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
    
//    var associatedImage: UIImage {
//            switch self {
//            case .food:
//                let image = UIImage(named: "icons8-kawaii-pizza-50")
//                print("Food image loaded: \(image != nil)")
//                return image ?? UIImage()
//            case .grocery:
//                let image = UIImage(named: "icons8-vegetarian-food-50")
//                print("Grocery image loaded: \(image != nil)")
//                return image ?? UIImage()
//            case .fuel:
//                let image = UIImage(named: "icons8-fuel-50")
//                print("Fuel image loaded: \(image != nil)")
//                return image ?? UIImage()
//            case .bills:
//                let image = UIImage(named: "icons8-cheque-50")
//                print("Bills image loaded: \(image != nil)")
//                return image ?? UIImage()
//            case .travel:
//                let image = UIImage(named: "icons8-holiday-50")
//                print("Travel image loaded: \(image != nil)")
//                return image ?? UIImage()
//            case .other:
//                let image = UIImage(named: "icons8-more-50-2")
//                print("Other image loaded: \(image != nil)")
//                return image ?? UIImage()
//            }
//        }
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
    itemName: "food wash",
    amount: 1200,
    image: ExpenseCategory.food.associatedImage,
    category: .food,
    duration: DateFormatter().date(from: "2024-01-15"),
    isRecurring: false
)

let secondExpense = Expense(
    id: 2,
    itemName: "home grocery",
    amount: 3000,
    image: ExpenseCategory.grocery.associatedImage,
    category: .grocery,
    duration: DateFormatter().date(from: "2024-06-01"),
    isRecurring: true
)

let thirdExpense = Expense(
    id: 3,
    itemName: "Banana",
    amount: 5000,
    image: ExpenseCategory.grocery.associatedImage,
    category: .grocery,
    duration: DateFormatter().date(from: "2025-12-31"),
    isRecurring: true
)

let fourthExpense = Expense(
    id: 4,
    itemName: "Pay food Insurance",
    amount: 1500,
    image: ExpenseCategory.food.associatedImage,
    category: .food,
    duration: DateFormatter().date(from: "2020-01-15"),
    isRecurring: false
)

let fifthExpense = Expense(
    id: 5,
    itemName: "Monthly grocery",
    amount: 3000,
    image: ExpenseCategory.grocery.associatedImage,
    category: .grocery,
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
