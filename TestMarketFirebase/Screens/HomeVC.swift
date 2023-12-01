//
//  HomeVC.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit
import SnapKit


final class HomeVC: UIViewController {
    private var collectionView: UICollectionView!
    private var data: [ProductItem] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupViews()
        constraintViews()
    }
}

extension HomeVC {
   func setupViews() {
        view.addSubview(collectionView)
    }
   func constraintViews() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    func configureAppearance() {
        networkManager.getProduct(collections: "product_list") { [weak self] result in
            self?.data = result
        }
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductListCell.self,
                                forCellWithReuseIdentifier: String(describing: ProductListCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProductListCell.self),
            for: indexPath) as! ProductListCell
        cell.configure(data[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 180, height: 230)
    }
}

