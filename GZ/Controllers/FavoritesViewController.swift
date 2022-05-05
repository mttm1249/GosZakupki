//
//  FavoritesViewController.swift
//  GZ
//
//  Created by Денис on 04.05.2022.
//

import UIKit
import CoreData

class FavoritesViewController: UITableViewController {
    
    var favoritePurchasesArray: [FavoritePurchase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let context = AppDelegate.getContext()
        let fetchRequest: NSFetchRequest<FavoritePurchase> = FavoritePurchase.fetchRequest()
        do {
            favoritePurchasesArray = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    // Удаление записи
    func deleteTask(_ tableView: UITableView, at indexPath: IndexPath) {
        self.favoritePurchasesArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .bottom)
        
        let context = AppDelegate.getContext()
        let fetchRequest: NSFetchRequest<FavoritePurchase> = FavoritePurchase.fetchRequest()
        
        if let favoritePurchasesArray = try? context.fetch(fetchRequest) {
            let purchase = favoritePurchasesArray[indexPath.row]
            context.delete(purchase)
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source
    
    // Регистрируем CustomCell
    func registerCustomCell() {
        let customCell = UINib(nibName: "PurchaseCell", bundle: nil)
        self.tableView.register(customCell,forCellReuseIdentifier: "CustomCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePurchasesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell
        else { return UITableViewCell() }
        cell.setup(data: favoritePurchasesArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(tableView, at: indexPath)
        }
    }
}
