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
        var state: String? {
            switch bmi.value {
            case ...16:
                return "у вас выраженный дефицит массы тела"
            case 16...18.5:
                return "у вас недостаточная (дефицит) масса тела"
            case 18.5...24.99:
                return "у вас нормальная масса тела"
            case 25...30:
                return "у вас избыточная масса тела (предожирение)"
            case 30...35:
                return "у вас ожирение"
            case 35...40:
                return "у вас резкое ожирения"
            case 40...:
                return "у вас очень резкое ожирение"
            default:
                return nil
            }
        }
        bmiLabel.text = """
        Ваш индекс массы тела - \(String(format: "%.3f", bmi.value)) кг/м^2
        
        В соответствии с рекомендациями ВОЗ
        \(state != nil ? state! : "")
        """
        if let idealWeight = bmi.idealWeight {
            idealWeightLabel.isHidden = false
            idealWeightLabel.text = "Ваш идеальный вес - \(String(format: "%.3f", idealWeight)) кг"
        }
    }
}
