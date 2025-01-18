
//
//  splitPalGroupsDataModel.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//
import Foundation
import UIKit

extension Notification.Name {
    static let newGroupAdded = Notification.Name("newGroupAdded")
}

struct Group {
//    var id: Int
    var groupName: String
    var category: UIImage?
    var members: [Int]
    var expenses: [ExpenseSplitForm]?
}


class GroupDataModel {
    private var groups: [Group] = []
    private var users: [User] = []
    
    static let shared = GroupDataModel()

    private init() {
        // Sample users
        users.append(User(id: 101, email: "user1@example.com", fullname: "John", password: "password", isVerified: true, badges: [], currentGoal: nil, expenses: []))
        users.append(User(id: 102, email: "user2@example.com", fullname: "Steve", password: "password", isVerified: true, badges: [], currentGoal: nil, expenses: []))
        users.append(User(id: 103, email: "user3@example.com", fullname: "Jack", password: "password", isVerified: true, badges: [], currentGoal: nil, expenses: []))

        // Sample groups
        groups.append(Group(
            groupName: "Tech Lovers",
            category: UIImage(named: "icons8-group-50"),
            members: [101, 102],
            expenses: nil
        ))
        groups.append(Group(
            groupName: "Travel Enthusiasts",
            category: UIImage(named: "icons8-group-50"),
            members: [103],
            expenses: nil
        ))
    }
    
    func createGroup(groupName: String, category: UIImage?, members: [Int]) {
           // Ensure that members array is not empty
           if members.isEmpty {
               print("Cannot create a group without members.")
               return
           }

           let newGroup = Group(groupName: groupName, category: category, members: members)
           groups.insert(newGroup, at: 0)
           print("New group added: \(newGroup.groupName)")  // Debugging line
           NotificationCenter.default.post(name: .newGroupAdded, object: nil)  // Notify the ViewController to reload the table view
       }

    // Fetch user data by userId
    func getUserById(_ userId: Int) -> User? {
        return users.first { $0.id == userId }
    }
    
    // Add a member to a group by groupName and userId
    func addMemberToGroup(groupName: String, userId: Int) {
        guard let groupIndex = groups.firstIndex(where: { $0.groupName == groupName }) else {
            print("Group not found!")
            return
        }

        if !groups[groupIndex].members.contains(userId) {
            groups[groupIndex].members.append(userId)
            print("User \(userId) added to group \(groupName).")
        } else {
            print("User \(userId) is already a member of the group.")
        }
    }
    
    func getAllGroups() -> [Group] {
        return self.groups
    }
}



//
//import Foundation
//import UIKit
//
//struct Group {
//    var id : Int
//    var groupName: String
//    var category: UIImage?
//    var members: [Int]
//}
//
//class GroupDataModel {
//    private var groups: [Group] = []
//    private var users: [User] = []
//    
//    static let shared = GroupDataModel()
//
//    private init() {
//        users.append(User(id: 101, email: "user1@example.com", fullname: "john", password: "password", isVerified: true, badges: [], currentGoal: nil, expenses: []))
//        users.append(User(id: 102, email: "user2@example.com", fullname: "steve", password: "password", isVerified: true, badges: [], currentGoal: nil, expenses: []))
//        users.append(User(id: 103, email: "user3@example.com", fullname: "jack", password: "password", isVerified: true, badges: [], currentGoal: nil, expenses: []))
//        
//        groups.append(Group(
//                    id: 1,
//                    groupName: "Tech",
//                    category: UIImage(named: "icons8-group-50"), // Replace with your image asset
//                    members: [101, 102]
//                ))
//                groups.append(Group(
//                    id: 2,
//                    groupName: "Gym Buddy's",
//                    category: UIImage(named: "icons8-runners-crossing-finish-line-50"), // Replace with your image asset
//                    members: [103]
//                ))
//    }
//
//    func createGroup(groupName: String, category: UIImage?, members: [Int]) {
//            // Check if groupName is unique
//            guard !groups.contains(where: { $0.groupName == groupName }) else {
//                print("Group with the name '\(groupName)' already exists.")
//                return
//            }
//            
//            // Check if all member IDs are valid
//            let invalidMembers = members.filter { userId in !users.contains(where: { $0.id == userId }) }
//            if !invalidMembers.isEmpty {
//                print("Invalid member IDs: \(invalidMembers)")
//                return
//            }
//            
//            // Create and append the new group
//            let newGroup = Group(id: (groups.last?.id ?? 0) + 1, groupName: groupName, category: category, members: members)
//            groups.append(newGroup)
//        }
//
//    func addMemberToGroup(groupName: String, userId: Int) {
//        if let groupIndex = groups.firstIndex(where: { $0.groupName == groupName }) {
//            if !groups[groupIndex].members.contains(userId) {
//                groups[groupIndex].members.append(userId)
//            }
//        }
//    }
//
//    func getAllGroups() -> [Group] {
//        return self.groups
//    }
//
//    func getGroupByName(groupName: String) -> Group? {
//        return groups.first { $0.groupName == groupName }
//    }
//
//    func addSplitExpense(expense: ExpenseSplitForm) {
//        guard let groupIndex = groups.firstIndex(where: { $0.id == expense.groupId }) else { return }
//
//        let group = groups[groupIndex]
//        let memberIds = group.members
//
//        for memberId in memberIds {
//            if let user = users.first(where: { $0.id == memberId }) {
//                print("Notifying \(user.fullname) about the new expense: \(expense.name)")
//            }
//        }
//    }
//}
