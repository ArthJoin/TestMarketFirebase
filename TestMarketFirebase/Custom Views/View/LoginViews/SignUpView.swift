//
//  SignUpView.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit
import SnapKit

struct regData {
    let name: String
    let email: String
    let password: String
}

protocol SignUpViewDelegate: AnyObject {
    func didLoginBtnTapped()
    func signUpBtnTapped()
}

final class SignUpView: BaseView {
    weak var delegate: SignUpViewDelegate?
    
    //MARK: - Public
    func regData() -> regData {
        guard let safeName = self.nameTextField.textField.text,
              let safeMail = self.emailTextField.textField.text,
              let safePass = self.passTextField.textField.text else {
            return regData()
        }
        let data = TestMarketFirebase.regData(name: safeName,
                                    email: safeMail,
                                    password: safePass)
        return data
    }
    
    //MARK: - Private Properties
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.resizeImage(Resources.Images.logo ?? UIImage(),
                                                       CGSize(width: 100, height: 110))
        imageView.backgroundColor = Resources.Colors.lightGreen
        return imageView
    }()
    
    private let loginHeader: UILabel = {
        let label = UILabel()
        label.text = "Зарегистрироваться"
        label.font = Resources.Fonts.systemWeight(with: 18, weight: .bold)
        label.textColor = Resources.Colors.titlePurp
        return label
    }()
    
    private let SignUpBtn: UIButton = {
        let btn = UIButton()
        let title = NSAttributedString(string: "Зарегистрироваться", attributes: [
            NSAttributedString.Key.font: Resources.Fonts.systemWeight(with: 14, weight: .medium),
            NSAttributedString.Key.foregroundColor: Resources.Colors.lightGreen])
        btn.setAttributedTitle(title, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = Resources.Colors.darkGreen.withAlphaComponent(0.3)
        return btn
    }()
    
    private let nameTextField = LoginTextField()
    private let emailTextField = LoginTextField()
    private let passTextField = LoginTextField()
    
    private let loginBtn: UIButton = {
        let btn = UIButton()
        let title = NSAttributedString(string: "Есть аккаунт? Войти", attributes: [
            NSAttributedString.Key.font: Resources.Fonts.systemWeight(with: 13, weight: .medium),
            NSAttributedString.Key.foregroundColor: Resources.Colors.blue
        ])
        btn.setAttributedTitle(title, for: .normal)
        return btn
    }()
}

extension SignUpView {
    override func setupViews() {
        super.setupViews()
        addSubview(logo)
        addSubview(loginHeader)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passTextField)
        addSubview(SignUpBtn)
        addSubview(loginBtn)
    }
    override func constraintViews() {
        super.constraintViews()
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-200)
        }
        loginHeader.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom)
            make.centerX.equalToSuperview()
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(loginHeader.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).inset(1)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        passTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        SignUpBtn.snp.makeConstraints { make in
            make.top.equalTo(passTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(SignUpBtn.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    override func configureAppearance() {
        super.configureAppearance()
        self.backgroundColor = .black
        nameTextField.configure("Имя", .top, "name")
        emailTextField.configure("Email", .without, "email")
        passTextField.configure("Пароль", .bottom, "password", true)
        
        loginBtn.addTarget(self, action: #selector(loginBtnHandler), for: .touchUpInside)
        SignUpBtn.addTarget(self, action: #selector(signUpBtnHandler), for: .touchUpInside)
    }
}

extension SignUpView {
    @objc func loginBtnHandler() {
        delegate?.didLoginBtnTapped()
    }
    @objc func signUpBtnHandler() {
        delegate?.signUpBtnTapped()
    }
}

