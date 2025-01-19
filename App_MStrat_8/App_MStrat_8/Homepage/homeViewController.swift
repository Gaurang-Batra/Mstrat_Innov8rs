import UIKit

class homeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    

    @IBOutlet weak var expensebutton: UIButton!
    
    
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let expenses = ExpenseDataModel.shared.getAllExpenses()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeCircular(view: circleView)
        
        expensebutton.layer.cornerRadius = expensebutton.frame.size.width / 2
                expensebutton.clipsToBounds = true
        
        collectionView.delegate = self
                collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()



        // Do any additional setup after loading the view.
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SetExpenseCollectionViewCell else {
                    fatalError("Unable to dequeue SetExpensseCollectionViewCell")
                }
                
                // Configure the cell
                let expense = expenses[indexPath.row]
                cell.configure(with: expense)
                
                return cell
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
