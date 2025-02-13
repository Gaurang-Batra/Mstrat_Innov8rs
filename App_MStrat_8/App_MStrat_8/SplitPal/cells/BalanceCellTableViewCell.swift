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
    
    var balance: ExpenseSplitForm?
    
    
    
    
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
    
    func configure(with balance: ExpenseSplitForm) {
        senderprofilename.text = balance.paidBy
        receiverprofilename.text = balance.payee  // Assuming balance.payee is the person receiving money
        Sendingamount.text = "Rs.\(balance.totalAmount)"
    }
    
    @IBAction func settlementButtonTapped(_ sender: UIButton) {
        if let balanceAmount = balance?.totalAmount {
            // Get the parent view controller (GroupDetailViewController)
            if let viewController = self.viewController() as? GroupDetailViewController {
                viewController.navigateToSettlement(with: balanceAmount, expense: balance)            }
        }
    }
}
    
    
    // Extension to get the parent view controller from a UIView
    extension UIView {
        func viewController() -> UIViewController? {
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

