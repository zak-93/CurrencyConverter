import UIKit

class CurrencyDisplayView: UIView {
    
    //MARK: Variables
    
    public var name: String = "Currency"
    
    //MARK: Objects
    
    public lazy var nameCurrency: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .colorBFBFBF
        label.numberOfLines = 1
        label.text = name
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var imageCurrency: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "main_arrow_down")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .color888888
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    //MARK: Init
    
    convenience init () {
        self.init(frame:CGRect.zero)
        
        configure()
        setSubview()
        constraints()
        defaultValue()
    }
    
    private func configure() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.colorDADADA?.cgColor
        self.layer.cornerRadius = 8
    }
    
    private func setSubview() {
        self.addSubview(imageCurrency)
        self.addSubview(nameCurrency)
    }
    
    //MARK: Constraints

    func constraints() {
        NSLayoutConstraint.activate([
            imageCurrency.centerYAnchor.constraint(equalTo: nameCurrency.centerYAnchor),
            imageCurrency.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            imageCurrency.heightAnchor.constraint(equalToConstant: 14),
            imageCurrency.widthAnchor.constraint(equalToConstant: 14),
            
            nameCurrency.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            nameCurrency.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            nameCurrency.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -17),
            nameCurrency.rightAnchor.constraint(lessThanOrEqualTo: imageCurrency.leftAnchor, constant: -34),
        ])
    }
    
    public func setData(_ nameCurrency: String) {
        name = nameCurrency
        self.nameCurrency.text = nameCurrency
        self.nameCurrency.textColor = .black
    }
    
    func defaultValue() {
        if nameCurrency.text == "Currency" {
            nameCurrency.textColor = .colorBFBFBF
        } else {
            nameCurrency.textColor = .black
        }
    }
}
