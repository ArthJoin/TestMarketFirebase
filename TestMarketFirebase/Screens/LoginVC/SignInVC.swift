//
//  AccountVC.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit

final class SignInVC: BaseController {
    private let signInView = SignInView()
    private let networkManager = NetworkManager()
}

extension SignInVC {
    override func setupViews() {
        super.setupViews()
        view.addSubview(signInView)
    }
    override func constraintViews() {
        super.constraintViews()
        signInView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureAppearance() {
        super.configureAppearance()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        signInView.delegate = self
    }
}


extension SignInVC: LoginViewDelegate {
    func didSignUpBtnTapped() {
        let secondVC = SignUpVC()
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true)
    }
    func signInBtnTapped() {
        let data = signInView.authData()
        networkManager.signIn(email: data.email, password: data.password) { result in
            switch result.code {
            case 0:
                print(result.error?.localizedDescription)
            case 1:
                UserDefaults.standard.set(true, forKey: "isLogin")
                print("Auth done!")
            default:
                print("Unknown error")
            }
        }
    }
}

