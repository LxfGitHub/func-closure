//
//  FinishAlertView_callback_class.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import UIKit

class FinishAlertView_callback_class: NSObject {
    
    var buttons: [String] = ["Cancel", "The next"]
    var buttonPressed: ((Int) -> Void)?
    
    func goToTheNext() {
        buttonPressed?(1)
    }
        
}

class PressCounter_callback_class {
    
    var count: Int = 0
    
    func buttonPresseds(at Index: Int) {
        count += 1
    }
    
}
