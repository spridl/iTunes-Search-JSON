//
//  SearchViewController.swift
//  iTunes Search JSON
//
//  Created by Тимур on 12.04.2022.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.text = ""
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "searchSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let trackListTVC = segue.destination as? TrackListTableViewController else { return }
        guard let searchText = searchTextField.text else { return }
        trackListTVC.searchText = searchText
    }
}
