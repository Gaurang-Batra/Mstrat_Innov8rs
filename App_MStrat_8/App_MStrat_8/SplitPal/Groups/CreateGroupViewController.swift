import UIKit

struct cgroup {
    var name : String
    var image : UIImage
    init(name: String, image: UIImage?) {
           self.name = name
        self.image = image!
       }
}

protocol AddMemberDelegate: AnyObject {
    func didUpdateSelectedMembers(_ members: [Int])
}

class CreateGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddMemberCellDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var categoryButton: [UIButton]!
    @IBOutlet var creategroupbutton: UIView!
    @IBOutlet weak var Mytable: UITableView!
    @IBOutlet weak var Mysearchtext: UISearchBar!

    let imageNames = ["icons8-holiday-50", "icons8-bunglaw-50", "icons8-kawaii-pizza-50", "icons8-movie-50", "icons8-gym-50-2", "icons8-more-50-2"]
    var selectedImage: UIImage?

    var users: [User] = []       // To hold all users
    var searchUsers: [User] = [] // To hold the filtered users
    var selectedMembers: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up category buttons
        for (index, button) in categoryButton.enumerated() {
            if index < imageNames.count {
                let image = UIImage(named: imageNames[index])
                button.setImage(image, for: .normal)
            }
        }

        users = UserDataModel.shared.getAllUsers()
        searchUsers = users // Initialize searchUsers with all users

        Mytable.delegate = self
        Mytable.dataSource = self
        Mysearchtext.delegate = self
        addSFSymbolToAddMemberButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Mytable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AddmemberCellTableViewCell else {
            return UITableViewCell()
        }

        let user = searchUsers[indexPath.row]
        cell.configure(with: user)
        cell.delegate = self // Set the delegate to self
        return cell
    }

    func didTapInviteButton(for user: User) {
        if !selectedMembers.contains(user.id) {
            selectedMembers.append(user.id)
            print("Selected Members: \(selectedMembers)")
        } else {
            // Remove the user if they are already in the list
            selectedMembers.removeAll { $0 == user.id }
            print("Removed Member: \(user.id), Selected Members: \(selectedMembers)")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchUsers = users
        } else {
            searchUsers = users.filter { $0.fullname.lowercased().contains(searchText.lowercased()) }
        }
        Mytable.reloadData()
    }

    @IBAction func categoryButtontapped(_ sender: UIButton) {
        // Reset button tint to gray
        for button in categoryButton {
            button.tintColor = .systemGray3
            button.backgroundColor = .clear
        }
        
        // Highlight the clicked button
        sender.tintColor = .systemBlue
        sender.backgroundColor = .lightGray
        selectedImage = sender.image(for: .normal)
        sender.isEnabled = true
    }

    @IBAction func cancelbuttontapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createGroupButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

        guard let groupName = textField.text, !groupName.isEmpty, let selectedImage = selectedImage else {
            return
        }

        GroupDataModel.shared.createGroup(groupName: groupName, category: selectedImage, members: selectedMembers)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Segue Preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Groupsdetails",
           let destinationVC = segue.destination as? SplitpalViewController {
            destinationVC.selectedImage = selectedImage
        }
    }

    func addSFSymbolToAddMemberButton() {
        if let symbolImage = UIImage(systemName: "person.fill.badge.plus") {
            var config = UIButton.Configuration.plain()
            config.imagePadding = 8
            config.imagePlacement = .leading
        }
    }
}
