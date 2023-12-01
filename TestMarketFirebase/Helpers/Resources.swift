//
//  Resources.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit

enum Resources {
    enum Colors {
        static var active = UIColor(hexString: "#67C4A7")
        static var inactive = UIColor(hexString: "#939393")
        
        static var separator = UIColor(hexString: "#939393")
        static var background = UIColor(hexString: "#FFFFFF")
        static var backgroundElement = UIColor(hexString: "#FAFAFC")
        static var transpulentGray = UIColor(hexString: "#F0F2F1")

        static var titleMain = UIColor(hexString: "#393F42")
        static var secondary = UIColor(hexString: "#C8C8CB")
        
        static var commonIcon = UIColor(hexString: "#200E32")
        
        static let titlePurp = UIColor(hexString: "#E3E2FF")
        static let darkGreen = UIColor(hexString: "#115517")
        static let lightGreen = UIColor(hexString: "#4DA861")
        static let gray = UIColor(hexString: "#6D6D6F")
        static let blue = UIColor(hexString: "#5B9CE8")
    }
    
    enum Strings {
        enum TabBar {
            static var home = "Home"
            static var wishlist = "Wishlist"
            static var account = "Account"
        }
    }
    
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
        static func systemWeight(with size: CGFloat, weight: UIFont.Weight) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
    enum Images {
        static func resizeImage(_ image: UIImage, _ targetSize: CGSize) -> UIImage {
            let rednerer = UIGraphicsImageRenderer(size: targetSize)
            let resizedImage = rednerer.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: targetSize))
            }
            return resizedImage
        }
        static let logo = UIImage(named: "logo_png")
    }
}
