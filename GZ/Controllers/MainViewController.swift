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
    @IBOutlet weak var numberTextField: UITextField!
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
            shared.url = shared.fz44URL
        case 1:
            shared.url = shared.fz223URL
        default:
            break
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 2
    }
    
    // Кнопка перехода на страницу с закупками
    @IBAction func showButton(_ sender: Any) {
        saveChanges()
        performSegue(withIdentifier: "showPurchases", sender: nil)
    }
    
    @IBAction func clearButton(_ sender: Any) {
        regionTextField.text = ""
        numberTextField.text = ""
        responsibleNameLabel.text = ""
        purchaseObjectInfoLabel.text = ""
        innTextField.text = ""
    }
    
    // MARK: Save
    private func saveChanges() {
        // Поиск по региону
        if regionTextField.text != "" {
            shared.region = shared.segmentRegion + regionTextField.text!
            let regionNumber = Int(regionTextField.text!)!
            if regionNumber > 95 {
                regionTextField.text = "95"
                shared.region = shared.segmentRegion + regionTextField.text!
            }
        } else {
            shared.region = ""
        }
        // Поиск по номеру закупки
        if numberTextField.text != "" {
            shared.number = shared.segmentNumber + numberTextField.text!
        } else {
            shared.number = ""
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

