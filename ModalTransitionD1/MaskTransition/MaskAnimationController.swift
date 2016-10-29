//
//  MaskAnimationController.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/27.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class MaskAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
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
//        let fromView = fromVC.view
        let toView = toVC.view
        
        let duration = self.transitionDuration(using: transitionContext)
        //Presentation的处理
        if toVC.isBeingPresented {
            //必须要手动调用
            containerView.addSubview(toView!)
            //设置toView的frame
            let width = containerView.bounds.width
            let height = containerView.bounds.height
            toView?.frame = CGRect(x: 0, y: 0, width: width, height: height)
            toView?.center = containerView.center
            //设置containerView背景色为toView背景色
            containerView.backgroundColor = toView?.backgroundColor
            //Mask动画
            let shapeLayer = CAShapeLayer()
            containerView.layer.mask = shapeLayer
            let path0 = UIBezierPath()
            path0.addArc(withCenter: CGPoint(x:width, y:0), radius: 0, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            path0.close()
            let path1 = UIBezierPath()
            path1.addArc(withCenter: CGPoint(x:width, y:0), radius: sqrt(width*width + height*height), startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            path1.close()
            let animation = CAKeyframeAnimation(keyPath: "path")
            animation.duration = duration
            animation.repeatCount = 1
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            animation.values = [path0.cgPath, path1.cgPath]
            shapeLayer.add(animation, forKey: "path")
            shapeLayer.path = path1.cgPath
            
            UIView.animate(withDuration: duration, animations: {
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
            //Mask动画
            let shapeLayer = CAShapeLayer()
            containerView.layer.mask = shapeLayer
            let path0 = UIBezierPath()
            path0.addArc(withCenter: CGPoint(x:width, y:0), radius: sqrt(width*width + height*height), startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            path0.close()
            let path1 = UIBezierPath()
            path1.addArc(withCenter: CGPoint(x:width, y:0), radius: 0, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            path1.close()
            let animation = CAKeyframeAnimation(keyPath: "path")
            animation.duration = duration
            animation.repeatCount = 1
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            animation.values = [path0.cgPath, path1.cgPath]
            shapeLayer.add(animation, forKey: "path")
            shapeLayer.path = path1.cgPath
            //如果UIView.animate中没有动画会造成一闪而过,理解是CAKeyframeAnimation对animateTransition来说不算过度
            containerView.backgroundColor = UIColor.white
            UIView.animate(withDuration: duration, animations: {
                containerView.backgroundColor = UIColor.clear
                //直接写如下语句也会造成一闪而过
                //containerView.backgroundColor = UIColor.white
                }, completion: { (Bool) in
                    let isCancelled = transitionContext.transitionWasCancelled
                    transitionContext.completeTransition(!isCancelled)
            })
        }
    }
}
