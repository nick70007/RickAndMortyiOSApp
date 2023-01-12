//
//  RMCharacterInfoViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 11/01/23.
//

import UIKit

final class RMCharacterInfoViewModel {
    
    // MARK: - Properties
    private let type: `Type`
    private let value: String
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    public var title: String { type.displayTitle }
    public var iconImage: UIImage? { return type.iconImage }
    public var tintColor: UIColor { return type.tintColor }
    
    public var displayValue: String {
        
        if value.isEmpty { return "None" }
        
        if let date = Self.dateFormatter.date(from: value), type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        
        return value
    }

    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
                case .status: return .systemBlue
                case .gender: return .systemRed
                case .type: return .systemPurple
                case .species: return .systemGreen
                case .origin: return .systemOrange
                case .location: return .systemPink
                case .created: return .systemYellow
                case .episodeCount: return .systemMint
            }
        }
        
        var iconImage: UIImage? {
            switch self {
                case .status: return UIImage.init(systemName: "bell")
                case .gender: return UIImage.init(systemName: "bell")
                case .type: return UIImage.init(systemName: "bell")
                case .species: return UIImage.init(systemName: "bell")
                case .origin: return UIImage.init(systemName: "bell")
                case .location: return UIImage.init(systemName: "bell")
                case .created: return UIImage.init(systemName: "bell")
                case .episodeCount: return UIImage.init(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
                case .status,
                     .gender,
                     .type,
                     .species,
                     .origin,
                     .location,
                     .created:
                    return rawValue.uppercased()
                case .episodeCount: return "EPISODE COUNT"
            }
        }
    }
    
    // MARK: - Init
    init(type: `Type`, value: String) {
        self.type = type
        self.value = value
    }
}
