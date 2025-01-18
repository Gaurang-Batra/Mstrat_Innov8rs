//
//  AddMemberViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 13/01/25.
//
import UIKit

class AddMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
    @IBOutlet weak var Mysearchtext: UISearchBar!
    
    @IBOutlet weak var Mytable: UITableView!
  
    
 
    
    @IBAction func cancelbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var users: [User] = [] // To hold all users
       var searchUsers: [User] = [] // To hold the filtered users

       override func viewDidLoad() {
           super.viewDidLoad()

           // Fetch all users from the UserDataModel
           users = UserDataModel.shared.getAllUsers()
           searchUsers = users // Initializing searchUsers with all users

           Mytable.delegate = self
           Mytable.dataSource = self

       
       }

       // TableView DataSource Methods
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return searchUsers.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Ensure the cell is dequeued properly with the correct identifier
           guard let cell = Mytable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AddmemberCellTableViewCell else {
               return UITableViewCell() // Return a default cell if casting fails
           }

           // Configure the cell
           let user = searchUsers[indexPath.row]
           cell.configure(with: user.id, groupName: "Tech Lovers") // Assuming you want to add the user to this group
           cell.textLabel?.text = user.fullname

           return cell
       }

       // Search Bar Delegate Method
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           // Filter users based on search text
           if searchText.isEmpty {
               searchUsers = users // If empty, show all users
           } else {
               searchUsers = users.filter { $0.fullname.lowercased().contains(searchText.lowercased()) }
           }
           Mytable.reloadData()
       }
}
