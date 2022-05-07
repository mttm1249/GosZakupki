//
//  CurrentURLManager.swift
//  GZ
//
//  Created by Денис on 03.05.2022.
//

import Foundation

class CurrentURL {
    
    // Default value
    var url = "https://fz44.gosplan.info/api/v1/purchases?"

    // URL Segments
    let segmentRegion = "&region="
    let segmentForInn = "&responsible_inn="
    let segmentName = "&responsible_name="
    let segmentInfo = "&purchase_object_info="
    let segmentNumber = "&purchase_number="
    let segmentOkpd2 = "okpd2="
    var region = ""
    var inn = ""
    var name = ""
    var info = ""
    var number = ""
    var okpd2 = ""

    // Options for PickerView
    let fz44URL = "https://fz44.gosplan.info/api/v1/purchases?"
    let fz223URL = "https://223.gosplan.info/api/v1/purchases?"
    
    // SelectedCellIndexPath
    var cellIndexPath: IndexPath?
    
    static let shared = CurrentURL()
    private init() {}
}

