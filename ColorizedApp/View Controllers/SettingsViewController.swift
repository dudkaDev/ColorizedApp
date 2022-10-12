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
        setValues()
        
        doneButton.layer.cornerRadius = 12
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        changeColor()
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: sender)
        case greenSlider:
            greenValueLabel.text = string(from: sender)
        default:
            blueValueLabel.text = string(from: sender)
        }
    }
    
    @IBAction func doneButtonPresser() {
        delegate.setColor(for: colorResultView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}
    
    //MARK: - Private Methods for sliders and labels
extension SettingsViewController {
    private func changeColor() {
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
    
    private func setValues() {
        redValueLabel.text = (String(format: "%.2f", redSlider.value))
        greenValueLabel.text = (String(format: "%.2f", greenSlider.value))
        blueValueLabel.text = (String(format: "%.2f", blueSlider.value))
    }
}

    //MARK: - Private Methods for text fields and keyboards
extension SettingsViewController: UITextFieldDelegate {
    
    @objc private func didTapOne() {
        view.endEditing(true)
    }
}
