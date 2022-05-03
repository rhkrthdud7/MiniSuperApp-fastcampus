//
//  AddPaymentMethodViewController.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import ModernRIBs
import UIKit

protocol AddPaymentMethodPresentableListener: AnyObject {
    func didTapClose()
    func didTapConfirm(with number: String, cvc: String, expiry: String)
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {
    weak var listener: AddPaymentMethodPresentableListener?

    private let cardNumberTextField: UITextField = {
        let view = makeTextField()
        view.placeholder = "카드 번호"
        return view
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        view.spacing = 14
        return view
    }()

    private let securityTextField: UITextField = {
        let view = makeTextField()
        view.placeholder = "CVC"
        return view
    }()

    private let expirationTextField: UITextField = {
        let view = makeTextField()
        view.placeholder = "유효기간"
        return view
    }()

    private lazy var addCardButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorners()
        view.backgroundColor = .primaryRed
        view.setTitle("추가하기", for: .normal)
        view.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return view
    }()

    private static func makeTextField() -> UITextField {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.borderStyle = .roundedRect
        view.keyboardType = .numberPad
        return view
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    private func setupViews() {
        title = "카드 추가"

        setupNavigationItem(with: .close, target: self, action: #selector(didTapClose))

        view.backgroundColor = .backgroundColor
        view.addSubview(cardNumberTextField)
        view.addSubview(stackView)
        view.addSubview(addCardButton)

        stackView.addArrangedSubview(securityTextField)
        stackView.addArrangedSubview(expirationTextField)

        NSLayoutConstraint.activate([
            cardNumberTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            cardNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cardNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            stackView.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            addCardButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            addCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            addCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            cardNumberTextField.heightAnchor.constraint(equalToConstant: 60),
            securityTextField.heightAnchor.constraint(equalToConstant: 60),
            expirationTextField.heightAnchor.constraint(equalToConstant: 60),
            addCardButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc
    private func addButtonDidTap() {
        if let number = cardNumberTextField.text,
           let cvc = securityTextField.text,
           let expiry = expirationTextField.text {
            listener?.didTapConfirm(with: number, cvc: cvc, expiry: expiry)
        }
    }

    @objc
    private func didTapClose() {
        listener?.didTapClose()
    }
}
