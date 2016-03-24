//
//  ToViewController.swift
//  AnimatedTransitionDemo
//
//  Created by MieJie on 16/3/24.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class ToViewController : UIViewController {
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.redColor()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}