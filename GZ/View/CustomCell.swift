//
//  CustomCell.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import UIKit

class CustomCell: UITableViewCell {
       
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    func setup(data: Purchase) {
        numberLabel.text = "№\(data.purchaseNumber)"
        regionLabel.text = "Регион закупки: \(data.region)"
        priceLabel.text = "\(data.maxPrice) ₽"
        nameLabel.text = "\(data.responsibleName)"
        infoLabel.text = "\(data.purchaseObjectInfo)"
    }
    
    func setup(data: FavoritePurchase) {
        numberLabel.text = "№\(data.purchaseNumber!)"
        regionLabel.text = "Регион закупки: \(data.region)"
        priceLabel.text = "\(data.maxPrice!) ₽"
        nameLabel.text = "\(data.responsibleName!)"
        infoLabel.text = "\(data.purchaseObjectInfo!)"
    }
}

