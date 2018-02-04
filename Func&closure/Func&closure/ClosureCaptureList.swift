//
//  ClosureCaptureList.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import UIKit

class ClosureCaptureList: NSObject {
    
    let fav = FinishAlertView_callback_class()
    let counter = PressCounter_callback_class()
    
    override init() {
        super.init()
    }
    
    func action() {
        fav.buttonPressed = { [weak counter] index in       // closure capture list: 闭包捕获列表：避免循环引用
            counter?.buttonPresseds(at: index)
        }
        
        let number = [1, 2, 3]
        number.map { number in number * 2 }
        
    }
    
    func calc(_ n: Int, _ by: ((Int) -> Int)?) -> Int {    // by是optional的，所以判定by是escape属性
        guard let by = by else { return n }
        
        return by(n)
    }

}
