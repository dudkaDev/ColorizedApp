//
//  StartViewController.swift
//  ColorizedApp
//
//  Created by Андрей Абакумов on 12.10.2022.
//

import UIKit

protocol SettingsVCDelegate {
    func setColor(for viewBackground: UIColor)
}

class StartViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.viewColor = view.backgroundColor
    }
}

// MARK: - SettingsVCDelegate
extension StartViewController: SettingsVCDelegate {
    func setColor(for viewBackground: UIColor) {
        view.backgroundColor = viewBackground
    }
}
