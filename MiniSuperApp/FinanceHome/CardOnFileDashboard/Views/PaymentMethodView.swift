//
//  PaymentMethodView.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import UIKit

final class PaymentMethodView: UIView {
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        view.textColor = .white
        view.text = "우리은행"
        return view
    }()

    private let subtitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18, weight: .regular)
        view.textColor = .white
        view.text = "**** 9999"
        return view
    }()

    init(viewModel: PaymentMethodViewModel) {
        super.init(frame: .zero)

        setupViews()
        
        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.digits
        backgroundColor = viewModel.color
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    func setupViews() {
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        backgroundColor = .systemIndigo

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
