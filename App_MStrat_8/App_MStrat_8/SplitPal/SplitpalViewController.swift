//
//  SplitpalViewController.swift
//  App_MStrat_8
//
//  Created by Gaurang  on 04/12/24.
//

import UIKit

class SplitpalViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Balanceviewcontainer: UIView!
    
    @IBOutlet weak var Groupsviewcontainer: UIView!
    
    
    @IBOutlet weak var addgroupbutton: UIButton!
    
    
    @IBOutlet weak var welcomeimage: UIImageView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
        
        
        if let image = UIImage(named: "Group")
        {
            welcomeimage.image = image
        }
        
        
        Balanceviewcontainer.layer.cornerRadius = 20
        Balanceviewcontainer.layer.masksToBounds = true
        
        setTopCornerRadius(for: Groupsviewcontainer, radius: 20)
        
        createVerticalDottedLineInBalanceContainer(atX: Balanceviewcontainer.bounds.size.width / (5/2))
        
        addgroupbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        addgroupbutton.titleLabel?.textAlignment = .center
        
        
        
        makeButtonCircular()
        tableView.separatorStyle = .singleLine
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .newGroupAdded, object: nil)
        
        // Initial reload (if needed)
        tableView.reloadData()
        
        
        
    }
    @objc func reloadTableView() {
        tableView.reloadData()
    }
    
    func setTopCornerRadius(for view: UIView, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Determine the scale factor to preserve aspect ratio
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Calculate the new size
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        
        // Resize the image
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage ?? image
    }
    func createVerticalDottedLineInBalanceContainer(atX xPosition: CGFloat) {
        let dottedLine = CAShapeLayer()
        
        // Create a UIBezierPath for the line
        let path = UIBezierPath()
        
        // Center the line vertically (Y-axis remains fixed)
        let centerY = Balanceviewcontainer.bounds.size.height / 2
        
        // Define the length of the line (in points)
        let lineLength: CGFloat = 98 // You can change this value
        
        // Calculate the starting and ending Y coordinates to center the line vertically
        let startY = centerY - (lineLength / 2)  // Start Y is half of the line length above center
        let endY = startY + lineLength          // End Y is half of the line length below center
        
        // Start point at the provided X position and calculated start Y
        path.move(to: CGPoint(x: xPosition, y: startY))
        
        // End point at the provided X position and calculated end Y
        path.addLine(to: CGPoint(x: xPosition, y: endY))
        
        // Assign the path to the CAShapeLayer
        dottedLine.path = path.cgPath
        dottedLine.strokeColor = UIColor.black.withAlphaComponent(0.4).cgColor // Adjust opacity
        dottedLine.lineWidth = 1.5 // Thickness of the line
        
        // Set the line to be dotted (dash pattern)
        dottedLine.lineDashPattern = [6, 2] // Dash length and space length
        
        // Add the dotted line to the Balanceviewcontainer's layer
        Balanceviewcontainer.layer.addSublayer(dottedLine)
    }
    
    // Function to make the UIImageView circular
    func makeButtonCircular() {
        // Ensure the button is square by checking both width and height
        let sideLength = min(addgroupbutton.frame.size.width, addgroupbutton.frame.size.height)
        
        // Make the button circular by setting the corner radius to half the side length
        addgroupbutton.layer.cornerRadius = sideLength / 2
        
        // Enable masksToBounds to make sure the content fits inside the rounded corner
        addgroupbutton.layer.masksToBounds = true
    }
    // MARK: - UITableViewDataSource Methods
    
    var selectedGroupIndex: Int? = nil
    var selectedImage: UIImage? = nil
    
    @IBOutlet weak var tableView: UITableView!
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return GroupDataModel.shared.getAllGroups().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1  // One row per group
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SplitCell", for: indexPath)
        
        // Fetch the group
        let group = GroupDataModel.shared.getAllGroups()[indexPath.section]
        
        // Configure the cell
        cell.textLabel?.text = group.groupName
        cell.imageView?.image = group.category ?? UIImage(systemName: "photo")  // Placeholder image
        
        return cell
    }
    
    deinit {
            // Remove the observer when the view controller is deallocated
            NotificationCenter.default.removeObserver(self, name: .newGroupAdded, object: nil)
        }

    // MARK: - UITableViewDelegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Set the selected group index
        selectedGroupIndex = indexPath.section
        
        // Perform segue to the group details screen
        performSegue(withIdentifier: "Groupsdetails", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Space between sections
    }

    // MARK: - Segue Preparation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Groupsdetails",
           let destinationVC = segue.destination as? GroupDetailViewController,
           let selectedIndex = selectedGroupIndex {
            // Fetch the selected group from the model
            let selectedGroup = GroupDataModel.shared.getAllGroups()[selectedIndex]
            
            // Pass the selected group to the detail view controller
            destinationVC.groupItem = selectedGroup
        }
        //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //        let view = UIView()
        //        view.backgroundColor = .clear // Make the footer transparent
        //        return view
        //    }
        //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //           return 10 // This adds space after each row
        //       }
        
        
        
    }
}
