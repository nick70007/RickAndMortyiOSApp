//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by iMac on 14/01/23.
//

import UIKit

/// Controller to show details about single Episode
final class RMEpisodeDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }
}
