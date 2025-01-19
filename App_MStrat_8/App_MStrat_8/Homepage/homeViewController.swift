import UIKit

class homeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var expensebutton: UIButton!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var expenses: [Expense] = []  // Declare this variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeCircular(view: circleView)
        
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
        
        // Initial load of expenses
        refreshExpenses()
    }

    // Reload expenses when a new expense is added
    @objc private func refreshExpenses() {
        // Always fetch the latest expenses from the data model
        expenses = ExpenseDataModel.shared.getAllExpenses()
        collectionView.reloadData()
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
                widthDimension: .fractionalWidth(1.0),
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
        
        return cell
    }
}
