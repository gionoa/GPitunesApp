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
}
