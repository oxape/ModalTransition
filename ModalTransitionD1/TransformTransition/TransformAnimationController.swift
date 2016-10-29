//
//  TransformAnimationController.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/28.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class TransformAnimationController: NSObject,UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        let fromView = fromVC.view
        let toView = toVC.view
        
        let duration = self.transitionDuration(using: transitionContext)
        //Presentation的处理
        if toVC.isBeingPresented {
            //必须要手动调用
            containerView.addSubview(toView!)
            
            let width = containerView.bounds.width
            let height = containerView.bounds.height
            toView?.frame = CGRect(x: 0, y: 0, width: width*2/3, height: height*2/3)
            toView?.center = containerView.center
            
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: width/2, y: -height/2)
            transform = transform.scaledBy(x: 0.01, y: 0.01)
            
            toView?.transform = transform
            
            UIView.animate(withDuration: duration, animations: {
                toView?.transform = CGAffineTransform.identity
                }, completion: { (Bool) in
                    let isCancelled = transitionContext.transitionWasCancelled
                    if (!isCancelled) {
                        //Do Some Thing After transition finish
                    }
                    transitionContext.completeTransition(!isCancelled)
                    
            })
        }
        //dismiss的处理
        if fromVC.isBeingDismissed {
            //这里不能调用下面语句 toView就是先前的presentingView已经在containerView中了
            //            containerView.addSubview(toView!)
            //            fromView!.layer.anchorPoint = CGPoint(x:1, y:0)
            let width = containerView.bounds.width
            let height = containerView.bounds.height
            
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: width/2, y: -height/2)
            transform = transform.scaledBy(x: 0.01, y: 0.01)
            UIView.animate(withDuration: duration, animations: {
                fromView?.transform = transform
                }, completion: { (Bool) in
                    let isCancelled = transitionContext.transitionWasCancelled
                    transitionContext.completeTransition(!isCancelled)
                    
            })
        }
    }
}
