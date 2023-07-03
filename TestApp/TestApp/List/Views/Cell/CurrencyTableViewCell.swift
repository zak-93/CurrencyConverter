//
//  CurrencyTableViewCell.swift
//  TestApp
//
//  Created by Yashin Zahar on 23.05.2023.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    //MARK: Variable

    public var name = ""

    //MARK: Object

    public lazy var viewContent: UIView = {
        let view = UIView()

        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var bottomView: UIView = {
        let view = UIView()

        view.backgroundColor = .colordD9D9D9
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    public lazy var nameCell: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    public lazy var selectedCell: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "currency_check_mark")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .color3B70F9
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()


    //MARK: Life cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        nameCell.text = nil
        selectedCell.isHidden = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configure()
        setConstraints()
        constraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Configure

    func configure() {
        contentView.backgroundColor = .white
    }

    public func updateData(name: String) {
        nameCell.text = name
        if self.name == name {
            self.selectedCell.isHidden = false
        }
    }

    func setConstraints() {
        self.contentView.addSubview(viewContent)
        viewContent.addSubview(nameCell)
        viewContent.addSubview(selectedCell)
        viewContent.addSubview(bottomView)
    }

    //MARK: Constraints


    private func constraints() {
        NSLayoutConstraint.activate([
            viewContent.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            viewContent.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 24),
            viewContent.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24),
            viewContent.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

            nameCell.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 16),
            nameCell.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -16),
            nameCell.leftAnchor.constraint(equalTo: viewContent.leftAnchor),
            nameCell.rightAnchor.constraint(equalTo: viewContent.rightAnchor),

            selectedCell.centerYAnchor.constraint(equalTo: nameCell.centerYAnchor),
            selectedCell.rightAnchor.constraint(equalTo: viewContent.rightAnchor),
            selectedCell.heightAnchor.constraint(equalToConstant: 24),
            selectedCell.widthAnchor.constraint(equalToConstant: 24),

            bottomView.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1),
            bottomView.leftAnchor.constraint(equalTo: viewContent.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: viewContent.rightAnchor),
        ])
    }
}
