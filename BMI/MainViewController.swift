//
//  ViewController.swift
//  BMI
//
//  Created by Илья Бочков  on 4/10/20.
//  Copyright © 2020 Илья Бочков . All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    //MARK: IBOutlet and Properties
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var showIdealWeightSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available (iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        weightTextField.delegate = self
        heightTextField.delegate = self
        showIdealWeightSwitch.addTarget(self, action: #selector(showIdealWeightSwitchChanged(paramTarget:)), for: .valueChanged)
    }
    //MARK: @IBAction
    @IBAction func bmiButton(_ sender: UIButton) {
        do {
            let bmi = try BMI(weight: weightTextField.text,
                              height: heightTextField.text,
                              isIdealWeightNeed: showIdealWeightSwitch.isOn,
                              sex: showIdealWeightSwitch.isOn ? convertToSex(selectedSegmentIndex: sexSegmentedControl.selectedSegmentIndex) : nil)
            let bmiViewController = BMIViewController(bmi: bmi)
            present(bmiViewController, animated: true, completion: nil)
        } catch {
            let errorAlertController = UIAlertController(title: "Error",
                                                         message: error as? BMIErrors != nil ? (error as! BMIErrors).localizedDescription : "Unknown error" ,
                                                         preferredStyle: .alert)
            let errorAlertAction = UIAlertAction(title: "OK",
                                                 style: .default,
                                                 handler: nil)
            errorAlertController.addAction(errorAlertAction)
            present(errorAlertController, animated: true, completion: nil)
        }
    }
    //MARK: Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    @objc func showIdealWeightSwitchChanged(paramTarget: UISwitch) {
        UIView.animate(withDuration: 0.2) {
            [weak self] () in
            self?.sexSegmentedControl.isHidden = !paramTarget.isOn
            self?.view.layoutIfNeeded()
        }
    }
    func convertToSex(selectedSegmentIndex: Int) -> Sex {
        switch selectedSegmentIndex {
        case 0:
            return .man
        case 1:
            return .woman
        default:
            return .none
        }
    }
}

