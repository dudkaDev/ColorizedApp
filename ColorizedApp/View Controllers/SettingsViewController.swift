//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Андрей Абакумов on 23.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var colorResultView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    var viewColor: UIColor!
    var delegate: SettingsVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorResultView.layer.cornerRadius = 12
        colorResultView.backgroundColor = viewColor
        
        setSliders()
        setValueLabels()
        setValueTextFields()
        
        doneButton.layer.cornerRadius = 12
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: sender)
            redTextField.text = string(from: sender)
        case greenSlider:
            greenValueLabel.text = string(from: sender)
            greenTextField.text = string(from: sender)
        default:
            blueValueLabel.text = string(from: sender)
            blueTextField.text = string(from: sender)
        }
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(for: colorResultView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}

//MARK: - Private Methods for sliders and labels
extension SettingsViewController {
    private func setColor() {
        colorResultView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func setValueLabels() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setValueTextFields() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = String(format: "%.2f", self.redSlider.value)
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - Methods for text fields and keyboard
extension SettingsViewController: UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            
            //Ограничиваем ввод букв и символов, кроме "."
            let allowedCharacters = CharacterSet(charactersIn: "01234567890.")
            let characterSet = CharacterSet(charactersIn: string)
            
            //Ограничиваем допустимое кол-во символов в текстовом поле
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            //Ограничиваем допустимое кол-во символа "."
            let dotsCount = textField.text!.components(separatedBy: ".").count - 1
            if dotsCount > 0 && (string == ".") {
                return false
            }
            
            return allowedCharacters.isSuperset(of: characterSet)
            && newString.length <= maxLength
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(
                title: "Wrong format!",
                message: "Please enter correct value"
            )
            return
        }
        
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                title: "Wrong format!",
                message: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(currentValue, animated: true)
            redValueLabel.text = String(format: "%.2f", redSlider.value)
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        default:
            blueSlider.setValue(currentValue, animated: true)
            blueValueLabel.text = String(format: "%.2f", blueSlider.value)
        }
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolBar.items = [flexibleSpace, doneButton]
    }
}
