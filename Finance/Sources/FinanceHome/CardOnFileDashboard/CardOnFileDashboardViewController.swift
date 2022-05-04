//
//  CardOnFileDashboardViewController.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
    func didTapAddPaymentMethod()
}

final class CardOnFileDashboardViewController: UIViewController, CardOnFileDashboardPresentable, CardOnFileDashboardViewControllable {
    weak var listener: CardOnFileDashboardPresentableListener?

    private let headerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.axis = .horizontal
        return view
    }()

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 22, weight: .semibold)
        view.text = "카드 및 계좌"
        return view
    }()

    private lazy var seeAllButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("전체보기", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.addTarget(self, action: #selector(seeAllButtonDidTap), for: .touchUpInside)
        return view
    }()

    private let cardOnfileStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.spacing = 12
        return view
    }()

    private lazy var addMethodButton: AddPaymentMethodButton = {
        let view = AddPaymentMethodButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorners()
        view.backgroundColor = .systemGray4
        view.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return view
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    func update(with viewModels: [PaymentMethodViewModel]) {
        cardOnfileStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let views = viewModels.map(PaymentMethodView.init)

        views.forEach {
            $0.roundCorners()
            cardOnfileStackView.addArrangedSubview($0)
        }

        cardOnfileStackView.addArrangedSubview(addMethodButton)

        let heightConstraints = views.map { $0.heightAnchor.constraint(equalToConstant: 60) }
        NSLayoutConstraint.activate(heightConstraints)
    }

    private func setupViews() {
        view.addSubview(headerStackView)
        view.addSubview(cardOnfileStackView)

        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(seeAllButton)

        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            cardOnfileStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            cardOnfileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardOnfileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardOnfileStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            addMethodButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc
    private func seeAllButtonDidTap() {
    }

    @objc
    private func addButtonDidTap() {
        listener?.didTapAddPaymentMethod()
    }
}
