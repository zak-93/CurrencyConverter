import UIKit

class MainViewController: UIViewController {
    
    //MARK: Constants
    private let presenter = PresenterMainView()
    let defaultValue = DefaultValue.currency.rawValue.capitalized
    let bottomPaddingRefreshButton = 16.0 // отступ снизу у refreshButton
    var result = ""
    
    //MARK: Variables
    weak private var mainViewOutputDelegate: MainViewOutputDelegate?
    private var widthView = (UIScreen.main.bounds.width - 48 - 24 - 24) / 2 // минус расстояние по бокам и центру
    public var bottomRefreshButtonConstraint: NSLayoutConstraint?
    
    //MARK: Object
    
    
    
    //MARK: CurrencyStack
    
    private lazy var currencyStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    public lazy var leftCurrencyView: CurrencyDisplayView = {
       let view = CurrencyDisplayView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(leftCurrencyTap) )
        view.addGestureRecognizer(tap)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var swapCurrencyButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "main_swap"), for: .normal)
        button.tintColor = .color3B70F9
        button.addTarget(self, action: #selector(swap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    public lazy var rightCurrencyView: CurrencyDisplayView = {
       let view = CurrencyDisplayView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(rightCurrencyTap) )
        view.addGestureRecognizer(tap)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: CurrencyInputData
    
    private lazy var currencyInputStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 48
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    public lazy var inputValueTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "0.00"
        textField.textColor = .black
        textField.clipsToBounds = true
        textField.textAlignment = .center
        textField.keyboardType = .phonePad
        textField.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        textField.sizeToFit()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    public lazy var outputValueLabel: UILabel = {
        let label = UILabel()
        
        label.text = "0.00"
        label.textColor = .colorBFBFBF
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public lazy var leftBottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .colorDADADA
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var rightBottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .colorDADADA
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: RefreshButton
    public lazy var refreshButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .color3B70F9
        button.setTitle("Refresh", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    //MARK: Life cycle

    override func loadView() {
        super.loadView()
        
        configure()
        setSubview()
        constraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        natificationKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Configure

    private func configure() {
        presenter.setMainViewInputDelegate(mainViewInputDelegate: self)
        self.mainViewOutputDelegate = presenter

        view.backgroundColor = .white
        navigationItem.title = "Currency converter"

        addGesture()
    }
    
    private func setSubview() {
        self.view.addSubview(refreshButton)
        self.view.addSubview(currencyStack)
        
        currencyStack.addArrangedSubview(leftCurrencyView)
        currencyStack.addArrangedSubview(swapCurrencyButton)
        currencyStack.addArrangedSubview(rightCurrencyView)
        
        self.view.addSubview(currencyInputStack)
        currencyInputStack.addArrangedSubview(inputValueTextField)
        currencyInputStack.addArrangedSubview(outputValueLabel)
        
        self.view.addSubview(leftBottomView)
        self.view.addSubview(rightBottomView)
    }
    
    // MARK: Constraint
    
    private func constraints() {
        constraintsCurrencyStack()
        constraintsCurrencyInputStack()
        constraintsLeftBottomView()
        constraintsRightBottomView()
        constraintsRefreshButton()
    }
    
    private func constraintsCurrencyStack() {
        NSLayoutConstraint.activate([
            currencyStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            currencyStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            currencyStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            leftCurrencyView.widthAnchor.constraint(equalToConstant: widthView),
            rightCurrencyView.widthAnchor.constraint(equalToConstant: widthView)
        ])
    }
    
    private func constraintsCurrencyInputStack() {
        NSLayoutConstraint.activate([
            currencyInputStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            currencyInputStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            currencyInputStack.topAnchor.constraint(equalTo: currencyStack.bottomAnchor, constant: 32),
            
            inputValueTextField.widthAnchor.constraint(equalToConstant: widthView),
            outputValueLabel.widthAnchor.constraint(equalToConstant: widthView)
        ])
    }
    
    private func constraintsLeftBottomView() {
        NSLayoutConstraint.activate([
            leftBottomView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            leftBottomView.topAnchor.constraint(equalTo: currencyInputStack.bottomAnchor, constant: 12),
            leftBottomView.widthAnchor.constraint(equalToConstant: widthView),
            leftBottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func constraintsRightBottomView() {
        NSLayoutConstraint.activate([
            rightBottomView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            rightBottomView.topAnchor.constraint(equalTo: currencyInputStack.bottomAnchor, constant: 12),
            rightBottomView.widthAnchor.constraint(equalToConstant: widthView),
            rightBottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func constraintsRefreshButton() {
        bottomRefreshButtonConstraint = refreshButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomPaddingRefreshButton)

        NSLayoutConstraint.activate([
            refreshButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            refreshButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            refreshButton.heightAnchor.constraint(equalToConstant: 56),
            bottomRefreshButtonConstraint!
        ])
    }
    
    //MARK: Action
    
    @objc func leftCurrencyTap() {
        openCurrency(value: .left, currency: leftCurrencyView.name )
    }
    
    @objc func rightCurrencyTap() {
        if leftCurrencyView.name != defaultValue {
            openCurrency(value: .right, currency: rightCurrencyView.name)
        }
    }
    
    @objc func refresh() {
        if let value = inputValueTextField.text, value == "" {
            alertError(error: .noValue)
            inputValueTextField.text = nil
            outputValueLabel.text = "0.00"
            outputValueLabel.textColor = .colorBFBFBF
        } else if allData() {
            mainViewOutputDelegate?.getData(firstValue: leftCurrencyView.name, secondValue: rightCurrencyView.name)
        }
        closeKeyboard()
    }
    
    @objc func swap() {
        if leftCurrencyView.name != defaultValue && rightCurrencyView.name != defaultValue {
            let value = (leftCurrencyView.name, rightCurrencyView.name)
            rightCurrencyView.setData(value.0)
            leftCurrencyView.setData(value.1)
            if inputValueTextField.text != "" {
                mainViewOutputDelegate?.getData(firstValue: leftCurrencyView.name, secondValue: rightCurrencyView.name)
            }
        }
    }
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    func openCurrency(value: CurrencyValue, currency: String) {
        let controller = ListViewController()
        controller.currency = currency
        controller.currencyValue = value
        controller.firstValue = leftCurrencyView.name
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
        view.endEditing(true)
    }
    
    func allData() -> Bool {
        if leftCurrencyView.name == defaultValue || rightCurrencyView.name == defaultValue {
            alertError(error: .noCarrency)
            return false
        } else {
            return true
        }
    }
    
    func result(currency: Double) {
        if let value = inputValueTextField.text {
            if let doubleValue = Double(value) {
                let result = doubleValue * currency
                outputValueLabel.textColor = .color676767
                outputValueLabel.text = result.asNumberString()
                self.result = doubleValue.asNumberString()
                inputValueTextField.text = "\(doubleValue.asNumberString())"
            }
        }
    }
    
    func alertError(error: ErrorMainView) {
        let alert = UIAlertController.init(title: error.errorDescription, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func alertErrorServer(error: CurrentyError) {
        let alert = UIAlertController.init(title: error.errorDescription, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    @objc func textTextField() {
        if inputValueTextField.text == "" {
            outputValueLabel.text = "0.00"
            outputValueLabel.textColor = .colorBFBFBF
        } else if allData() {
            mainViewOutputDelegate?.getData(firstValue: leftCurrencyView.name, secondValue: rightCurrencyView.name)
        }
    }
}

extension MainViewController: MainViewInputDelegate {
    func errorData(error: CurrentyError) {
        alertErrorServer(error: error)
    }
    
    func getData(data: Double) {
        result(currency: data)
    }
}

