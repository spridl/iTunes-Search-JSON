//
//  ViewController.swift
//  iTunes Search JSON
//
//  Created by Тимур on 08.04.2022.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    private let player = AVPlayer()
    private let networkManager = NetworkManager.shared
    var track: Track!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        configure()
        playTrack()
    }
    
    @IBAction func playPauseButtonPressed() {
        if player.timeControlStatus == .playing {
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
        } else {
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
        }
    }
    
    private func playTrack() {
        guard let url = URL(string: track.previewUrl ?? "") else { return }
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        player.play()
    }
    
    private func configure() {
        let changeSizeImage = track.artworkUrl100?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = changeSizeImage else { return }
        
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        collectionNameLabel.text = track.collectionName
        
        networkManager.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                self.trackImageView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
