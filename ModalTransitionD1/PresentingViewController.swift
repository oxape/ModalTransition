//
//  ViewController.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/26.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit

class PresentingViewController: UIViewController {
    //三种转场
//    let presentTransitionDelegate = MixTransitionDelegate()
    let presentTransitionDelegate = MaskTransitionDelegate()
//    let presentTransitionDelegate = TransformTransitionDelegate()
    
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        //测试Mask效果用
//        self.maskAnimation()
    }
    
    func setupUI() {
        let presentButton = UIButton()
        presentButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        presentButton.setTitle("present", for: UIControlState.normal)
        self.view.addSubview(presentButton)
        presentButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(self.view).offset(16+22)
            ConstraintMaker.right.equalTo(self.view).offset(-16)
        }
        textField.backgroundColor = UIColor.lightGray;
        textField.placeholder = "测试Modal覆盖keywindow"
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.center.equalTo(self.view)
            ConstraintMaker.height.equalTo(32)
        }
        
        presentButton.addTarget(self, action: #selector(PresentingViewController.presentMaskViewController), for: UIControlEvents.touchUpInside)
    }
    
    func presentMaskViewController() {
        let presendViewController = PresentedViewController()
        presendViewController.transitioningDelegate = presentTransitionDelegate
        presendViewController.modalPresentationStyle = .custom
        self.present(presendViewController, animated: true, completion: nil)
    }
    
    //测试Mask效果用
    func maskAnimation() {
        let shapeLayer = CAShapeLayer()
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        self.view.layer.addSublayer(shapeLayer)
        let path0 = UIBezierPath()
        path0.move(to: CGPoint(x:width, y:height/2))
        path0.addArc(withCenter: CGPoint(x:width/2, y:height/2), radius: 0, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path0.close()
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x:width, y:height/2))
        path1.addArc(withCenter: CGPoint(x:width/2, y:height/2), radius: width, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path1.close()

        let animation = CAKeyframeAnimation(keyPath: "path")
        animation.duration = 3.0
        animation.repeatCount = 100
        animation.values = [path0.cgPath, path1.cgPath, path0.cgPath]
        shapeLayer.add(animation, forKey: "path")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textField.resignFirstResponder()
    }
    
}

