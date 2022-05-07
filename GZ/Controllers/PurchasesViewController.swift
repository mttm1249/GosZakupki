//
//  ViewController.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import UIKit
import CoreData

class PurchasesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var purchasesArray = [Purchase]()
    private var page = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingIndicator()
        tableView.delegate = self
        tableView.dataSource = self
        registerCustomCell()
        fetch()
        navigationItem.title = "Стр. \(page)"
    }
    
    // MARK: CoreData
    private func saveUserData(_ purchases: [Purchase]) {
        let context = AppDelegate.getContext()
        for purchase in purchases {
            let newEntry = NSEntityDescription.insertNewObject(forEntityName: "FavoritePurchase", into: context)
            newEntry.setValue(purchase.region, forKey: "region")
            newEntry.setValue(purchase.purchaseObjectInfo, forKey: "purchaseObjectInfo")
            newEntry.setValue(purchase.purchaseNumber, forKey: "purchaseNumber")
            newEntry.setValue(purchase.maxPrice, forKey: "maxPrice")
            newEntry.setValue(purchase.responsibleName, forKey: "responsibleName")
        }
        do {
            try context.save()
            print("Saved")
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
    
    // MARK: Load data from JSON
    private func fetch() {
        NetworkManager.shared.loadJson { [weak self] (result: Result<Purchases, Error>) in
            switch result {
            case .success(let data):
                self?.purchasesArray = data
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("loading")
    }
    
    // Листаем страницы
    @IBAction func nextDayButton(_ sender: Any) {
        //network.nextPage()
        purchasesArray.removeAll()
        tableView.tableFooterView?.isHidden = false
        fetch()
        page += 1
        navigationItem.title = "Стр. \(page)"
        tableView.reloadData()
    }
    
    // Индикатор загрузки
    private func showLoadingIndicator() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    
    // Регистрируем CustomCell
    private func registerCustomCell() {
        let customCell = UINib(nibName: "PurchaseCell", bundle: nil)
        self.tableView.register(customCell,forCellReuseIdentifier: "CustomCell")
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell
        else { return UITableViewCell() }
        cell.setup(data: purchasesArray[indexPath.row])
        return cell
    }
    
    // Скрываем индикатор загрузки
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.tableView.tableFooterView?.isHidden = true
        }
    }
    
    // Добавляем в избранное
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "★") { (action, view, completion) in
            let indexesToRedraw = [indexPath]
            let purchase = self.purchasesArray[indexPath.row]
            self.saveUserData([purchase])
            tableView.reloadRows(at: indexesToRedraw, with: .fade)
            tableView.reloadData()
        }
        action.backgroundColor = #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)
        let config = UISwipeActionsConfiguration(actions: [action])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}
