//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Андрей Абакумов on 23.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorResultView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorResultView.layer.cornerRadius = 12
        randomValueAtStart()
        changeColor()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        changeColor()
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: sender)
        case greenValueLabel:
            greenValueLabel.text = string(from: sender)
        default:
            blueValueLabel.text = string(from: sender)
        }
    }
    
    private func roundValue() {
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
    }
    
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

    private func randomValueAtStart() {
        let redSliderValue = Float.random(
            in: redSlider.minimumValue..<redSlider.maximumValue
        )
        let greenSliderValue = Float.random(
            in: greenSlider.minimumValue..<greenSlider.maximumValue
        )
        let blueSliderValue = Float.random(
            in: blueSlider.minimumValue..<blueSlider.maximumValue
        )
        
        redValueLabel.text = (String(format: "%.2f", redSliderValue))
        greenValueLabel.text = (String(format: "%.2f", greenSliderValue))
        blueValueLabel.text = (String(format: "%.2f", blueSliderValue))
        
        redSlider.value = redSliderValue
        greenSlider.value = greenSliderValue
        blueSlider.value = blueSliderValue
    }
}
