//
//  ViewController.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2017/09/23.
//  Copyright © 2017年 luoxiaofeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*---1 delegate, struct---*/
    var epController = EpisodeController_delegate.init()
    
    /*---2 callback, struct---*/
    var fav = FinishAlertView_callback_struct()
    var counter = PressCounter_callback_struct()
    
    /*---3 callback, class---*/
    var fav_class = FinishAlertView_callback_class()
    var counter_class = PressCounter_callback_class()
    
    // function parameter inout
    var fpio = FunctionParameter_inout()
    
    // autoClosure
    var autoCl = ForAutoClosure.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gotoAction()
        
        fpio.action()
        
//      let result = autoCl.logicAnd(!autoCl.numb.isEmpty, autoCl.numb[0] > 0)      // error
        let result2 = autoCl.logicAnd2(!autoCl.numb.isEmpty, { autoCl.numb[0] > 0 })
        print("result2 = \(result2)")
        
        let result3 = autoCl.logicAnd3(!autoCl.numb.isEmpty, autoCl.numb[0] > 0)
        print("result3 = \(result3)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoAction() {
        
        /*---1 delegate, struct---*/
        epController.episodeAlert.goToTheNext()
        epController.episodeAlert.goToTheNext()
        epController.episodeAlert.goToTheNext()
        epController.episodeAlert.goToTheNext()
        epController.episodeAlert.goToTheNext()
        print("count = \(epController.counter.count)")
        print("epVC count = \((epController.episodeAlert.delegate as! PressCounter_delegate).count)")
        
        /*---2 callback, struct---*/
        fav.buttonPressed = { self.counter.buttonPresseds(at: $0) }
        fav.goToTheNext()
        fav.goToTheNext()
        fav.goToTheNext()
        fav.goToTheNext()
        fav.goToTheNext()
        print("callback count = \(counter.count)")
        
        fav.buttonPressed = { _ in print("OK, go to the next episode") }
        fav.goToTheNext()
        fav.goToTheNext()
        fav.goToTheNext()
        fav.goToTheNext()
        fav.goToTheNext()
        
        /*---3 callback, class---*/
        fav_class.buttonPressed = { [weak counter_class] in
            counter_class?.buttonPresseds(at: $0)
        }
        fav_class.goToTheNext()
        fav_class.goToTheNext()
        fav_class.goToTheNext()
        fav_class.goToTheNext()
        fav_class.goToTheNext()
        print("callback class count = \(counter_class.count)")
    }
    
}


