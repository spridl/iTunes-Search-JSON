//
//  NetworkManager.swift
//  iTunes Search JSON
//
//  Created by Тимур on 08.04.2022.
//
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let urlSession = URLSession.shared
    private let url = "https://itunes.apple.com/search?term=Linkin+Park&entity=musicTrack&limit=25"
    
    func fetchTracks(completion: @escaping ([Track]?) -> ()) {
        
        guard let url = URL(string: url) else { return }
        urlSession.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let tracksData = try JSONDecoder().decode(Tracks.self, from: data)
                completion(tracksData.results)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImage(of imageUrl: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: imageUrl) else { return }
        urlSession.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            completion(data)
        }.resume()
    }
    private init() {}
}
