//
//  PresentedAnimation.swift
//  AnimatedTransitionDemo
//
//  Created by MieJie on 16/3/24.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class PresentedAnimation : NSObject , UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC  = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC    = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let finalFrameForVC = transitionContext.finalFrameForViewController(toVC)
        let containerView = transitionContext.containerView()
        let bounds = UIScreen.mainScreen().bounds
        
        toVC.view.frame = CGRectOffset(finalFrameForVC, bounds.size.width, 0)
        containerView?.addSubview(toVC.view)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 20, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                fromVC.view.alpha = 0.5
                fromVC.view.transform = CGAffineTransformMakeScale(0.95, 0.95)
                toVC.view.frame = finalFrameForVC
            }) { (_) -> Void in
                transitionContext.completeTransition(true)
                fromVC.view.alpha = 1.0
        }
        print("animateTransition")
    }
}
