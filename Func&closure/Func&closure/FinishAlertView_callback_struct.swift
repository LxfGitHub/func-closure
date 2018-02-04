//
//  FinishAlertView_callback.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import UIKit

class FinishAlertView_callback: NSObject {
    
    var buttons: [String] = ["Cancel", "The next"]
    var buttonPressed:((Int) -> Void)?
    
    func goToTheNext() {
        buttonPressed?(1)
    }
    
}

struct PressCounter_callback {
    
    var count: Int = 0
    
    mutating func buttonPresseds(at Index: Int) { // 方法的结构要和回调的((Int) -> Void)?一致
        count += 1
    }
    
}
