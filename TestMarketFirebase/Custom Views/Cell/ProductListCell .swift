//
//  ProductListCell .swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit

final class ProductListCell: UICollectionViewCell {
    //MARK: - Public
    func configure(_ data: ProductItem) {
        self.activityIndicator.startAnimating()
        NetworkManager.shared.getImage(picName: data.image) { [weak self] image in
            self?.productImage.image = image
            self?.activityIndicator.stopAnimating()
        }
        self.productName.text = data.name
        self.productDiscription.text = data.discription
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private properties
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    private let viewImage = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let productImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    private let productName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Resources.Fonts.helveticaRegular(with: 15)
        return label
    }()
    private let productDiscription: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.gray
        label.font = Resources.Fonts.helveticaRegular(with: 12)
        label.numberOfLines = 0
        return label
    }()
}

extension ProductListCell {
    func initialize() {
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainView.addSubview(viewImage)
        viewImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(150)
        }
        viewImage.addSubview(productImage)
        productImage.contentMode = .scaleAspectFit
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(5)
        }
        
        viewImage.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalTo(viewImage.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        mainView.addSubview(productDiscription)
        productDiscription.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}
