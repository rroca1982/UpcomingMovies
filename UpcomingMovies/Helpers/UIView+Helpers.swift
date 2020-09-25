//
//  UIView+Helpers.swift
//  
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Shadows
    func addDefaultPosterShadow() {
        let defaultOffset: CGSize = CGSize(width: 0, height: 5)
        let defaultRadius: CGFloat = 6.0
        let defaultOpacity: Float = 0.7
        
        self.addDropShadow(color: .darkGray, offSet: defaultOffset, radius: defaultRadius, opacity: defaultOpacity)
    }
    
    func addDropShadow(color: UIColor, offSet: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
}
