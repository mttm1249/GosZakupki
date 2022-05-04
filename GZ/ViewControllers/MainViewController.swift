//
//  MainViewController.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
        
    let shared = CurrentURL.shared
    let pickerArrayComponents = ["44-ФЗ", "223-ФЗ"]
  
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var regionTextField: UITextField!
    @IBOutlet weak var responsibleNameLabel: UITextField!
    @IBOutlet weak var purchaseObjectInfoLabel: UITextField!
    @IBOutlet var innTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        regionTextField.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArrayComponents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArrayComponents[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            shared.url = CurrentURL.shared.fz44URL
            shared.defaultLawNumber = "44-ФЗ"
        case 1:
            shared.url = CurrentURL.shared.fz223URL
            shared.defaultLawNumber = "223-ФЗ"
        default:
            break
        }
    }
    
    // Ограничение вводимых символов в поле региона
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 3
    }
        
    // Кнопка перехода на страницу с закупками
    @IBAction func showButton(_ sender: Any) {
        saveChanges()
        performSegue(withIdentifier: "showPurchases", sender: nil)
    }
    
    private func saveChanges() {
       // Поиск по региону
        if regionTextField.text != "" {
            shared.region = shared.segmentRegion + regionTextField.text!
            let regionNumber = Int(regionTextField.text!)!
            if regionNumber > 203 {
                regionTextField.text = "203"
                shared.region = shared.segmentRegion + regionTextField.text!
            }
        } else {
            shared.region = ""
        }
        // Поиск по наименованию заказчика
        if responsibleNameLabel.text != "" {
            shared.name = shared.segmentName + responsibleNameLabel.text!
        } else {
            shared.name = ""
        }
        // Поиск по ИНН
        if innTextField.text != "" {
            shared.inn = shared.segmentForInn + innTextField.text!
        } else {
            shared.inn = ""
        }
        // Поиск по наименованию закупки
        if purchaseObjectInfoLabel.text != "" {
            shared.info = shared.segmentInfo + purchaseObjectInfoLabel.text!
        } else {
            shared.info = ""
        }
    }
}
