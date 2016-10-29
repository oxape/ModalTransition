//
//  TransformTransitionDelegate.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/28.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class TransformTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransformAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransformAnimationController()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return TransformPresentionViewController(presentedViewController: presented, presenting: source)
    }
}
