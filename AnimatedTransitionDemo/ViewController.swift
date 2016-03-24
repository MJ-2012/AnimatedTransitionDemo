//
//  ViewController.swift
//  AnimatedTransitionDemo
//
//  Created by MieJie on 16/3/23.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width

class ViewController: UIViewController {

    var transitioningSender : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.setup()
    }
    
    func setup() {
        
        self.title = "转场动画"
        
        let btn0 = UIButton(frame: CGRectMake(0,200,SCREEN_WIDTH,30))
        btn0.titleLabel?.textAlignment = .Center
        btn0.setTitle("push:UINavigationControllerDelegate", forState: .Normal)
        btn0.addTarget(self, action: "clickHandle:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn0)
        
        let btn1 = UIButton(frame: CGRectMake(0,400,SCREEN_WIDTH,30))
        btn1.titleLabel?.textAlignment = .Center
        btn1.setTitle("model:UIViewControllerTransitioningDelegate", forState: .Normal)
        btn1.addTarget(self, action: "clickHandle2:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn1)
    }
    
    func clickHandle(sender:UIButton) {
        
        let toVC = ToViewController()
        self.navigationController?.delegate = self
        transitioningSender = sender
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    func clickHandle2(sender:UIButton) {
        
        let toVC = ToViewController()
        toVC.transitioningDelegate = self
        self.navigationController?.presentViewController(toVC, animated: true, completion: nil)
    }
}

extension ViewController : UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentedAnimation()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return DismissAnimation()
    }
}

extension ViewController : UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transitioningAnimation = ExpandAnimation(type: operation)
        transitioningAnimation.sender = transitioningSender
        return transitioningAnimation
    }
}

