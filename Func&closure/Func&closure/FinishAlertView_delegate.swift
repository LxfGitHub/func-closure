//
//  FinishAlertView.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import Foundation

protocol FinishAlertViewDelegate {
    mutating func buttonPressed(at Index: Int)
}

class FinishAlertView_delegate {
    
    var buttons: [String] = ["Cancel", "The next"]
    var delegate: FinishAlertViewDelegate?
    
    func goToTheNext() {
        delegate?.buttonPressed(at: 1)
    }

}

struct PressCounter_delegate: FinishAlertViewDelegate {
    
    var count: Int = 0
    
    mutating func buttonPressed(at Index: Int) {
        count += 1
    }
    
}
