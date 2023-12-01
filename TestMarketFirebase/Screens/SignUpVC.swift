//
//  SignUpVC.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit

final class SignUpVC: BaseController {
    private let signUpView = SignUpView()
}

extension SignUpVC {
    override func setupViews() {
        super.setupViews()
        view.addSubview(signUpView)
    }
    override func constraintViews() {
        super.constraintViews()
        signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureAppearance() {
        super.configureAppearance()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        signUpView.delegate = self
    }
}

extension SignUpVC: SignUpViewDelegate {
    func didLoginBtnTapped() {
        self.dismiss(animated: true)
    }
}
