//
//  MixTransitionDelegate.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/28.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class MixTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MixAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MixAnimationController()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MixPresentionViewController(presentedViewController: presented, presenting: source)
    }
}
