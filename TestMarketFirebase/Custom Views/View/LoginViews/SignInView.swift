//
//  LoginView.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit
import SnapKit

struct authData {
    let email: String
    let password: String
}

protocol LoginViewDelegate: AnyObject {
    func didSignUpBtnTapped()
    func signInBtnTapped()
}

final class SignInView: BaseView {
    weak var delegate: LoginViewDelegate?
    //MARK: - Public
    func authData() -> authData {
        guard let safeMail = self.emailTextField.textField.text,
              let safePass = self.passTextField.textField.text else {
            return authData()
        }
        let data = TestMarketFirebase.authData( email: safeMail,
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
        let text = "Войти с email"
        let attributedString = NSMutableAttributedString(string: text)
        let rangeBold = (text as NSString).range(of: "Войти")
        let fontBold = Resources.Fonts.systemWeight(with: 18, weight: .bold)
        attributedString.addAttributes([NSAttributedString.Key.font: fontBold], range: rangeBold)
        let rangeLight = (text as NSString).range(of: "с email")
        let fontLight = Resources.Fonts.systemWeight(with: 20, weight: .light)
        attributedString.addAttributes([NSAttributedString.Key.font: fontLight], range: rangeLight)
        
        label.attributedText = attributedString
        label.textColor = Resources.Colors.titlePurp
        return label
    }()
    
    private let signInBtn: UIButton = {
        let btn = UIButton()
        let title = NSAttributedString(string: "Войти", attributes: [
            NSAttributedString.Key.font: Resources.Fonts.systemWeight(with: 14, weight: .medium),
            NSAttributedString.Key.foregroundColor: Resources.Colors.lightGreen])
        btn.setAttributedTitle(title, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = Resources.Colors.darkGreen.withAlphaComponent(0.3)
        return btn
    }()
    
    private let emailTextField = LoginTextField()
    private let passTextField = LoginTextField()
    
    private let forgetPassBtn: UIButton = {
        let btn = UIButton()
        let title = NSAttributedString(string: "Вспомнить пароль", attributes: [
            NSAttributedString.Key.font: Resources.Fonts.systemWeight(with: 13, weight: .medium),
            NSAttributedString.Key.foregroundColor: Resources.Colors.blue
        ])
        btn.setAttributedTitle(title, for: .normal)
        return btn
    }()
    
    private let signUpBtn: UIButton = {
        let btn = UIButton()
        let title = NSAttributedString(string: "Регистрация", attributes: [
            NSAttributedString.Key.font: Resources.Fonts.systemWeight(with: 13, weight: .medium),
            NSAttributedString.Key.foregroundColor: Resources.Colors.titlePurp
        ])
        btn.setAttributedTitle(title, for: .normal)
        return btn
    }()
}

extension SignInView {
    override func setupViews() {
        super.setupViews()
        addSubview(logo)
        addSubview(loginHeader)
        addSubview(emailTextField)
        addSubview(passTextField)
        addSubview(signInBtn)
        addSubview(forgetPassBtn)
        addSubview(signUpBtn)
    }
    override func constraintViews() {
        super.constraintViews()
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-160)
        }
        loginHeader.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom)
            make.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(loginHeader.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        passTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        signInBtn.snp.makeConstraints { make in
            make.top.equalTo(passTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        forgetPassBtn.snp.makeConstraints { make in
            make.top.equalTo(signInBtn.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(forgetPassBtn.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    override func configureAppearance() {
        super.configureAppearance()
        self.backgroundColor = .black
        emailTextField.configure("Email", .top, "email")
        passTextField.configure("Пароль", .bottom, "password", true)
        
        signUpBtn.addTarget(self, action: #selector(signUpBtnHandler), for: .touchUpInside)
        signInBtn.addTarget(self, action: #selector(signInBtnHandler), for: .touchUpInside)
    }
}

extension SignInView {
    @objc func signUpBtnHandler() {
        delegate?.didSignUpBtnTapped()
    }
    @objc func signInBtnHandler() {
        delegate?.signInBtnTapped()
    }
}

