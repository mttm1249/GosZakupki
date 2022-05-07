//
//  ListViewController.swift
//  GZ
//
//  Created by Денис on 05.05.2022.
//

import UIKit

protocol DataSendingDelegateProtocol {
    func sendDataToMainViewController(string: String)
}

class ListViewController: UITableViewController {
    
    private let listModel = ListModel()
    private let shared = CurrentURL.shared
    var delegate: DataSendingDelegateProtocol!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel.array.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomListCell", for: indexPath) as? CustomListCell
         else { return UITableViewCell() }
         cell.infoLabel.text = listModel.array[indexPath.row]
         if indexPath == shared.cellIndexPath {
             cell.symbholLabel.text = "◉"
         } else {
             cell.symbholLabel.text = "○"
         }
         return cell
     }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = listModel.array[indexPath.row]
        let numberOfNote = "\(note.prefix(2))"
        let currentIndexPath = indexPath
        shared.cellIndexPath = currentIndexPath
        delegate?.sendDataToMainViewController(string: numberOfNote)
        dismiss(animated: true)
    }
}
