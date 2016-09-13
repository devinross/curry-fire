//
//  BounceAnimatorViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/13/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit

class BounceAnimatorViewController: UIViewController {

    override func loadView() {
        super.loadView()
		self.view.backgroundColor = UIColor.white
		
		let block = UIView(frame: CGRectCenteredInRect(self.view.bounds, 100, 100), backgroundColor: UIColor.random(), cornerRadius: 10)
		block.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
		block.layer.shouldRasterize = true
		block.layer.rasterizationScale = UIScreen.main.scale
		self.view.addSubview(block)
		
		let bounce = TKBounceBehavior(items: [block])
		bounce?.bounceDirection = CGVector(dx: 3, dy: 0)
		
		let animator = UIDynamicAnimator(referenceView: self.view)
		animator.addBehavior(bounce!)
		
		self.view .addTapGesture { (sender) in
			bounce?.bounce()
		}
		
		

    }


	

}
