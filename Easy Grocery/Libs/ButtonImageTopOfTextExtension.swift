//
//  ButtonImageTopOfText.swift
//  Easy Grocery
//
//  Created by Nikita on 20.04.2023.
//

import UIKit

extension UIButton {
    func scaleImage(_ coef: CGFloat) {
        self.imageView?.layer.transform = CATransform3DMakeScale(coef, coef, coef)
    }
    
    func centerVertically(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
//        self.contentEdgeInsets = UIEdgeInsets(
//            top: 0.0,
//            left: 0.0,
//            bottom: titleLabelSize.height,
//            right: 0.0
//        )
    }
    
}
