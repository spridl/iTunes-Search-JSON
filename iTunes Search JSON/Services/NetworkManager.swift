//
//  NetworkManager.swift
//  iTunes Search JSON
//
//  Created by Тимур on 08.04.2022.
//
import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchTracks(with searchText: String, completion: @escaping(Result<[Track], NetworkError>) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": "\(searchText)", "limit": "\(20)", "media": "music"]
        AF.request(
            url,
            method: .get,
            parameters: parameters
        )
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let value = value as? [String: Any] else { return }
                    guard let results = value["results"] as? [[String: Any]] else { return }
                    let tracks = Track.getTracks(from: results)
                    completion(.success(tracks))
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
//
//    static let shared = NetworkManager()
//
//    private let urlSession = URLSession.shared
//    private let url = "https://itunes.apple.com/search?term=Linkin+Park&entity=musicTrack&limit=25"
//
//    func fetchTracks(completion: @escaping ([Track]?) -> ()) {
//
//        guard let url = URL(string: url) else { return }
//        urlSession.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//            do {
//                let tracksData = try JSONDecoder().decode(Tracks.self, from: data)
//                completion(tracksData.results)
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//
//    func fetchImage(of imageUrl: String, completion: @escaping (Data?) -> ()) {
//        guard let url = URL(string: imageUrl) else { return }
//        urlSession.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//            completion(data)
//        }.resume()
//    }
//    private init() {}
//}
