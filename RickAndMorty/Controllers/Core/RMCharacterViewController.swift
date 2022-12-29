//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by iMac on 28/12/22.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        title = "Characters"

        RMService.shared.execute(.listCharactersRequests,
                                 type: RMGetAllCharactersResponse.self) { result in
            switch result {
                case .success(let model): print(String(describing: model))
                case .failure(let error): print(String(describing: error))
            }
        }
    }
}
