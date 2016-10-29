//
//  MaskPresentedViewController.swift
//  ModalTransitionD1
//
//  Created by oxape on 2016/10/27.
//  Copyright © 2016年 oxape. All rights reserved.
//

import UIKit
import SnapKit

class PresentedViewController: UIViewController {
    
    //设置为true，显示image
    open var showImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.view.backgroundColor = UIColor.red
    }

    func setupUI() {
        
        if (showImage) {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "backgroundImage")
            self.view.addSubview(imageView)
            imageView.snp.makeConstraints { (ConstraintMaker) in
                ConstraintMaker.top.left.right.equalTo(self.view)
                ConstraintMaker.bottom.equalTo(self.view).offset(1)
            }
        }
        
        let helloLabel = UILabel()
        helloLabel.font = UIFont.systemFont(ofSize: 24)
        helloLabel.textColor = UIColor.black
        helloLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(helloLabel)
        helloLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.center.equalTo(self.view)
        }
        helloLabel.text = "Hello"
        
        let dismissButton = UIButton()
        dismissButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        dismissButton.setTitle("dismiss", for: UIControlState.normal)
        self.view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.equalTo(self.view).offset(-16)
            ConstraintMaker.centerX.equalTo(self.view)
        }
        dismissButton.addTarget(self, action: #selector(PresentedViewController.dismissAction), for: UIControlEvents.touchUpInside)
        
    }
    
    func dismissAction() {
        self.dismiss(animated: true) { 
            
        }
    }
}
