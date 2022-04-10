//
//  TrackCell.swift
//  iTunes Search JSON
//
//  Created by Тимур on 10.04.2022.
//

import UIKit

class TrackCell: UITableViewCell {
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with track: Track) {
        trackImageView.layer.cornerRadius = 10
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        
        guard let url = track.artworkUrl100 else { return }
        networkManager.fetchImage(of: url) { image in
            DispatchQueue.main.async {
                guard let image = image else { return }
                self.trackImageView.image = image
            }
        }
    }
}
