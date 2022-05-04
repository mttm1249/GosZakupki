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

    // URL Segments
    let segmentRegion = "&region="
    let segmentForInn = "&responsible_inn="
    var segmentName = "&responsible_name="
    var segmentInfo = "&purchase_object_info="
    var region = ""
    var inn = ""
    var name = ""
    var info = ""

    // Options for PickerView
    let fz44URL = "https://fz44.gosplan.info/api/v1/purchases"
    let fz223URL = "https://223.gosplan.info/api/v1/purchases"
    
    static let shared = CurrentURL()
    private init() {}
}

