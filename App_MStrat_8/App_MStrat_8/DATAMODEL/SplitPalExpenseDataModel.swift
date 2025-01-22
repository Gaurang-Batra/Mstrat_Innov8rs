//
//  SplitPalExpenseDataModel.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//

import Foundation
import UIKit


//for creating expense split form ----------------
struct ExpenseSplitForm {
    var name: String
    var category: String
    var totalAmount: Double
    var paidBy: String
    var groupId: Int
    var image: UIImage?
    var splitOption: SplitOption?
    var splitAmounts: [String: Double]?
//    var payee : [Int:String]
    var payee : String
    var date: Date
    var ismine: Bool
}

enum SplitOption {
    case equally
    case unequally
}

class SplitExpenseDataModel {
    private var expenseSplits: [ExpenseSplitForm] = []
    static let shared = SplitExpenseDataModel()

    private init() {
        
//        let payeeIdToName: [Int: String] = [
//                1: "Ajay (You)",
//                2: "John Doe",
//                3: "Alice Johnson"
//            ]
        
        
        let firstExpenseSplit = ExpenseSplitForm(
            name: "Dinner with Friends",
            category: "Food",
            totalAmount: 100.0,
            paidBy: "Ajay (You)",
            groupId: 1,
            image: UIImage(named: "icons8-holiday-50")!,
            splitOption: .equally,
            splitAmounts: nil,
//            payee: [1:"josh" ,2:"vipul"],
            payee: "aj",
            date: Date(),
            ismine: true
        )
        
        let thirdExpenseSplit = ExpenseSplitForm(
            name: "Dinner with Friends",
            category: "Food",
            totalAmount: 100.0,
            paidBy: "kn",
            groupId: 1,
            image: UIImage(named: "icons8-holiday-50")!,
            splitOption: .equally,
            splitAmounts: nil,
//            payee: [1:"josh" ,2:"vipul"],
            payee: "Ajay (You)",
            date: Date(),
            ismine: true
        )
        
        let forthExpenseSplit = ExpenseSplitForm(
            name: "Dinner with Friends",
            category: "Food",
            totalAmount: 100.0,
            paidBy: "kn",
            groupId: 1,
            image: UIImage(named: "icons8-holiday-50")!,
            splitOption: .equally,
            splitAmounts: nil,
//            payee: [1:"josh" ,2:"vipul"],
            payee: "Ajay",
            date: Date(),
            ismine: true
        )
        
        
        
        let secondExpenseSplit = ExpenseSplitForm(
            name: "Trip Expense",
            category: "Travel",
            totalAmount: 500.0,
            paidBy: "Alice Johnson",
            groupId: 2,
            image: UIImage(named: "icons8-holiday-50")!,
            splitOption: .unequally,
            splitAmounts: ["John Doe": 200.0, "Alice Johnson": 300.0],
//            payee: [2:"vipul"],
            payee: "kj",
            date: Date(),
            ismine: false
        )
        
        expenseSplits.append(firstExpenseSplit)
        expenseSplits.append(secondExpenseSplit)
        expenseSplits.append(thirdExpenseSplit)
        expenseSplits.append(forthExpenseSplit)
        
    }

    func getAllExpenseSplits() -> [ExpenseSplitForm] {
        return self.expenseSplits
    }

    func getExpenseSplits(forGroup groupId: Int) -> [ExpenseSplitForm] {
        return expenseSplits.filter { $0.groupId == groupId }
    }

    func getAmountToBePaid(by participant: String, for expense: ExpenseSplitForm) -> Double? {
        if let splitAmounts = expense.splitAmounts {
            return splitAmounts[participant]
        }
        return nil
    }

    func addExpenseSplit(expense: ExpenseSplitForm) {
        expenseSplits.append(expense)
    }

    func updateSplitAmounts(expense: inout ExpenseSplitForm, newSplitAmounts: [String: Double]) {
        if expense.splitOption == .unequally {
            expense.splitAmounts = newSplitAmounts
        }
    }

    func deleteExpenseSplit(name: String) {
        if let index = expenseSplits.firstIndex(where: { $0.name == name }) {
            expenseSplits.remove(at: index)
        }
    }
}
