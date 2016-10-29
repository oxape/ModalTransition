//
//  MixAnimationController.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/28.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class MixAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
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
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.values = [path0.cgPath, path1.cgPath]
            shapeLayer.add(animation, forKey: "path")
            shapeLayer.path = path1.cgPath
            
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: width/2, y: -height/2)
            transform = transform.scaledBy(x: 0.1, y: 0.1)
            //from的另外一种transform动画方案如下，感觉效果没有上面一种好
//            var transform = CGAffineTransform.identity
//            transform = transform.scaledBy(x: 0.1, y: 0.1)
            //设置锚点为右上角
//            fromView?.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
//            fromView?.layer.position = CGPoint(x:(fromView?.center.x)!+(fromView?.bounds.size.width)!/2, y: (fromView?.center.y)!-(fromView?.bounds.size.height)!/2)
            
            UIView.animate(withDuration: duration, animations: {
                    fromView?.transform = transform
                }, completion: { (Bool) in
                    let isCancelled = transitionContext.transitionWasCancelled
                    transitionContext.completeTransition(!isCancelled)
            })
        }
    }
}
