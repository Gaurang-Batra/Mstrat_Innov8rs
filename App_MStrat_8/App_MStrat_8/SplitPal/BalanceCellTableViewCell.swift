//
//  BalanceCellTableViewCell.swift
//  App_MStrat_8
//
//  Created by student-2 on 26/12/24.
//

import UIKit





class BalanceCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var senderprofilename: UILabel!
    
    @IBOutlet weak var receiverprofilename: UILabel!
    
    @IBOutlet weak var Sendingamount: UILabel!
    
    @IBOutlet weak var balancecellview: UIView!
    
    var balance: Balance?
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let balanceCellView = balancecellview {
             balanceCellView.layer.cornerRadius = 10
             balanceCellView.layer.masksToBounds = false
             balanceCellView.layer.shadowColor = UIColor.black.cgColor
             balanceCellView.layer.shadowOffset = CGSize(width: 0, height: 10)
             balanceCellView.layer.shadowOpacity = 0.5
             balanceCellView.layer.shadowRadius = 5
             balanceCellView.layer.shouldRasterize = true
             balanceCellView.layer.rasterizationScale = UIScreen.main.scale
         }
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with balance: Balance) {
        senderprofilename.text = balance.payer
        receiverprofilename.text = balance.payee
        Sendingamount.text = "$\(balance.amount)"
    }
    
    @IBAction func settlementButtonTapped(_ sender: UIButton) {
        if let balanceAmount = balance?.amount {
             // Get the parent view controller
             if let viewController = self.parentViewController() as? GroupDetailViewController {
                 viewController.navigateToSettlement(with: balanceAmount)
             }
         }
     }
 }

 // Extension to get the parent view controller from a UIView
 extension UIView {
     func parentViewController() -> UIViewController? {
         var nextResponder = self.next
         while nextResponder != nil {
             if let viewController = nextResponder as? UIViewController {
                 return viewController
             }
             nextResponder = nextResponder?.next
         }
         return nil
     }
 }
