//
//  UIView+Helpers.swift
//  
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import UIKit

enum BorderSide: String {
    case left, right, top, bottom, all
}

extension UIView {
    
    // MARK: - Shadows
    func addDefaultPosterShadow() {
        let defaultOffset: CGSize = CGSize(width: 0, height: 5)
        let defaultRadius: CGFloat = 6.0
        let defaultOpacity: Float = 0.7
        
        self.addDropShadow(color: .darkGray, offSet: defaultOffset, radius: defaultRadius, opacity: defaultOpacity)
    }
    
    func addSimpleDropShadow() {
        let defaultOffset: CGSize = CGSize(width: 0, height: 0)
        let defaultRadius: CGFloat = 2.0
        let defaultOpacity: Float = 1.0
        
        self.addDropShadow(color: UIColor.black, offSet: defaultOffset, radius: defaultRadius, opacity: defaultOpacity)
    }
    
    func addDropShadow(color: UIColor, offSet: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
    // MARK: - Borders
    func addDefaultBorder(side: BorderSide) {
        let defaultColor = UIColor.primaryColor
        let defaultWidth = CGFloat(1.0)
        addBorder(side: side, color: defaultColor, width: defaultWidth)
    }
    
    func addBorder(side: BorderSide, color: UIColor, width: CGFloat) {
        let borderLayer = CALayer()
        borderLayer.backgroundColor = color.cgColor
        borderLayer.name = side.rawValue
        switch side {
        case .left:
            borderLayer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
            self.layer.addSublayer(borderLayer)
        case .right:
            borderLayer.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
            self.layer.addSublayer(borderLayer)
        case .top:
            borderLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
            self.layer.addSublayer(borderLayer)
        case .bottom:
            borderLayer.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
            self.layer.addSublayer(borderLayer)
        case .all:
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = width
            self.layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    func remove(border: BorderSide) {
        if border == .all {
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0
        }
        
        guard let sublayers = self.layer.sublayers else { return }
        var layerForRemove: CALayer?
        for layer in sublayers {
            if layer.name == border.rawValue {
                layerForRemove = layer
            }
        }
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
}
