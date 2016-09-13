//
//  UIView+TwelvePrinciples.swift
//  curryfire
//
//  Created by Devin Ross on 9/13/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit


extension UIView {
	
	
	/// Tickle the view. 
	public func tickle(){
		tickle(duration: 1, delay: 0, downScale: 1, completion: nil)
	}
	
	/** Tickle the view.
		@param completion The completion callback handler.
	*/
	public func tickle(completion: ((Bool) -> ())? ){
		tickle(duration: 1, delay: 0, downScale: 1, completion: completion)
	}
	
	
	/** Tickle the view.
		@param duration The duration of the animation.
		@param downScale Downscale.
		@param delay The delay before the animation is played.
		@param completion The completion callback handler.
	 */
	public func tickle(duration: TimeInterval, delay: TimeInterval, downScale: CGFloat, completion: ((Bool) -> ())? ){
		
		let baseTransform = self.transform;
		let x = downScale
		
		UIView.animateKeyframes(withDuration: duration, delay: delay, options: .calculationModeCubic , animations: {
			
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
				self.transform = CGConcat(baseTransform, CGScale(x, x))
			})
			
			UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2, animations: {
				self.transform = CGConcat(baseTransform, CGScale(x+0.05, x-0.05))
			})
			UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2, animations: {
				self.transform = CGConcat(baseTransform, CGScale(x-0.05, x+0.05))
			})
			UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2, animations: {
				self.transform = CGConcat(baseTransform, CGScale(x+0.05, x-0.05))
			})
			
			UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.2, animations: {
				self.transform = baseTransform
			})
			
			UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1, animations: {
				self.transform = baseTransform
			})
			
			
		},completion: { (finished) in
			
			if let complete = completion{
				complete(finished)
			}
		
		});
		

		
	}
	

	
}
