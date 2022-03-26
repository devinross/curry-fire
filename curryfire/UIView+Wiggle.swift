//
//  UIView+Wiggle.swift
//  curryfire
//
//  Created by Devin Ross on 3/26/22.
//  Copyright © 2022 Devin Ross. All rights reserved.
//

import UIKit

extension UIView {
	
	/// Wiggle the view.
	@objc public func wiggle() {
		self.wiggle(0.06)
	}
	
	/** Wiggle the view.
	 @param withRotationAngle The range the view wiggle.
	 */
	@objc public func wiggle(_ withRotationAngle: CGFloat) {
		self.wiggle(0.5, delay: 0, rotation: withRotationAngle)
	}
	
	/** Wiggle the view.
	 @param withDuration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param angle The range the view wiggle.
	 */
	@objc public func wiggle(_ withDuration: TimeInterval, delay: TimeInterval, rotation angle: CGFloat) {
		self.wiggle(withDuration, delay: delay, betweenAngleOne: angle, angleTwo: -angle)
	}
	
	/** Wiggle the view.
	@param withDuration The duration of the animation.
	@param delay The delay before the animation is played.
	@param angleOne The range the view wiggle.
	@param angleTwo The range the view wiggle.
	*/
	@objc public func wiggle(_ withDuration: TimeInterval, delay: TimeInterval, betweenAngleOne angleOne: CGFloat, angleTwo: CGFloat) {
		let transform = self.transform
		let currentAngle : CGFloat = atan2(transform.b, transform.a)
		var second = CATransform3DMakeRotation(angleTwo, 0, 0, 1.0)
		var secondBeginTime: CFTimeInterval
		if angleOne == currentAngle || angleTwo == currentAngle {
			if angleTwo == currentAngle {
				second = CATransform3DMakeRotation(angleOne, 0, 0, 1.0)
			}
			secondBeginTime = CACurrentMediaTime() + delay
		} else {
			let first = CATransform3DMakeRotation(angleOne, 0, 0, 1.0)
			let animation = CABasicAnimation(keyPath: "transform")
			animation.fromValue = self.layer.transform
			animation.toValue = first
			animation.duration = withDuration / 2.0
			animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
			animation.isRemovedOnCompletion = false
			animation.beginTime = CACurrentMediaTime() + delay
			animation.fillMode = .forwards
			self.add(animation)
			secondBeginTime = CACurrentMediaTime() + withDuration / 2.0 + delay
		}
		let animation = CABasicAnimation(keyPath: "transform")
		// Create a basic animation to animate the layer's transform
		animation.toValue = NSValue(caTransform3D: second)// second NSCATransform3D(second)
		// Assign the transform as the animation's value
		animation.autoreverses = true
		animation.duration = withDuration
		animation.repeatCount = .infinity
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		animation.beginTime = secondBeginTime
		animation.isRemovedOnCompletion = false
		animation.fillMode = CAMediaTimingFillMode.forwards
		self.add(animation)
	}
	
}
