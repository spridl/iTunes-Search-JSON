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
    
    private var animationStarted = false
    
    private let player = AVPlayer()
    private let networkManager = NetworkManager.shared
    var track: Track!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        configure()
        playTrack()
        setImageAnimate()
    }
    
    @IBAction func playPauseButtonPressed() {
        setButtonAnimate()
        setImageAnimate()
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
    
    private func setButtonAnimate() {
        playPauseButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 2.5,
            options: .allowUserInteraction) {
                self.playPauseButton.transform = CGAffineTransform.identity
            }
    }
    
    private func setImageAnimate() {
        trackImageView.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 5,
            initialSpringVelocity: 0.1,
            options: [.autoreverse, .repeat]) {
                if !self.animationStarted {
                    self.trackImageView.transform = CGAffineTransform.identity
                    self.animationStarted.toggle()
                } else {
                    self.trackImageView.layer.removeAllAnimations()
                    self.animationStarted.toggle()
                }
                
            }
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
