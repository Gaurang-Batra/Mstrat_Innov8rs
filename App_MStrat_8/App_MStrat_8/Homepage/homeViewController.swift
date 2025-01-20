import UIKit

class homeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GoalViewControllerDelegate {
   
    @IBOutlet weak var expensebutton: UIButton!
    
    
    @IBOutlet var circleview: [UIView]!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var roundcornerciew: [UIView]!
    
    
    @IBOutlet weak var AddExpense: UITextField!
    
    @IBOutlet weak var totalexpenselabel: UILabel!
    
    @IBOutlet weak var remaininfAllowancelabel: UILabel!
    
    
    @IBOutlet weak var Addgoalgoalbutton: UIButton!
    
    
    var expenses: [Expense] = []  // Declare this variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleview.forEach { makeCircular(view: $0) }
        
        roundcornerciew.forEach { roundCorners(of: $0, radius: 10) }
        
        expensebutton.layer.cornerRadius = expensebutton.frame.size.width / 2
        expensebutton.clipsToBounds = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshExpenses),
            name: NSNotification.Name("ExpenseAdded"),
            object: nil
        )
        
        styleTextField(AddExpense)
        
        // Initial load of expenses
        refreshExpenses()
        updateTotalExpense()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTotalExpense), name: NSNotification.Name("remaininfAllowancelabel"), object: nil)
            
    }
    
    func didAddGoal(title: String, amount: Int, deadline: Date) {
           // Update the Addgoalgoalbutton with the goal amount
           Addgoalgoalbutton.setTitle("\(amount)", for: .normal)
           print("New Goal Added: \(title), Amount: \(amount), Deadline: \(deadline)")
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGoalViewController", // Ensure the identifier matches
           let goalVC = segue.destination as? GoalViewController {
            goalVC.delegate = self // Set the delegate
        }
    }


    @objc private func updateTotalExpense() {
        // Calculate the total of all allowances
        let totalExpense = AllowanceDataModel.shared.getAllAllowances().reduce(0) { $0 + $1.amount }
        
        // Update the label
        remaininfAllowancelabel.text = String(format: " Rs.%.2f", totalExpense)
    }

    
    private func styleTextField(_ textField: UITextField) {
           // Set the height of the text field by modifying its frame
           textField.frame.size.height = 45// Set desired height
           
           // Round only the left side corners
           let cornerRadius: CGFloat = 10 // Adjust the corner radius as needed
           let maskPath = UIBezierPath(
               roundedRect: textField.bounds,
               byRoundingCorners: [.topLeft, .bottomLeft],
               cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
           )
           
           let maskLayer = CAShapeLayer()
           maskLayer.path = maskPath.cgPath
           textField.layer.mask = maskLayer
           
           // Optional: Add a border for visibility
//           textField.layer.borderColor = UIColor.gray.cgColor
//           textField.layer.borderWidth = 1.0
       }

    // Reload expenses when a new expense is added
    @objc private func refreshExpenses() {
        // Always fetch the latest expenses from the data model
        expenses = ExpenseDataModel.shared.getAllExpenses()
        collectionView.reloadData()
    }
    
    private func roundCorners(of view: UIView, radius: CGFloat) {
           view.layer.cornerRadius = radius
           view.layer.masksToBounds = true
       }
    private func makeCircular(view: UIView) {
           let size = min(view.frame.width, view.frame.height)
           view.layer.cornerRadius = size / 2
           view.layer.masksToBounds = true
       }
       
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            // Define item size and layout
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)
            
            // Define group size and layout
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.97),
                heightDimension: .absolute(100)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Define section and its content insets
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
            
            return section
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // Return the actual number of expenses
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SetExpenseCollectionViewCell else {
               fatalError("Unable to dequeue SetExpenseCollectionViewCell")
           }

           // Configure the cell with the latest expenses data
           let expense = expenses[indexPath.row]
           cell.configure(with: expense)
           
           // Add shadow to the cell
//           cell.layer.shadowColor = UIColor.black.cgColor  // Use black shadow or adjust to any color
//           cell.layer.shadowOpacity = 1  // Adjust shadow opacity
//           cell.layer.shadowOffset = CGSize(width: 10, height: 50)  // Adjust shadow offset
//           cell.layer.shadowRadius = 4  // Adjust shadow blur radius
//           cell.layer.masksToBounds = false  // Allow shadow to extend outside the bounds of the cell
           
           // Round the corners of the cell
           cell.layer.cornerRadius = 10  // Adjust the corner radius to your preference
           cell.layer.masksToBounds = true  // Clip the cell’s content to the rounded corners
           
           return cell
    }
}
