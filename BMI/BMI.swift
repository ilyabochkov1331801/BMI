//
//  BMI.swift
//  BMI
//
//  Created by Илья Бочков  on 4/10/20.
//  Copyright © 2020 Илья Бочков . All rights reserved.
//

import Foundation

enum BMIErrors: Error {
    case weightError
    case heightError
    case sexError
    var localizedDescription: String {
        switch self {
        case .weightError:
            return "Wrong weight"
        case .heightError:
            return "Wrong height"
        case .sexError:
            return "Wrong sex"
        }
    }
}
enum Sex {
    case man
    case woman
    case none
}

class BMI {
    
    var value: Double
    var idealWeight: Double?
    
    init(weight: String?, height: String?, isIdealWeightNeed: Bool, sex: Sex?) throws {
        guard let weight = weight, !weight.isEmpty, let weightValue = Double(weight) else {
            throw BMIErrors.weightError
        }
        guard let height = height, !height.isEmpty, let heightValue = Double(height) else {
            throw BMIErrors.heightError
        }
        value = weightValue / pow(heightValue / 100, 2)
        if isIdealWeightNeed {
            guard let sex = sex else {
                throw BMIErrors.sexError
            }
            switch sex {
            case .man:
                idealWeight = heightValue - 100 - (heightValue - 152) * 0.2
            case .woman:
                idealWeight = heightValue - 100 - (heightValue - 152) * 0.4
            case .none:
                throw BMIErrors.sexError
            }
        }
    }
}
