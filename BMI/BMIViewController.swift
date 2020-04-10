//
//  BMIViewController.swift
//  BMI
//
//  Created by Илья Бочков  on 4/10/20.
//  Copyright © 2020 Илья Бочков . All rights reserved.
//

import UIKit

class BMIViewController: UIViewController {
    
    let bmi: BMI
    @IBOutlet weak var idealWeightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
    init(bmi: BMI) {
        self.bmi = bmi
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = "Ваш индекс массы тела - \(String(format: "%.3f", bmi.value)) кг/м^2"
        if let idealWeight = bmi.idealWeight {
            idealWeightLabel.isHidden = false
            idealWeightLabel.text = "Ваш идеальный вес - \(String(format: "%.3f", idealWeight)) кг"
        }
    }
}
