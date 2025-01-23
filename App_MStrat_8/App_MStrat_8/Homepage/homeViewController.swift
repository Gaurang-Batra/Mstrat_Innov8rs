import UIKit


// MARK: - HomeViewController
class homeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GoalViewControllerDelegate {

    @IBOutlet weak var expensebutton: UIButton!
    @IBOutlet weak var mainlabel: UIView!
    @IBOutlet var circleview: [UIView]!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var roundcornerciew: [UIView]!
    @IBOutlet weak var AddExpense: UITextField!
    @IBOutlet weak var totalexpenselabel: UILabel!
    @IBOutlet weak var remaininfAllowancelabel: UILabel!
    @IBOutlet weak var Addgoalgoalbutton: UIButton!

    
    var expenses: [Expense] = []  // Declare this variable
    var currentGoal: Goal?

    var goals: [Goal] = []  // Array to hold multiple goals

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainlabel.layoutIfNeeded()
        createVerticalDottedLineInBalanceContainer()
        circleview.forEach { makeCircular(view: $0) }
        roundcornerciew.forEach { roundCorners(of: $0, radius: 10) }

        expensebutton.layer.cornerRadius = expensebutton.frame.size.width / 2
        expensebutton.clipsToBounds = true

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshExpenses), name: NSNotification.Name("ExpenseAdded"), object: nil)

        styleTextField(AddExpense)
        refreshExpenses()
        updateTotalExpense()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTotalExpense), name: NSNotification.Name("remaininfAllowancelabel"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateGoalButton()
    }

    func didAddGoal(title: String, amount: Int, deadline: Date, initialSavings: Int) {
        // Create a new goal and store it locally
        let newGoal = Goal(title: title, amount: amount, deadline: deadline, savings: initialSavings)
        goals.append(newGoal)

        // Update the button to reflect the goal's progress
        DispatchQueue.main.async {
            self.updateGoalButton()
        }
        print("New Goal Added: \(title), Amount: \(amount), Deadline: \(deadline)")
    }

    private func updateGoalButton() {
        guard let goal = currentGoal else {
            Addgoalgoalbutton.setTitle("Add Goal", for: .normal)
            print("check")
            return
        }
        Addgoalgoalbutton.setTitle("\(goal.amount)", for: .normal)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGoalViewController",
           let goalVC = segue.destination as? GoalViewController {
            goalVC.delegate = self
        }
    }

    @objc private func updateTotalExpense() {
        let totalExpense = AllowanceDataModel.shared.getAllAllowances().reduce(0) { $0 + $1.amount }
        remaininfAllowancelabel.text = String(format: " Rs.%.2f", totalExpense)
    }

    private func styleTextField(_ textField: UITextField) {
        textField.frame.size.height = 45
        let cornerRadius: CGFloat = 10
        let maskPath = UIBezierPath(
            roundedRect: textField.bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        textField.layer.mask = maskLayer
    }

    @objc private func refreshExpenses() {
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
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.97),
                heightDimension: .absolute(100)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
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
            fatalError("Unable to dequeue SetExpenseCollectionViewCell")
        }
        let expense = expenses[indexPath.row]
        cell.configure(with: expense)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }

    func createVerticalDottedLineInBalanceContainer() {
        let dottedLine = CAShapeLayer()
        let path = UIBezierPath()
        let centerX = mainlabel.bounds.width / 2
        let startY: CGFloat = 10
        let endY = mainlabel.bounds.height - 10
        path.move(to: CGPoint(x: centerX, y: startY))
        path.addLine(to: CGPoint(x: centerX, y: endY))
        dottedLine.path = path.cgPath
        dottedLine.strokeColor = UIColor.black.withAlphaComponent(0.4).cgColor
        dottedLine.lineWidth = 1.5
        dottedLine.lineDashPattern = [6, 2]
        mainlabel.layer.addSublayer(dottedLine)
    }
    
}
