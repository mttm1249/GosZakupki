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
    
    var delegate: DataSendingDelegateProtocol!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomListCell", for: indexPath) as? CustomListCell
         else { return UITableViewCell() }
         cell.infoLabel.text = listArray[indexPath.row]
         cell.symbholLabel.text = "○"
         return cell
     }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = listArray[indexPath.row]
        let numberOfNote = "\(note.prefix(2))"
        delegate?.sendDataToMainViewController(string: numberOfNote)
        dismiss(animated: true)
    }
}
