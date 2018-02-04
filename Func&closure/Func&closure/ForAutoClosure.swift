//
//  ForAutoClosure.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import UIKit

class ForAutoClosure: NSObject {
    
    override init() {
        super.init()
    }
    
    let numbers = [1, 2, 3]

    func judge() {
        if !numbers.isEmpty && numbers[0] > 0 {
            print("ok")
        }
        
    }
    
    let numb: [Int] = []
    
    func logicAnd(_ l: Bool, _ r: Bool) -> Bool {
        guard l else { return false }
        
        return r
    }
    
    func logicAnd2(_ l: Bool, _ r: () -> Bool) -> Bool {
        guard l else { return false }
        
        return r()
    }
    
    func logicAnd3(_ l: Bool, _ r: @autoclosure () -> Bool) -> Bool {
        guard l else { return false }
        
        return r()
    }
    
}
