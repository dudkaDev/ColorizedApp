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
    
    @IBAction func doneButtonPresser() {
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
        redValueLabel.text = (String(format: "%.2f", redSlider.value))
        greenValueLabel.text = (String(format: "%.2f", greenSlider.value))
        blueValueLabel.text = (String(format: "%.2f", blueSlider.value))
    }
}

//MARK: - Methods for text fields and keyboard
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            showAlert(
                title: "Wrong format!",
                message: "Please enter correct value",
                textField: textField
            )
        }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                redValueLabel.text = (String(format: "%.2f", redSlider.value))
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                greenValueLabel.text = (String(format: "%.2f", greenSlider.value))
            default:
                blueSlider.setValue(currentValue, animated: true)
                blueValueLabel.text = (String(format: "%.2f", blueSlider.value))
            }
            setColor()
            return
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapOne)
        )
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolBar.items = [flexibleSpace, doneButton]
    }
    
    @objc private func didTapOne() {
        view.endEditing(true)
    }
    
    private func setValueTextFields() {
        redTextField.text = (String(format: "%.2f", redSlider.value))
        greenTextField.text = (String(format: "%.2f", greenSlider.value))
        blueTextField.text = (String(format: "%.2f", blueSlider.value))
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = (String(format: "%.2f", self.redSlider.value))
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
