//
//  CLLocationDistance+Extension.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/9/22.
//

import Foundation
import CoreLocation

extension CLLocationDistance {
    func inMiles() -> CLLocationDistance {
        return self*0.00062137
    }

    func inKilometers() -> CLLocationDistance {
        return self/1000
    }
}
