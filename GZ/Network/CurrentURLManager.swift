//
//  CurrentURLManager.swift
//  GZ
//
//  Created by Денис on 03.05.2022.
//

import Foundation

class CurrentURL {
    
    // URL
    var baseURL = "https://fz44.gosplan.info"
    var basePath = "/api/v1/purchases"

    var params: [URLQueryItem] {
        [
            .init(name: "region", value: region),
            .init(name: "responsible_inn", value: inn),
            .init(name: "responsible_name", value: name),
            .init(name: "purchase_object_info", value: info),
            .init(name: "purchase_number", value: number),
            .init(name: "okpd2", value: okpd2),
            .init(name: "page", value: page)
        ].filter { $0.value?.isEmpty == false }
    }
    
    // Parametres values
    var region: String?
    var inn: String?
    var name: String?
    var info: String?
    var number: String?
    var okpd2: String?
    var page: String?

    // Options for PickerView
    let fz44URL = "https://fz44.gosplan.info"
    let fz223URL = "https://223.gosplan.info"
    
    // SelectedCellIndexPath
    var cellIndexPath: IndexPath?
    
    static let shared = CurrentURL()
    private init() {}
}

