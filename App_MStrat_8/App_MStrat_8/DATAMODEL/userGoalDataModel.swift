//
//  userGoalDataModel.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//

import Foundation

//for Goal-----------

struct Goal {
    let id: Int
    var title: String
    var amount: Int
    var deadline: Date
    var savings: Int
    var type: GoalType
}
enum GoalType {
    case daily
    case weekly
    case monthly
    case yearly
    case custom
}


let firstGoal = Goal(id: 1, title: "Buy a New Laptop", amount: 1200, deadline: DateFormatter().date(from: "2025-01-15")!, savings: 78, type: .yearly)
let secondGoal = Goal(id: 2, title: "Vacation Fund", amount: 3000, deadline: DateFormatter().date(from: "2025-06-01")!, savings: 787, type: .monthly)
let thirdGoal = Goal(id: 3, title: "Emergency Savings", amount: 5000, deadline: DateFormatter().date(from: "2025-12-31")!, savings: 454, type: .daily)

class GoalDataModel {
    private var goals: [Goal] = []
    static let shared = GoalDataModel()

    private init() {
        goals.append(firstGoal)
        goals.append(secondGoal)
        goals.append(thirdGoal)
    }

    func getAllGoals() -> [Goal] {
        return self.goals
    }

    func addGoal(_ goal: Goal) {
        goals.append(goal)
    }

    func getGoal(by id: Int) -> Goal? {
        return goals.first { $0.id == id }
    }
    func addSavings(toGoalWithId id: Int, amount: Int) {
        guard let index = goals.firstIndex(where: { $0.id == id }) else { return }
        goals[index].savings += amount
        if goals[index].savings > goals[index].amount {
            print("Congratulations! You've exceeded your goal savings for \(goals[index].title).")
        } else {
            print("Added \(amount) to \(goals[index].title). Current savings: \(goals[index].savings) out of \(goals[index].amount).")
        }
    }


//    func deleteGoal(by id: Int) {
//        if let index = goals.firstIndex(where: { $0.id == id }) {
//            goals.remove(at: index)
//        }
//    }
}
