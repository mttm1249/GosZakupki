//
//  CurrentURLManager.swift
//  GZ
//
//  Created by Денис on 03.05.2022.
//

import Foundation

class CurrentURL {
    // Default values
    var url = "https://fz44.gosplan.info/api/v1/purchases"
    let segmentForInn = "&responsible_inn="
    let segmentName = "&responsible_name="    // todo
    var defaultLawNumber = "44-ФЗ"
    var region = ""
    var inn = ""

    
    // Options
    let fz44URL = "https://fz44.gosplan.info/api/v1/purchases"
    let fz223URL = "https://223.gosplan.info/api/v1/purchases"
    
    static let shared = CurrentURL()
    private init() {}
}
