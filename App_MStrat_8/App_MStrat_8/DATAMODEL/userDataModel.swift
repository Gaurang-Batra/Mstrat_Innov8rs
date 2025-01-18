//
//  userDataModel.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//

import Foundation

//user-----------
struct User {
    let id: Int
    var email: String
    var fullname: String
    var password: String
    var isVerified: Bool
    var badges: [String]
    var currentGoal: Goal?
    var expenses: [Expense]
}

let firstUser = User(
    id: 1,
    email: "johndoe@example.com",
    fullname: "John Doe",
    password: "password123",
    isVerified: true,
    badges: [],
    currentGoal: nil,
    expenses: []
)
let secondUser = User(
    id: 2,
    email: "janesmith@example.com",
    fullname: "Jane Smith",
    password: "password456",
    isVerified: false,
    badges: [],
    currentGoal: nil,
    expenses: []
)
let thirdUser = User(
    id: 3,
    email: "alicej@example.com",
    fullname: "Alice Johnson",
    password: "password789",
    isVerified: true,
    badges: [],
    currentGoal: nil,
    expenses: []
)

class UserDataModel {
    private var users: [User] = []
    static let shared = UserDataModel()

    private init() {
        users.append(firstUser)
        users.append(secondUser)
        users.append(thirdUser)
    }

    func getAllUsers() -> [User] {
        return self.users
    }

    func getUser(by id: Int) -> User? {
        return users.first { $0.id == id }
    }

    func assignGoal(to userId: Int, goal: Goal) {
        guard let index = users.firstIndex(where: { $0.id == userId }) else { return }
        users[index].currentGoal = goal

        let badge: String
        switch goal.type {
        case .yearly:
            badge = "Monthly Achiever"
        case .monthly:
            badge = "Weekly Achiever"
        case .weekly:
            badge = "Daily Achiever"
        case .daily:
            badge = "Quick Challenger"
        case .custom:
            badge = "Custom Achiever"
        }

        users[index].badges.append(badge)
    }

    func getUserBadges(for userId: Int) -> [String] {
        return users.first { $0.id == userId }?.badges ?? []
    }
}
