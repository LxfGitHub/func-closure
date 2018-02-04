//
//  EpisodeController.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import UIKit

class EpisodeController_delegate: FinishAlertViewDelegate {
    
    var episodeAlert: FinishAlertView_delegate!
    var counter: PressCounter_delegate!
    
    init() {
        self.episodeAlert = FinishAlertView_delegate()
        self.counter = PressCounter_delegate()
        self.episodeAlert.delegate = self.counter
    }
    
    func buttonPressed(at Index: Int) {
        print("Go to the next episode... ")
    }
    
}
