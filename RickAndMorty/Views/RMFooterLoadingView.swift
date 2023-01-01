//
//  RMFooterLoadingView.swift
//  RickAndMorty
//
//  Created by iMac on 01/01/23.
//

import UIKit

final class RMFooterLoadingView: UICollectionReusableView {
     
    // MARK: - Properties
    static let identifier = "RMFooterLoadingView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Helpers
    private func addConstraints() {
        spinner.setDimensions(height: 100, width: 100)
        spinner.centerInSuperview()
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
