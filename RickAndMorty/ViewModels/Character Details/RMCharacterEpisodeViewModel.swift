//
//  RMCharacterEpisodeViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 11/01/23.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeViewModel {
    
    // MARK: - Properties
    private let episodeDataURL: URL?
    private var isFetching = false
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else { return }
            dataBlock?(model)
        }
    }
    
    private var dataBlock: ((RMEpisodeDataRender) -> ())?
    
    // MARK: - Init
    init(episodeDataURL: URL?) { self.episodeDataURL = episodeDataURL }
    
    // MARK: - Methods
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode { dataBlock?(model) }
            return
        }
        guard let url = episodeDataURL, let request = RMRequest(url: url) else { return }
        isFetching = true
        
        RMService.shared.execute(request,
                                 type: RMEpisode.self) { [weak self] result in
            switch result {
                case .success(let episode):
                    DispatchQueue.main.async { self?.episode = episode }
                case .failure(let error): print(String(describing: error))
            }
        }
    }
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> ()) {
        self.dataBlock = block
    }
}
