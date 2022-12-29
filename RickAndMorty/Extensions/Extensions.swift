//
//  Extensions.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}
