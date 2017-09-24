//
//  ViewController.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2017/09/23.
//  Copyright © 2017年 luoxiaofeng. All rights reserved.
//

import UIKit

extension Array where Element: Comparable {
//    mutating func mergeSort(_ begin: Index, _ end: Index) {
//        if (end - begin) > 1 {
//            let mid = (begin + end) / 2
//            mergeSort(begin, mid)
//            mergeSort(mid, end)
//            merge(begin, mid, end)
//        }
//    }
//
//    private mutating func merge(_ begin: Index, _ mid: Index, _ end: Index) {
//        var tmp: [Element] = []
//        var i = begin
//        var j = mid
//        while i != j && j != end {
//            if self[i] < self[j] {
//                tmp.append(self[i])
//                i += 1
//            } else {
//                tmp.append(self[j])
//                j += 1
//            }
//        }
//        tmp.append(contentsOf: self[i..<mid])
//        tmp.append(contentsOf: self[mid..<end])
//
//        replaceSubrange(begin..<end, with: tmp)
//    }
    
    mutating func mergeSort(_ begin: Index, _ end: Index) {
        var tmp: [Element] = []
        tmp.reserveCapacity(count)
        
        func merge(_ begin: Index, _ mid: Index, _ end: Index) {    // local函数，捕获变量的用法  (性能，代码简洁性，可维护性)
            tmp.removeAll(keepingCapacity: true)    // 可以不用多次创建中间数组
            var i = begin
            var j = mid
            while i != j && j != end {
                if self[i] < self[j] {
                    tmp.append(self[i])
                    i += 1
                } else {
                    tmp.append(self[j])
                    j += 1
                }
            }
            tmp.append(contentsOf: self[i..<mid])
            tmp.append(contentsOf: self[mid..<end])
            
            replaceSubrange(begin..<end, with: tmp)
        }
        
        if (end - begin) > 1 {
            let mid = (begin + end) / 2
            mergeSort(begin, mid)
            mergeSort(mid, end)
            merge(begin, mid, end)
        }
    }
    
    func test() {
        var numbers = [1, 6, 9, 4, 5]
        numbers.mergeSort(numbers.startIndex, numbers.endIndex)
        print(numbers)
    }
    
}

class ViewController: UIViewController {
    
    // MARK:  func函数
    
    func ptMul(_ m: Int, ofN n: Int) {      // m,n: internal name(方法内部，外部使用)     ofM: external name（方法外部使用）
        print(m * n)
    }
    
    func  mpMt(_ m: Int, ofn n: Int = 6) {      // 参数默认值 *有默认值的参数必须放在没有默认值参数的右边（依次由右向左）
        print(m * n)
    }

    func multiMt(_ m: Int ...) {     // 不确定个数参数
        print(m.reduce(1, *))
    }
    
    func changeMt1(result: inout Int, _ num: Int ...) {     // 修改参数的值：用"inout"来修饰    → 一般用返回值来实现
        result = num.reduce(2, *)
        print(num.reduce(2, *))
    }
    
    func mul(m: Int, n: Int) -> Int {
        return m * n
    }
    func div(a: Int, b: Int) -> Int {
        return a / b
    }
    func cal<T>(_ first: T, _ second: T, _ fn: (T, T) -> T) -> T {      // 函数用作参数 返回值
        return fn(first, second)
    }
    
    func  mul(_ m: Int) -> (Int) -> Int {       // 返回值：(Int)->Int: 带有Int参数，返回值为Int 的函数
        func innerMul(_ n: Int) -> Int {        // 内嵌函数
            return m * n
        }
        return innerMul
    }
    
    // MARK: closure(闭包) VS closureExpression
    func square(n: Int) -> Int {
        return n * n
    }
    
    let squareExpression = { (n: Int) -> Int in     // closureExpression 其实就是函数的一种简写形式，不是closure
        return n * n
    }
    
    
    func makeCounter() -> () -> Int {       // closure   捕获变量value      // 写法1
        var value = 0
        return {
            value += 1
            return value
        }
    }
    
    func makeCounter2() -> () -> Int {      // 写法2  也可以用local function来捕获变量
        var value = 0
        func increment() -> Int {
            value += 1
            return value
        }
        return increment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: func
        self.funLe()
        
        // MARK: closure(闭包) & closureExpression
        self.closureLe()
        
        // MARK:
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func funLe() {
        ptMul(2, ofN: 3)    // 方法定义处用“_“ 表示忽略参数名
        mpMt(2)
        multiMt(2, 3, 4, 5)
        
        var mResult = 0
        changeMt1(result: &mResult, 3, 4, 5)
        print(mResult)
        
        _ = cal(2, 3, mul)
        _ = cal(4, 5, div)
        
        // 具有内嵌函数的mul的调用
        let mul2By = mul(3)
        _ = mul2By(2)       // 法１
        
        _ = mul(3)(2)       // 法２
    }

    func closureLe() {
        _ = squareExpression(3)
        
        let numbers = [1, 2, 3, 4, 5]
        // _ = numbers.map(squareExpression)
        _  = numbers.map( {(n: Int) -> Int in           // 写法1
            return n * n
            }
        )
        _ = numbers.map({ n in      // 可以根据numbers的类型来推测参数的类型       // 写法2
            n * n   //　只有一条语句时，这条语句可以直接座位closureExpression的返回值
        })
        _ = numbers.map({$0 * $0})      // $0, $1, $2...表示参数个数          // 写法3
        _ = numbers.map(){$0 * $0}      // 参数在参数列表中最后一个时，可以把最后一个放在括号外面      // 写法4
        _ = numbers.map{$0 * $0}        // 只有一个类型的参数时可把()去掉         // 写法15
        
        // 数组排序
        _ = numbers.sorted(by: { $0 > $1 }) // 写法1
        _ = numbers.sorted(by: >)       // 写法2
        
        
        // closureExpression 默认情况下不能忽略它的参数，如果不需要使用其参数，则用“_”来忽略
        _ = (0...9).map { _ in arc4random() }
        
        // closure = 函数 + 它捕获的变量
        let counter1 = makeCounter()
        let counter2 = makeCounter()
        print(counter1) // 1
        print(counter1) // 2
        print(counter1) // 3
        
        print(counter2) // 1
        print(counter2) // 2
        print(counter2) // 3
        print(counter2) // 4
        print(counter2) // 5
    }
   
    
    

}

