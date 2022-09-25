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
    
    @IBAction func sliderAction() {
        roundValue()
        
        changeColor()
    }

    private func roundValue() {
        let redSliderValue = redSlider.value
        let greenSliderValue = greenSlider.value
        let blueSliderValue = blueSlider.value
        
        redValueLabel.text = (String(format: "%.2f", redSliderValue))
        greenValueLabel.text = (String(format: "%.2f", greenSliderValue))
        blueValueLabel.text = (String(format: "%.2f", blueSliderValue))
    }
    
    private func changeColor() {
        colorResultView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value)/1,
            green: CGFloat(greenSlider.value)/1,
            blue: CGFloat(blueSlider.value)/1, alpha: 1
        )
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
