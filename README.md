# AnimatedTransitionDemo

##UIViewController的自定义过渡效果和过渡交互
###过渡效果
####UIViewControllerAnimatedTransitioning 
示例：自定义的动画类
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
    
        func animationEnded(transitionCompleted: Bool) {
        print("end")
    }
}

###过渡交互

####方式一 push 和 pop 协议 UINavigationControllerDelegate

ExpandAnimation自定义动画类继承自 NSObject 实现协议 UIViewControllerAnimatedTransitioning


extension ViewController : UINavigationControllerDelegate {

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transitioningAnimation = ExpandAnimation(type: operation)
        return transitioningAnimation
    }
}

####方式二 presented和dismiss 协议 UIViewControllerTransitioningDelegate

PresentedAnimation，DismissAnimation  自定义动画类继承自 NSObject 实现协议 UIViewControllerAnimatedTransitioning


extension ViewController : UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentedAnimation()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return DismissAnimation()
    }
}
