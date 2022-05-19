//
//  UIStackView + ext.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import UIKit

extension UIStackView {
    
    @discardableResult
    func axis(_ value: NSLayoutConstraint.Axis) -> Self {
        axis = value
        
        return self
    }
    
    @discardableResult
    func alignment(_ value: UIStackView.Alignment) -> Self {
        alignment = value
        
        return self
    }
    
    @discardableResult
    func distribution(_ value: UIStackView.Distribution) -> Self {
        distribution = value
        
        return self
    }
    
    
    @discardableResult
    func spacing(_ value: CGFloat) -> Self {
        spacing = value
        
        return self
    }
}
