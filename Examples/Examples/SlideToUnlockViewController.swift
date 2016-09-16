//
//  SlideToUnlockViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/15/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit
import curryfire

class SlideToUnlockViewController: UIViewController {

	
	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		self.view.addSubview(self.unlockView)
		self.title = "Slide to Unlock"

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.unlockView.setNeedsLayout()
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Disable", style: .plain, target: self, action: #selector(switchMode))
	}
	
	
	func didUnlockView(sender: TKSlideToUnlockView){
		
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			self.unlockView.resetSlider(false)
		}
		
	}
	
	func switchMode(sender: Any){
		self.unlockView.mode = self.unlockView.mode == .normal ? .disabled : .normal
	}

	
	lazy var unlockView: TKSlideToUnlockView = {
		let w  : CGFloat = self.view.frame.width
		let width : CGFloat = 300.0

		var unlockView = TKSlideToUnlockView(frame: CGRect(x: (w-width) / 2, y: 330, width: width, height: 40))
		unlockView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
		unlockView.addTarget(self, action: #selector(didUnlockView), for: .valueChanged)
		return unlockView
	}()

}
