//
//  ModalTransitionDelegate.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/27.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class MaskTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MaskAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MaskAnimationController()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MaskPresentionViewController(presentedViewController: presented, presenting: source)
    }
}
