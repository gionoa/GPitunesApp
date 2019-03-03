//
//  MediaType.swift
//  GPitunesApp
//
//  Created by gnoa001 on 3/3/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

enum MediaType: String {
    case movies = "Movies"
    case music = "Music"
    case tvShows = "TV Shows"
    
    var query: String {
        switch self {
        case .movies: return "movies/top-movies"
        case .music: return "apple-music/top-albums"
        case .tvShows: return "tv-shows/top-tv-episodes"
        }
    }
    
    static var allTypes: [String] {
        return [MediaType.movies.rawValue,
                MediaType.music.rawValue,
                MediaType.tvShows.rawValue]
    }
    
    static func index(at index: Int) -> MediaType? {
        switch index {
        case 0: return .movies
        case 1: return .music
        case 2: return .tvShows
        default: return nil
        }
    }
}
