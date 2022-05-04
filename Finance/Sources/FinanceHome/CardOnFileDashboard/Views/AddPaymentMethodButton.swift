//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import UIKit

final class AddPaymentMethodButton: UIControl {
    private let plusIcon: UIImageView = {
        let view = UIImageView(image: UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        ))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        return view
    }()

    init() {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    func setupViews() {
        addSubview(plusIcon)

        NSLayoutConstraint.activate([
            plusIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
