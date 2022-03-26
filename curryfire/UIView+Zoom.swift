//
//  UIView+Zoom.swift
//  curryfire
//
//  Created by Devin Ross on 3/26/22.
//  Copyright © 2022 Devin Ross. All rights reserved.
//

import UIKit

extension UIView {
	
	/** Zoom view to point.
	 @param toYPoint The place to zoom to.
	 @param completion The completion callback handler.
	 */
	@objc public func zoomToYPoint(_ toYPoint: CGFloat, completion: ((Bool) -> Void)? ) {
		zoomToYPoint(toYPoint, duration: 0.7, delay: 0, completion: completion)
	}
	
	/** Zoom view to point.
	 @param toYPoint The place to zoom to.
	 @param duration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param completion The completion callback handler.
	 */
	@objc public func zoomToYPoint(_ toYPoint: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
		zoomToYPoint(toYPoint, anticipation: 30, duration: duration, delay: delay, completion: completion)
	}
	
	/** Zoom view to point.
	 @param toYPoint The place to zoom to.
	 @param anticipation How much of a windup the view moves before zooming off.
	 @param duration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param completion The completion callback handler.
	 */
	@objc public func zoomToYPoint(_ toYPoint: CGFloat, anticipation: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
		var antic = anticipation
		let baseTransform = self.transform
		if toYPoint > self.centerY {
			let yy: CGFloat = self.frame.minY
			self.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
			self.center = CGPoint(x: self.centerX, y: yy)
			antic *= -1
		}
		else {
			let yy: CGFloat = self.frame.maxY
			self.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
			self.center = CGPoint(x: self.centerX, y: yy)
		}
		let xScale: CGFloat = 1
		let yScale: CGFloat = 1
		UIView.animateKeyframes(withDuration: duration, delay: delay, options: .calculationModeCubic, animations: {() -> Void in
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {() -> Void in
				self.transform = CGConcat(baseTransform, CGScale(xScale + 0.1, yScale - 0.3))
			})
			UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {() -> Void in
				self.transform = CGScale(xScale - 0.3, yScale + 0.3)
			})
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {() -> Void in
				self.centerY += antic
			})
			UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6, animations: {() -> Void in
				self.center = CGPoint(x: self.centerX, y: toYPoint)
			})
			}, completion: {(finished: Bool) -> Void in
				self.transform = baseTransform
				let minY: CGFloat = self.minY + self.height / 2.0
				self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
				self.centerY = minY
				if (completion != nil) {
					completion!(finished)
				}
		})
	}
	
	/** Zoom view to point.
	@param toXPoint The place to zoom to.
	@param completion The completion callback handler.
	*/
	@objc public func zoomToXPoint(_ toXPoint: CGFloat, completion: ((Bool) -> Void)? ) {
		zoomToXPoint(toXPoint, duration: 0.7, delay: 0, completion: completion)
	}
	
	/** Zoom view to point.
	@param toXPoint The place to zoom to.
	@param duration The duration of the animation.
	@param delay The delay before the animation is played.
	@param completion The completion callback handler.
	*/
	@objc public func zoomToXPoint(_ toXPoint: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
		zoomToXPoint(toXPoint, anticipation: 30, duration: duration, delay: delay, completion: completion)
	}
	
	/** Zoom view to point.
	@param toXPoint The place to zoom to.
	@param anticipation How much of a windup the view moves before zooming off.
	@param duration The duration of the animation.
	@param delay The delay before the animation is played.
	@param completion The completion callback handler.
	*/
	@objc public func zoomToXPoint(_ toXPoint: CGFloat, anticipation: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
		var antic = anticipation

		let baseTransform = self.transform
		if toXPoint > self.centerX {
			let xx: CGFloat = self.frame.minX
			self.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
			self.center = CGPoint(x: xx, y: self.centerY)
			antic *= -1

		}
		else {
			let xx: CGFloat = self.frame.maxX
			self.layer.anchorPoint = CGPoint(x: 1, y: 1)
			self.center = CGPoint(x: xx, y: self.centerY)
		}
		let xScale: CGFloat = self.transform.a
		let yScale: CGFloat = self.transform.d
		UIView.animateKeyframes(withDuration: duration, delay: delay, options: .calculationModeCubic, animations: {() -> Void in
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {() -> Void in
				self.transform = CGScale(xScale - 0.3, yScale + 0.1)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {() -> Void in
				self.transform = CGScale(xScale + 0.3, yScale - 0.3)
			})
			
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {() -> Void in
				self.centerX += antic
			})
			
			UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6, animations: {() -> Void in
				self.center = CGPoint(x: toXPoint, y: self.centerY)
			})
			}, completion: {(finished: Bool) -> Void in
				self.transform = baseTransform
				let minX: CGFloat = self.minX + self.width / 2.0
				self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
				self.centerX = minX
				if (completion != nil) {
					completion!(finished)
				}
		})
	}
	
	
}
