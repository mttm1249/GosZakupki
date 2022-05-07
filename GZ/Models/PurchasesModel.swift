//
//  PurchasesModel.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import Foundation

// MARK: - PurchaseElement

struct Purchase: Model {
    let region: Int
    let purchaseObjectInfo: String
    let purchaseNumber: String
    let maxPrice: String
    let responsibleName: String

    enum CodingKeys: String, CodingKey {
        case region
        case purchaseObjectInfo = "purchase_object_info"
        case purchaseNumber = "purchase_number"
        case maxPrice = "max_price"
        case responsibleName = "responsible_name"
    }
}

typealias Purchases = [Purchase]
