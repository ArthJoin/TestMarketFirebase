//
//  AccountVC.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit

final class AccountVC: BaseController {
    private let loginView = SignInView()
}

extension AccountVC {
    override func setupViews() {
        super.setupViews()
        view.addSubview(loginView)
    }
    override func constraintViews() {
        super.constraintViews()
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureAppearance() {
        super.configureAppearance()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        loginView.delegate = self
    }
}


extension AccountVC: LoginViewDelegate {
    func didSignUpBtnTapped() {
        let secondVC = SignUpVC()
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true)
    }
}

