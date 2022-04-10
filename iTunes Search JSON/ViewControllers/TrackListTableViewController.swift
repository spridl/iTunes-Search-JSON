//
//  TrackListTableViewController.swift
//  iTunes Search JSON
//
//  Created by Тимур on 08.04.2022.
//

import UIKit

class TrackListTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
     
     private func fetchTracks() {
         networkManager.fetchTracks(completion: { tracksData in
             guard let tracksData = tracksData else { return }
             self.tracks = tracksData
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
         })
     }
}
