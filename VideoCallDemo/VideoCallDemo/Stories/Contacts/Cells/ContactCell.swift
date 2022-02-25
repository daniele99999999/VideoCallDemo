//
//  ContactCell.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 21/02/22.
//

import Foundation
import UIKit
import Kingfisher

class ContactCell: UITableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorFFFFFF
        return view
    }()
    
    private lazy var contactImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.image = nil
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var stackContainerView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 0
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var contactNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = Resources.UI.Fonts.systemRegular(size: 15)
        view.adjustsFontForContentSizeCategory = true
        view.textColor = Resources.UI.Colors.color000000
        view.text = nil
        view.numberOfLines = 1
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var contactSurnameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = Resources.UI.Fonts.systemRegular(size: 15)
        view.adjustsFontForContentSizeCategory = true
        view.textColor = Resources.UI.Colors.color000000
        view.text = nil
        view.numberOfLines = 1
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private var viewModel: ContactCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: ContactCellViewModel) {
        self.viewModel = viewModel
        self.setupBindings()
        self.viewModel?.input.ready?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewModel?.input.reset?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contactImageView.makeCircular()
        self.contactImageView.superview?.setNeedsLayout()
    }
}

private extension ContactCell {
    func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Resources.Layout.Contacts.Cell.itemSpacing)
        ])
        
        self.containerView.addSubview(self.contactImageView)
        NSLayoutConstraint.activate([
            self.contactImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Resources.Layout.Contacts.Cell.horizontalInsets),
            self.contactImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: Resources.Layout.Contacts.Cell.verticalsInsets),
            self.contactImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -Resources.Layout.Contacts.Cell.verticalsInsets),
            self.contactImageView.widthAnchor.constraint(equalTo: self.contactImageView.heightAnchor, multiplier: 1)
        ])
        
        self.containerView.addSubview(self.stackContainerView)
        NSLayoutConstraint.activate([
            self.stackContainerView.leadingAnchor.constraint(equalTo: self.contactImageView.trailingAnchor, constant: Resources.Layout.Contacts.Cell.horizontalInsets),
            self.stackContainerView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: Resources.Layout.Contacts.Cell.verticalsInsets),
            self.stackContainerView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -Resources.Layout.Contacts.Cell.verticalsInsets),
            self.stackContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Resources.Layout.Contacts.Cell.horizontalInsets)
        ])
        
        self.stackContainerView.addArrangedSubview(self.contactNameLabel)
        self.stackContainerView.addArrangedSubview(self.contactSurnameLabel)
        NSLayoutConstraint.activate([
            self.contactSurnameLabel.heightAnchor.constraint(equalTo: self.contactNameLabel.heightAnchor, multiplier: 1)
        ])
    }
    
    func setupBindings() {
        self.viewModel?.output.reset = Self.bindOnMain { [weak self] in
            self?.contactImageView.kf.cancelDownloadTask()
            self?.contactImageView.image = nil
            self?.contactNameLabel.text = nil
            self?.contactSurnameLabel.text = nil
            self?.updateState(selected: false)

            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }

        self.viewModel?.output.imageURL = Self.bindOnMain { [weak self] imageURL in
            self?.contactImageView.kf.setImage(with: imageURL)

            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }

        self.viewModel?.output.firstName = Self.bindOnMain { [weak self] firstName in
            self?.contactNameLabel.text = firstName

            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.lastName = Self.bindOnMain { [weak self] lastName in
            self?.contactSurnameLabel.text = lastName

            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.selected = Self.bindOnMain { [weak self] selected in
            self?.updateState(selected: selected)

            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
    }
}

private extension ContactCell {
    func updateState(selected: Bool) {
        self.containerView.backgroundColor = selected ? Resources.UI.Colors.color6464AF : Resources.UI.Colors.colorFFFFFF
    }
}
