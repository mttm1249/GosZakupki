//
//  MainViewController.swift
//  GZ
//
//  Created by Денис on 02.05.2022.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    override var shouldAutorotate: Bool { return false }
    
    let pickerArrayComponents = ["44-ФЗ", "223-ФЗ"]
  
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var regionTextField: UITextField!
    @IBOutlet var innTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        regionTextField.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
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
            CurrentURL.shared.url = CurrentURL.shared.fz44URL
            CurrentURL.shared.defaultLawNumber = "44-ФЗ"
        case 1:
            CurrentURL.shared.url = CurrentURL.shared.fz223URL
            CurrentURL.shared.defaultLawNumber = "223-ФЗ"
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 3
    }
        
    private func animate(_ button: UIButton) {
        button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.9,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1.0),
                       initialSpringVelocity: CGFloat(60.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            button.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
        
    @IBAction func showButton(_ sender: Any) {
        saveChanges()
        performSegue(withIdentifier: "showPurchases", sender: nil)
    }
    private func saveChanges() {
        if regionTextField.text != "" {
            CurrentURL.shared.region = "&region=" + regionTextField.text!
            let regionNumber = Int(regionTextField.text!)!
            if regionNumber > 203 {
                regionTextField.text = "203"
                CurrentURL.shared.region = "&region=" + regionTextField.text!
            }
        } else {
            CurrentURL.shared.region = ""
        }
        let segment = CurrentURL.shared.segmentForInn
        if innTextField.text != "" {
            CurrentURL.shared.inn = segment + innTextField.text!
        } else {
            CurrentURL.shared.inn = ""
        }
    }
}
