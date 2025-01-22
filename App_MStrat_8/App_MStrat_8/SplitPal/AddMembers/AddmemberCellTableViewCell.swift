//
//  AddmemberCellTableViewCell.swift
//  App_MStrat_8
//
//  Created by student-2 on 14/01/25.
//
import UIKit

protocol AddMemberCellDelegate: AnyObject {
    func didTapInviteButton(for user: User)
}

class AddmemberCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var invitebutton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!

    weak var delegate: AddMemberCellDelegate? // Delegate to notify the parent controller
    private var user: User?        // To store the associated user
    
    override func awakeFromNib() {
        super.awakeFromNib()
        invitebutton.addTarget(self, action: #selector(inviteButtonClicked), for: .touchUpInside)
    }
    
    @objc func inviteButtonClicked() {
        guard let user = user else {
            print("No user associated with this cell.")
            return
        }

        // Notify the delegate
        delegate?.didTapInviteButton(for: user)

        // Update button state
        invitebutton.setTitle("Sent", for: .normal)
        invitebutton.setTitleColor(.white, for: .normal)
        invitebutton.backgroundColor = .green
        invitebutton.isEnabled = false
    }
    
    // Configure the cell with user data
    func configure(with user: User) {
        self.user = user
        nameLabel.text = user.fullname
        invitebutton.setTitle("Invite", for: .normal)
        invitebutton.setTitleColor(.systemBlue, for: .normal)
        invitebutton.backgroundColor = .clear
        invitebutton.isEnabled = true
    }
}
