//
//  AddmemberCellTableViewCell.swift
//  App_MStrat_8
//
//  Created by student-2 on 14/01/25.
//

import UIKit

class AddmemberCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var invitebutton: UIButton!
    var userId: Int? // To store the user ID associated with this button
    var groupName: String? // Group name to add the user to when invited
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        invitebutton.addTarget(self, action: #selector(inviteButtonClicked), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Action when the button is clicked
    @objc func inviteButtonClicked() {
        guard let userId = userId else { return }
        
        // Get user data from the shared GroupDataModel
        if let user = GroupDataModel.shared.getUserById(userId) {
            print("User's name: \(user.fullname)")  // Print user data to console
            
            // Optionally add the user to a group (if needed)
            if let groupName = groupName {
                GroupDataModel.shared.addMemberToGroup(groupName: groupName, userId: userId)
            }
            
            // Change button state to indicate that the invitation was sent
            invitebutton.setTitle("Sent", for: .normal)
            invitebutton.setTitleColor(.white, for: .normal)  // Set the title color to white
            invitebutton.backgroundColor = .green
            invitebutton.isEnabled = false   // Disable the button after sending the invitation
        }
    }
    
    // Configure the cell with a user ID and group name
    func configure(with userId: Int, groupName: String) {
        self.userId = userId
        self.groupName = groupName
    }
}
