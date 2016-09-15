//
//  TKLoadingView.swift
//  curryfire
//
//  Created by Devin Ross on 9/15/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit

public class TKLoadingView: UIView {


	
	var loadingLabel : UILabel
	var animating : Bool
	
	override public init(frame : CGRect){
		
		loadingLabel = UILabel(frame: CGRect.zero)
		animating = false
		
		super.init(frame: frame)

		loadingLabel.backgroundColor = UIColor.clear
		loadingLabel.text = "\(NSLocalizedString("Loading", comment: "Loading"))..."
		loadingLabel.font = UIFont.boldSystemFont(ofSize: 16)
		loadingLabel.sizeToFit()
		loadingLabel.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
		loadingLabel.frame = loadingLabel.frame.integral
		loadingLabel.alpha = 0
		self.addSubview(loadingLabel)

	}
	
	required public init(coder aDecoder: NSCoder) {
		fatalError("This class does not support NSCoding")
	}
	
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		let str = "\(NSLocalizedString("Loading", comment: "Loading"))..." as NSString
		let size = str.size(attributes: [NSFontAttributeName : self.loadingLabel.font])
		let width = self.frame.size.width, height = self.frame.size.height
		let x = (width - size.width) / 2.0, y = (height - size.height) / 2.0
		let frame = CGRect(x: x, y: y, width: size.width, height: size.height)
		self.loadingLabel.frame = frame
		
	}
	
	public func startAnimating(){
		
		self.loadingLabel.alpha = 1
		self.loadingLabel.text = "\(NSLocalizedString("Loading", comment: "Loading"))..."
		self.animating = true


		if(self.window == nil){
			return
		}

		self.perform(#selector(animateLabel), with: nil, afterDelay: 0.25)
		
	}
	
	public func stopAnimating(){
		self.loadingLabel.alpha = 0
		self.animating = false
		NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(animateLabel), object: nil)
	}
	
	func animateLabel(){
		
				
		if(self.loadingLabel.superview == nil || !self.animating){
			return
		}
		
		var str = self.loadingLabel.text! as NSString
		if str.hasSuffix("..."){
			str = NSLocalizedString("Loading", comment: "Loading") as NSString
		}else{
			str = "\(str)." as NSString
		}
		self.loadingLabel.text = str as String
		
		NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(animateLabel), object: nil)
		self.perform(#selector(animateLabel), with: nil, afterDelay: 0.25)

		
		

		
	}
	
	override public func didMoveToWindow() {

		if self.animating {
			NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(animateLabel), object: nil)
			self.perform(#selector(animateLabel), with: nil, afterDelay: 0.25)
		}
		
	}
	

	

}
