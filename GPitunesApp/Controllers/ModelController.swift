//
//  ModelController.swift
//  GPitunesApp
//
//  Created by gnoa001 on 3/3/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

class ModelController {
    
    private var dataSource = [MediaType: [MediaItem]]()
    
    func fetchData(mediaType: MediaType, completion: @escaping (Error?) -> Void) {
        guard dataSource[mediaType] == nil else {
            completion(nil)
            return
        }
        
        iTunesAPI.fetchData(mediaType: mediaType) { (mediaItems, error) in
            self.dataSource[mediaType] = mediaItems
            completion(error)
        }
    }
    
    func count(for mediaType: MediaType) -> Int { // not Int? because nil coalescing
        return dataSource[mediaType]?.count ?? 0
    }
    
    func index(mediaType: MediaType?, at index: Int) -> MediaItem? {
        guard let mediaType = mediaType,
              let mediaArray = dataSource[mediaType],
              index < mediaArray.count else {
                
                return nil
        }
        return mediaArray[index]
    }
}
