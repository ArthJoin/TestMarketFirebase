//
//  SignUpVC.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit

final class SignUpVC: BaseController {
    private let signUpView = SignUpView()
    private let networkManager = NetworkManager()
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
    func signUpBtnTapped() {
        let data = signUpView.regData()
        let safeEmail = data.email
        let safePass = data.password
        networkManager.createNewUser(email: safeEmail, password: safePass) { result in
            switch result.code {
            case 0:
                print(result.error?.localizedDescription)
            case 1:
                self.networkManager.confirmMail { error in
                    if error == nil {
                        print("Registration done!")
                        self.dismiss(animated: true)
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            default:
                print("Unknown error")
            }
        }
    }
}
