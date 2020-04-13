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
            present(bmiViewController, animated: true)
        } catch {
            let errorAlertController = UIAlertController(title: "Ошибка",
                                                         message: error as? BMIErrors != nil ? (error as! BMIErrors).localizedDescription : "Неизвестная ошибка" ,
                                                         preferredStyle: .alert)
            let errorAlertActionOk = UIAlertAction(title: "OK",
                                                 style: .default)
            
            let errorAlertActionClear = UIAlertAction(title: "Очистить",
                                                      style: .destructive) {
                                                        [weak self] (_) in
                                                        switch error {
                                                        case BMIErrors.weightError:
                                                            self?.weightTextField.text = ""
                                                        case BMIErrors.heightError:
                                                            self?.heightTextField.text = ""
                                                        default: break
                                                        }
            }
            errorAlertController.addAction(errorAlertActionClear)
            errorAlertController.addAction(errorAlertActionOk)
            present(errorAlertController, animated: true)
        }
    }
    //MARK: Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    @objc func showIdealWeightSwitchChanged(paramTarget: UISwitch) {
        UIView.animate(withDuration: CATransaction.animationDuration()) {
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

