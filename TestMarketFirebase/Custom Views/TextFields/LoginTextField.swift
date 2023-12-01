//
//  LoginTextField.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit
import SnapKit

enum cornerRadiusSide {
    case top
    case bottom
    case without
}

final class LoginTextField: BaseView {
    //MARK: - Public
    func configure(_ placeholder: String, _ maskedCorner: cornerRadiusSide, _ restorationIdentifier: String, _ secure: Bool = false) {
        self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: Resources.Colors.gray,
            NSAttributedString.Key.font: Resources.Fonts.systemWeight(with: 14, weight: .light)
        ])
        switch maskedCorner {
        case .top:
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .without:
            view.layer.cornerRadius = 0
        }
        textField.restorationIdentifier = restorationIdentifier
        if secure {
            textField.isSecureTextEntry = true
        }
    }
    
    //MARK: - Private Properties
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Resources.Colors.gray.cgColor
        return view
    }()
    let textField = UITextField()
}

extension LoginTextField {
    override func setupViews() {
        super.setupViews()
        addSubview(view)
        view.addSubview(textField)
    }
    override func constraintViews() {
        super.constraintViews()
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview()
        }
    }
    override func configureAppearance() {
        super.configureAppearance()
        textField.textColor = Resources.Colors.titlePurp
        textField.placeholder = "test"
        textField.keyboardType = .default
        textField.delegate = self
    }
}

extension LoginTextField: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        CheckField.shared.validField(self.view,textField)
        return true
    }
}

