//
//  DismissAnimation.swift
//  AnimatedTransitionDemo
//
//  Created by MieJie on 16/3/24.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class DismissAnimation : NSObject , UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let screenBounds = UIScreen.mainScreen().bounds
        let initFrame = transitionContext.initialFrameForViewController(fromVC)
        let finalFrame = CGRectOffset(initFrame, screenBounds.size.width, 0)
        let containerView = transitionContext.containerView()
        containerView?.addSubview(toVC.view)
        containerView?.sendSubviewToBack(toVC.view)
        
        let duration : NSTimeInterval = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            fromVC.view.frame = finalFrame
            toVC.view.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
