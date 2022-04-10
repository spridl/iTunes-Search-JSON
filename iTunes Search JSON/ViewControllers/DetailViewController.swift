//
//  ViewController.swift
//  iTunes Search JSON
//
//  Created by Тимур on 08.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    var track: Track!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        configure()
    }
    
    private func configure() {
        let changeSizeImage = track.artworkUrl100?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = changeSizeImage else { return }
        
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        collectionNameLabel.text = track.collectionName
        
        networkManager.fetchImage(of: url) { image in
            DispatchQueue.main.async {
                guard let image = image else { return }
                self.trackImageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
