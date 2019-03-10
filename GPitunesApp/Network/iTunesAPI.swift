//
//  iTunesAPI.swift
//  GPitunesApp
//
//  Created by gnoa001 on 3/3/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

struct iTunesAPI {
    
    static func fetchData(mediaType: MediaType, completion: @escaping ([MediaItem], Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/\(mediaType.query)/all/25/explicit.json"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    completion([], error)
                    return
            }
            
            do {
                struct Welcome: Codable {
                    let feed: Feed
                }
                
                struct Feed: Codable {
                    let results: [Result]
                }
                
                struct Result: Codable {
                    let name: String
                    let artworkUrl100: String
                }
                
                let welcomeData = try JSONDecoder().decode(Welcome.self, from: data)
                
                let mediaItems = welcomeData.feed.results.map { MediaItem(title: $0.name, imageURL: $0.artworkUrl100, mediaType: mediaType) }
                
                completion(mediaItems, error)
                
            } catch let decodingError {
                completion([], decodingError)
            }
        }.resume()
    }
}
