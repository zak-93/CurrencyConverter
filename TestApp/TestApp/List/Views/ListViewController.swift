import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func leftCurrency(name: String)
    func rightCurrency(name: String)
}

class ListViewController: UIViewController {
    
    //MARK: Variables
    
    var currencys: [String] = []
    public var currencyValue: CurrencyValue = .left
    public var currency = ""
    public var firstValue = ""
    private let presenter = PresenterListView()

    weak var delegate: ListViewControllerDelegate?
    weak private var listViewOutputDelegate: ListViewOutputDelegate?
    
    //MARK: Objects
    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.tableFooterView = nil
        tableView.tableHeaderView = nil
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "CurrencyTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    //MARK: Life cycle

    override func loadView() {
        super.loadView()
        
        configure()
        setSubview()
        constraints()
    }
    
    //MARK: Configure
    
    private func configure() {
        presenter.setListViewInputDelegate(listViewInputDelegate: self)
        self.listViewOutputDelegate = presenter
        self.listViewOutputDelegate?.getData()
        view.backgroundColor = .white
        navigationItem.title = "Select currency"
    }
    
    private func setSubview() {
        self.view.addSubview(listTableView)
    }
    
    
    //MARK: Constraints
    private func constraints() {
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            listTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            listTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    
    //MARK: Action
    func sendCurrency(name: String) {
        switch currencyValue {
            
        case .left:
            delegate?.leftCurrency(name: name)
        case .right:
            delegate?.rightCurrency(name: name)
        }
    }
    
    func closeModul() {
        navigationController?.popViewController(animated: true)
    }
    
    func alertError(error: CurrentyError ) {
        let alert = UIAlertController.init(title: error.errorDescription, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func getAllCurrency(value: [String]) -> [String] {
        var dividedSet: Set<String> = []

        for string in value {
            let halfLength = string.count / 2
            let firstHalf = String(string.prefix(halfLength))
            let secondHalf = String(string.suffix(halfLength))
            dividedSet.insert(firstHalf)
            dividedSet.insert(secondHalf)
        }

        let dividedArray = Array(dividedSet)
        let newArray = dividedArray.sorted { $0 < $1 }
        return newArray
    }
}

extension ListViewController: ListViewInputDelegate {
    
    func errorData(error: CurrentyError) {
        alertError(error: error)
    }
    
    func getCurrencys(data: [String]) {
        if firstValue != DefaultValue.currency.rawValue.capitalized && currencyValue == .right  {
            let newValue = data.filter { $0.contains(firstValue)}
            self.currencys = getAllCurrency(value: newValue)
        } else {
            self.currencys = getAllCurrency(value: data)
        }
        
        listTableView.reloadData()
    }
}
