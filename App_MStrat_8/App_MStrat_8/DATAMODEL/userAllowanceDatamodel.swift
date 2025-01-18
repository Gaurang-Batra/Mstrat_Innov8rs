//
//  userAllowanceDatamodel.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//

import Foundation

struct Allowance {
    var amount: Double
    var isRecurring: Bool
    var duration: Duration?
    var customDate: Date?
    mutating func deductAmount(_ expenseAmount: Double) {
           if expenseAmount <= amount {
               amount -= expenseAmount
           } else {
               print("Insufficient allowance. Cannot deduct \(expenseAmount).")
           }
       }
}

enum Duration: String {
    case oneWeek = "1 Week"
    case twoWeeks = "2 Weeks"
    case oneMonth = "1 Month"
    case twoMonths = "2 Months"
    case custom = "Custom"
}

let firstAllowance = Allowance(amount: 50.0, isRecurring: true, duration: .oneWeek, customDate: nil)
let secondAllowance = Allowance(amount: 100.0, isRecurring: false, duration: nil, customDate: Date())
let thirdAllowance = Allowance(amount: 75.0, isRecurring: true, duration: .oneMonth, customDate: nil)

class AllowanceDataModel {
    private var allowances: [Allowance] = []
    static let shared = AllowanceDataModel()
    
    private init() {
        allowances.append(firstAllowance)
        allowances.append(secondAllowance)
        allowances.append(thirdAllowance)
    }
    
    func getAllAllowances() -> [Allowance] {
        return self.allowances
    }
    
    func getAllowances(by duration: Duration) -> [Allowance] {
        return allowances.filter { $0.duration == duration }
    }
    
    func addAllowance(_ allowance: Allowance) {
        allowances.append(allowance)
    }
    func deductExpense(fromAllowance index: Int, expenseAmount: Double) {
            guard allowances.indices.contains(index) else {
                print("Invalid allowance index.")
                return
            }
            allowances[index].deductAmount(expenseAmount)
        }
}
