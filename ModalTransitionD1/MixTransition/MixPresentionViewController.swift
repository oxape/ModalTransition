//
//  MixPresentionViewController.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/28.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class MixPresentionViewController: UIPresentationController {
    let dimmingView = UIView()
    
    override func presentationTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            
            }, completion:{ _ in
        })
    }
    
    override func dismissalTransitionWillBegin() {
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            
            }, completion:nil)
    }
}
