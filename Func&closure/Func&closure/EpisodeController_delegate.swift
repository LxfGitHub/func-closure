//
//  EpisodeController.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import UIKit

class EpisodeController: FinishAlertViewDelegate {
    
    var episodeAlert: FinishAlertView!
    var counter: PressCounter!
    
    init() {
        self.episodeAlert = FinishAlertView()
        self.counter = PressCounter()
        self.episodeAlert.delegate = self.counter
    }
    
    func buttonPressed(at Index: Int) {
        print("Go to the next episode... ")
    }
    
}
