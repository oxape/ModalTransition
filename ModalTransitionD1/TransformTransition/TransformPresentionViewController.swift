//
//  TransformPresentionViewController.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/28.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class TransformPresentionViewController: UIPresentationController {
    let dimmingView = UIView()
    
    override func presentationTransitionWillBegin() {
        containerView?.addSubview(dimmingView)
        let width = (containerView?.bounds.width)!
        let height = (containerView?.bounds.height)!
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: width/2, y: -height/2)
        transform = transform.scaledBy(x: 0.01, y: 0.01)
        
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        dimmingView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        dimmingView.transform = transform
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.transform = CGAffineTransform.identity
            }, completion:{ _ in
        })
    }
    
    override func dismissalTransitionWillBegin() {
        let width = containerView?.bounds.width
        let height = containerView?.bounds.height
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: width!/2, y: -height!/2)
        transform = transform.scaledBy(x: 0.01, y: 0.01)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.transform = transform
            }, completion:nil)
    }
}
