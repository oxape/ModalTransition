//
//  MaskPresentionViewController.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/27.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class MaskPresentionViewController: UIPresentationController {
    override func presentationTransitionWillBegin() {
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            }, completion:nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
                
            }, completion: nil)
    }
}
