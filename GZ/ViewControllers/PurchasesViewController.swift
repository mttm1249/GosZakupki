//
//  ViewController.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import UIKit

class PurchasesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pagesCount = 1
    
    let network = NetworkManager()
    var purchasesArray = [Purchase]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingIndicator()
        tableView.delegate = self
        tableView.dataSource = self
        registerCustomCell()
        fetch()
        navigationItem.title = "Страница: \(pagesCount)"
    }
           
    func showLoadingIndicator() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    
    func fetch() {
        network.loadJson() { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("loading data")
    }
    
    func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(Purchases.self, from: jsonData)
            purchasesArray = decodedData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func nextDayButton(_ sender: Any) {
        network.nextPage()
        purchasesArray.removeAll()
        tableView.tableFooterView?.isHidden = false
        fetch()
        pagesCount += 1
        navigationItem.title = "Страница: \(pagesCount)"
        tableView.reloadData()
    }
   
    func registerCustomCell() {
        let asteroidCell = UINib(nibName: "PurchaseCell", bundle: nil)
        self.tableView.register(asteroidCell,forCellReuseIdentifier: "CustomCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell
        else { return UITableViewCell() }
        cell.setup(data: purchasesArray[indexPath.row])
        return cell
    }
    
    // Hide spinner method
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.tableView.tableFooterView?.isHidden = true
        }
    }
}

