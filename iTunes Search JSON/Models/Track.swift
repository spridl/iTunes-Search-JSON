//
//  Track.swift
//  iTunes Search JSON
//
//  Created by Тимур on 08.04.2022.
//

// MARK: - Track

struct Track: Decodable {
    let artistName: String
    let trackName: String
    let collectionName: String?
    let artworkUrl100: String?
    var previewUrl: String?
    
    init(tracksData: [String: Any]) {
        artistName = tracksData["artistName"] as? String ?? ""
        trackName = tracksData["trackName"] as? String ?? ""
        collectionName = tracksData["collectionName"] as? String
        artworkUrl100 = tracksData["artworkUrl100"] as? String
        previewUrl = tracksData["previewUrl"] as? String
    }
    
    static func getTracks(from value: Any) -> [Track] {
        guard let tracksData = value as? [[String: Any]] else { return []}
        return tracksData.compactMap { Track(tracksData: $0) }
    }
}
