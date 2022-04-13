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
        showSearchResults()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let trackListTVC = segue.destination as? TrackListTableViewController else { return }
        guard let searchText = searchTextField.text else { return }
        trackListTVC.searchText = searchText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func showSearchResults() {
        guard let text = searchTextField.text else { return }
        if !text.isEmpty {
            performSegue(withIdentifier: "searchSegue", sender: nil)
        } else {
            setAlertController(title: "Error", message: "Search text field is empty")
        }
    }
    
    private func setAlertController(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        showSearchResults()
        return true
    }
}
