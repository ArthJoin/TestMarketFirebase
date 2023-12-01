//
//  BaseController.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        constraintViews()
        configureAppearance()
    }
}

@objc extension BaseController {
    //MARK: - ViewDidLoad
    func setupViews() {}
    func constraintViews() {}
    func configureAppearance() {
        view.backgroundColor = .black
    }
    //MARK: - ViewWillAppear
    func fetchData() {}
}

