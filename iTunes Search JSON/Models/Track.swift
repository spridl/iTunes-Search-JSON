//
//  Track.swift
//  iTunes Search JSON
//
//  Created by Тимур on 08.04.2022.
//

// MARK: - Track
struct Tracks: Decodable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    let artistName: String
    let trackName: String
    let collectionName: String?
    let artworkUrl100: String?
}
