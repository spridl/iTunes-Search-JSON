//
//  TrackListTableViewController.swift
//  iTunes Search JSON
//
//  Created by Тимур on 08.04.2022.
//

import UIKit

class TrackListTableViewController: UITableViewController {
    
    private let activityIndicator = UIActivityIndicatorView()
    private let networkManager = NetworkManager.shared
    private var tracks = [Track]()
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        navigationItem.title = searchText
        fetchTracks()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? TrackCell else { return UITableViewCell() }
        
        cell.configure(with: tracks[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailVC.track = tracks[indexPath.row]
    }
    
    private func setActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerYAnchor.constraint(
            equalTo: view.centerYAnchor,
            constant: -50
        ).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
     
     private func fetchTracks() {
         networkManager.fetchTracks(with: searchText) { result in
             switch result {
             case .success(let tracks):
                 self.tracks = tracks
                 self.tableView.reloadData()
                 self.activityIndicator.stopAnimating()
             case .failure(let error):
                 print(error)
             }
         }
     }
}
