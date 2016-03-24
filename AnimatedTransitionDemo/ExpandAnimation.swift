//
//  ExpandAnimation.swift
//  AnimatedTransitionDemo
//
//  Created by MieJie on 16/3/24.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class  ExpandAnimation : NSObject , UIViewControllerAnimatedTransitioning {
    
    var transitionContext : UIViewControllerContextTransitioning!
    
    var type : UINavigationControllerOperation!
    
    var sender : UIView?
    
    convenience init(type : UINavigationControllerOperation) {
        self.init()
        self.type = type
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        print("animateTransition")
        if type == UINavigationControllerOperation.Push {
            self.PushTransition(transitionContext)
        }else {
            self.PopTranstion(transitionContext)
        }
    }
    
    func animationEnded(transitionCompleted: Bool) {
        print("animation ended ")
    }
    
    func PushTransition(transitionContext: UIViewControllerContextTransitioning ) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        let containerView = transitionContext.containerView()
        let view = toVC.view!
        containerView!.addSubview(toVC.view)
        //小圆路径
        let s_maskPath = UIBezierPath(ovalInRect:(sender?.frame)!)
        //大圆路径
        let l_center =  (sender?.center)!
        var l_radius:CGFloat
        if(sender!.frame.origin.x > (toVC.view.bounds.size.width / 2)){
            if (sender!.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
                //右上角
                l_radius = sqrt( pow(0 - l_center.x, 2) + pow(CGRectGetMaxY(view.frame) - l_center.y, 2) )
            }else{
                //右下角
                l_radius = sqrt( pow(0 - l_center.x, 2) + pow(0 - l_center.y, 2) )
            }
        }else{
            if (sender!.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
                //左上角
                l_radius = sqrt( pow(CGRectGetMaxX(view.frame) - l_center.x, 2) + pow(CGRectGetMaxY(view.frame) - l_center.y, 2) )
            }else{
                //左下角
                l_radius = sqrt( pow(CGRectGetMaxX(view.frame) - l_center.x, 2) + pow(0 - l_center.y, 2) )
            }
        }
        l_radius += 50 //稍微增加一些位置
        let l_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: l_center.x, y: l_center.y, width: 1, height: 1), -l_radius, -l_radius))
        //遮罩层
        let mask = CAShapeLayer()
        mask.path = l_maskPath.CGPath
        view.layer.mask = mask
        ////错误用法，animationWithDuration不能通过操作layer产生动画
        //UIView.animateWithDuration(5) { () -> Void in
        //     mask.path = b_maskPath.CGPath
        //}
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = transitionDuration(transitionContext)
        baseAnimation.fromValue = s_maskPath.CGPath
        baseAnimation.toValue = l_maskPath.CGPath
        baseAnimation.delegate = self
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        mask.addAnimation(baseAnimation, forKey: "path")
    }
    
    func PopTranstion(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        let view = toVC.view!
        containerView!.addSubview(toVC.view)
        containerView!.addSubview(fromVC.view)
        //遮罩层
        let mask = CAShapeLayer()
        fromVC.view.layer.mask = mask
        //画出小圆
        let s_center = CGPoint(x: 50, y: 50)
        let s_radius:CGFloat =  sqrt(800)
        let s_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: s_center.x, y: s_center.y, width: 1, height: 1), -s_radius, -s_radius))
        //	mask.path = s_maskPath.CGPath
        //画出大圆
        let l_center = CGPoint(x: 50, y: 50)
        let l_radius = sqrt( pow(view.bounds.width - l_center.x, 2) + pow(view.bounds.height - l_center.y, 2) ) + 150
        let l_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: l_center.x, y: l_center.y, width: 1, height: 1), -l_radius, -l_radius))
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = transitionDuration(transitionContext)
        baseAnimation.fromValue = l_maskPath.CGPath
        baseAnimation.toValue = s_maskPath.CGPath
        baseAnimation.delegate = self
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        mask.addAnimation(baseAnimation, forKey: "path")
    }
    
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext.completeTransition(true)
        //动画完成后去处遮罩
        self.transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
        self.transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
    }
}
