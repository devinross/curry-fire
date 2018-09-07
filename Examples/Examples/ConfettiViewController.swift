//
//  ConfettiViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/15/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit

class ConfettiViewController: UIViewController {

	
	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		self.title = "Confetti"
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.setupConfetti(withDelay: 0)
	}
	
	func setupConfetti(withDelay: TimeInterval) {
		
		let block = UIView(frame: CGRectCenteredInRect(self.view.bounds, 100, 100), backgroundColor: UIColor.random() )
		block.transform = CGConcat(CGScale(0.001, 0.001), CGRotate(CGFloat.pi / 180.0 * 45))
		block.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
		self.view.addSubview(block)



		
		UIView.animate(withDuration: 1, delay: withDelay, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: [], animations: {
			block.transform = CGAffineTransform.identity
		}, completion: { (finished) in
			
				block.addTapGesture { sender in
					self.view.bringSubviewToFront(block)
					block.confettiAnimation(completion: { (finished) in
						self.setupConfetti(withDelay: 1.0)
					})
				}
		})
	}

}
