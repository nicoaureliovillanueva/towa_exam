//
//  BaseViewController.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/9/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        hideKeyboardWhenTappedAround()
    }
   

    func setBackgroundColor() {
        self.view.backgroundColor = R.color.main_background()
    }
}
