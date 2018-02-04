//
//  FunctionParameter_inout.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import Foundation

class FunctionParameter_inout: NSObject {
    
    override init() {
        super.init()
    }
    
    func incremental(_ i: inout Int) {
        return i += 1
    }
    
    struct Color {
        var r: Int
        var g: Int
        var b: Int
        
        var hex: Int {
            return r << 16 + g << 8 + b
        }
    }
    
    func patterns () {
        var i = 0
        self.incremental(&i)
        var numbers = [1, 2, 3]
        self.incremental(&numbers[0])
        
        var red = Color(r: 254, g: 0, b: 0)
        incremental(&red.r)
//        incremental(&red.hex)
    }
    
//    prefix func ++(p: inout Int) -> Int {
//        p += 1
//        return p
//    }

    func doubleIncrement(_ i: inout Int) {
        
        func increment() {
            i += 1
        }
        
        increment()
        increment()
    }
    
    // ※最好不要让接受指针参数的函数返回另外一个函数
    func incrementByReference(_ pointer: UnsafeMutablePointer<Int>) -> () -> Int {
        return { pointer.pointee += 1; return pointer.pointee }
    }
    
    func action() {
        
        var i: Int = 0
        print("doubleIncrement = \(self.doubleIncrement(&i))")
        var p: Int = 0
        print("referenceIncrement = \(self.incrementByReference(&p))")
        
        var boom: () -> Int = { 1 }     // 是个不接受参数返回Int的函数变量
        
        if true {
            var j = [0]
            boom = incrementByReference(&j[0])
        }
        
        print("boom = \(boom())")
        
    }
    
    
}
