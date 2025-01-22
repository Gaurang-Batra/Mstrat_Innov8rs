//
//  BillViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 20/12/24.
//
import UIKit

class Cellclass: UITableViewCell {
    // You can customize this cell further if needed.
}

class BillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var categorybutton: UIButton!
    @IBOutlet weak var titletextfield: UITextField!
    @IBOutlet weak var pricetextfield: UITextField!

    @IBOutlet weak var payerbutton: UIButton!
    
    let transparentview = UIView()
    let tableview = UITableView()
    var selectedbutton = UIButton()
    var dataSource = [String]()  // List of items to show in the tableview

    private let users = UserDataModel.shared.getAllUsers()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customizing the text fields
        customizeTextField(titletextfield)
        customizeTextField(pricetextfield)
     

        // Setting up the tableview
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(Cellclass.self, forCellReuseIdentifier: "Cell")

        // Customizing the category button with underline
        addUnderlineToButton(categorybutton)
        addUnderlineToButton(payerbutton)

    }

    private var underlineLayers: [UIButton: CALayer] = [:]

    private func addUnderlineToButton(_ button: UIButton) {
        // Remove any existing underline for the specific button
        underlineLayers[button]?.removeFromSuperlayer()
        
        // Add a new underline using CALayer
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: button.frame.height - 2, width: button.frame.width, height: 2)
        underline.backgroundColor = UIColor.lightGray.cgColor
        button.layer.addSublayer(underline)
        
        // Store the reference to the underline layer for the button
        underlineLayers[button] = underline
    }



    private func customizeTextField(_ textField: UITextField) {
        // Remove border
        textField.borderStyle = .none
        
        // Add underline to the textfield
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        underline.backgroundColor = UIColor.lightGray.cgColor
        textField.layer.addSublayer(underline)
    }

    // Method to show the transparent view and table when category button is clicked
    func addtransparentView(frames: CGRect) {
        // Get the active window in the current scene.
        guard let windowScene = view.window?.windowScene else {
            return
        }
        
        // Get the key window of the current scene
        if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            transparentview.frame = window.frame
            self.view.addSubview(transparentview)
            
            // Set the table view position and size
            tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            self.view.addSubview(tableview)
            tableview.layer.cornerRadius = 8

            tableview.reloadData()

            // Set the background color of the transparent view
            transparentview.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            
            // Add a tap gesture to remove the transparent view
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
            transparentview.addGestureRecognizer(tapgesture)
            
            // Initially hide the table
            transparentview.alpha = 0
            
            // Animate the appearance of the transparent view and table
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentview.alpha = 0.5
                self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
            }, completion: nil)
        }
    }

    @objc func removeTransparentView(){
        let frames = selectedbutton.frame
        
        // Animate the disappearance of the transparent view and table
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentview.alpha = 0
            self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
    @IBAction func Payerbuttontapped(_ sender: Any) {
        
        dataSource = ["ajay", "Arush", "deepak"]
        selectedbutton = payerbutton
        addtransparentView(frames: payerbutton.frame)
        
    }
    
    // Action when category button is clicked
    @IBAction func Categorybutton(_ sender: Any) {
        dataSource = ["Grocery", "Food", "Rent", "Fuel", "Car","Entertainment","Grocery", "Food", "Rent", "Fuel", "Car","Entertainment"]
        selectedbutton = categorybutton
        addtransparentView(frames: categorybutton.frame)
    }

    // MARK: - TableView DataSource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cellclass
        
        // Set the text of each cell
        cell.textLabel?.text = dataSource[indexPath.row]
        
        // Uncomment and customize if you want to use user data instead of strings
        // let user = users[indexPath.row]
        // cell.textLabel?.text = user.fullname
        
        return cell
    }

    // Action when a table row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedbutton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }

    // Set the height of each row in the tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
