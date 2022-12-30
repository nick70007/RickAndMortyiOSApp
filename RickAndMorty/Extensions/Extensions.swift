//
//  Extensions.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import Foundation
import UIKit

func delay(durationInSeconds seconds: Double = 0.0, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

extension UIView {
    
    func addSubViews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
    
    func setCellDropShadow(cornerRadius: CGFloat? = 0.0, shadowRadius: CGFloat, shadowColor:UIColor, shadowOpacity:Float, offsetWidth: CGFloat, offsetHeight: CGFloat) {
        delay {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = cornerRadius ?? 0.0
            self.layer.shadowRadius = shadowRadius
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius!, height:
                cornerRadius!)).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    func roundSpecificCorners(corners: UIRectCorner, radius: CGFloat) {
        delay {
            let path = UIBezierPath(roundedRect: self.self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
