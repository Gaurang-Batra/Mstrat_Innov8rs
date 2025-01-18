//
//  SplashViewController.swift
//  loginpg
//
//  Created by Gaurav on 17/01/25.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet var circleview: [UIView]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create the UIView
        for view in circleview {
                   // Ensure the view is a square by setting equal width and height
                   let size = min(view.frame.width, view.frame.height)
                   view.frame.size = CGSize(width: size, height: size)
                   
                   // Make the view circular
                   view.layer.cornerRadius = size / 2
                   view.layer.masksToBounds = true
               }
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
