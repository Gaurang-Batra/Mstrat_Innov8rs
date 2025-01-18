//
//  BillViewController.swift
//  App_MStrat_8
//
//  Created by student-2 on 20/12/24.
//

import UIKit
class Cellclass: UITableViewCell {
    
    
}

class BillViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  

  
    @IBOutlet weak var titletextfield: UITextField!
    
    @IBOutlet weak var pricetextfield: UITextField!
    
    @IBOutlet weak var categorybutton: UIButton!
    
    
    @IBOutlet weak var paidbytextfield: UITextField!
    
    let transparentview = UIView()
    let tableview = UITableView()
    var selectedbutton = UIButton()
    var dataSource = [String]()
    
    
    private let users = UserDataModel.shared.getAllUsers()
    
    override func viewDidLoad() {
           super.viewDidLoad()

           customizeTextField(titletextfield)
           customizeTextField(pricetextfield)
           
           customizeTextField(paidbytextfield)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(Cellclass.self, forCellReuseIdentifier: "Cell")
        
        addUnderlineToButton(categorybutton)
       }
    
    
    
    private func addUnderlineToButton(_ button: UIButton) {
        // Remove any existing underline if necessary
        button.layer.sublayers?.removeAll(where: { $0 is CALayer })

        // Add a new underline using CALayer
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: button.frame.height - 2, width: button.frame.width, height: 2)
        underline.backgroundColor = UIColor.lightGray.cgColor
        button.layer.addSublayer(underline)
    }
       private func customizeTextField(_ textField: UITextField) {
           // Remove border
           textField.borderStyle = .none
           
           // Add underline
           let underline = CALayer()
           underline.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
           underline.backgroundColor = UIColor.lightGray.cgColor
           textField.layer.addSublayer(underline)
       }
    
    func addtransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentview.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentview)
        
        tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableview)
        tableview.layer.cornerRadius = 8
        
        tableview.reloadData()
        
        transparentview.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentview.addGestureRecognizer(tapgesture)
        transparentview.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,options:.curveEaseInOut, animations: { [self] in
            transparentview.alpha = 0.5
            self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(dataSource.count * 50))
            
        },completion: nil)
        
        
    }
    @objc func removeTransparentView(){
        let frames = selectedbutton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,options:.curveEaseInOut, animations: { [self] in
            transparentview.alpha = 0
            self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            
        },completion: nil)
        
    }
    
    @IBAction func Categorybutton(_ sender: Any) {
        
        dataSource = ["kdjb","sdjvh","sdvjhv","sdvjhv","sdvjhv"]
        selectedbutton = categorybutton
        addtransparentView(frames: categorybutton.frame)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return dataSource.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           
           cell.textLabel?.text = dataSource[indexPath.row]
           
           
           
//           let user = users[indexPath.row]
           
//           cell.textLabel?.text = user.fullname
           return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedbutton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}


