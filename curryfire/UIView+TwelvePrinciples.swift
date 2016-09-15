//
//  UIView+TwelvePrinciples.swift
//  Created by Devin Ross on 9/13/16.
//
/*

curryfire || https://github.com/devinross/curry-fire

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

*/

import UIKit


extension UIView {
	
	/** Zoom view to point.
	 @param toYPoint The place to zoom to.
	 @param completion The completion callback handler.
	 */
	public func zoomToYPoint(toYPoint: CGFloat, completion: ((Bool) -> Void)? ) {
		zoomToYPoint(toYPoint: toYPoint, duration: 0.7, delay: 0, completion: completion)
	}
	
	/** Zoom view to point.
	 @param toYPoint The place to zoom to.
	 @param duration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param completion The completion callback handler.
	 */
	public func zoomToYPoint(toYPoint: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
		zoomToYPoint(toYPoint: toYPoint, anticipation: 30, duration: duration, delay: delay, completion: completion)
	}
	
	/** Zoom view to point.
	 @param toYPoint The place to zoom to.
	 @param anticipation How much of a windup the view moves before zooming off.
	 @param duration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param completion The completion callback handler.
	 */
	public func zoomToYPoint(toYPoint: CGFloat, anticipation: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
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
	public func zoomToXPoint(toXPoint: CGFloat, completion: ((Bool) -> Void)? ) {
		zoomToXPoint(toXPoint: toXPoint, duration: 0.7, delay: 0, completion: completion)
	}
	
	/** Zoom view to point.
	@param toXPoint The place to zoom to.
	@param duration The duration of the animation.
	@param delay The delay before the animation is played.
	@param completion The completion callback handler.
	*/
	public func zoomToXPoint(toXPoint: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
		zoomToXPoint(toXPoint: toXPoint, anticipation: 30, duration: duration, delay: delay, completion: completion)
	}
	
	/** Zoom view to point.
	@param toXPoint The place to zoom to.
	@param anticipation How much of a windup the view moves before zooming off.
	@param duration The duration of the animation.
	@param delay The delay before the animation is played.
	@param completion The completion callback handler.
	*/
	public func zoomToXPoint(toXPoint: CGFloat, anticipation: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
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
				var minX: CGFloat = self.minX + self.width / 2.0
				self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
				self.centerX = minX
				if (completion != nil) {
					completion!(finished)
				}
		})
	}
	
	
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
		
		UIView.animateKeyframes(withDuration: duration, delay: delay, options: [.calculationModeCubic,.allowUserInteraction] , animations: {
			
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
	
	
	
	
	
	/// Wiggle the view.
	public func wiggle() {
		self.wiggle(withRotationAngle: 0.06)
	}
	
	/** Wiggle the view.
	 @param withRotationAngle The range the view wiggle.
	 */
	public func wiggle(withRotationAngle: CGFloat) {
		self.wiggle(withDuration: 0.5, delay: 0, rotation: withRotationAngle)
	}
	
	/** Wiggle the view.
	 @param withDuration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param angle The range the view wiggle.
	 */
	public func wiggle(withDuration: TimeInterval, delay: TimeInterval, rotation angle: CGFloat) {
		self.wiggle(withDuration: withDuration, delay: delay, betweenAngleOne: angle, angleTwo: -angle)
	}
	
	/** Wiggle the view.
	@param withDuration The duration of the animation.
	@param delay The delay before the animation is played.
	@param angleOne The range the view wiggle.
	@param angleTwo The range the view wiggle.
	*/
	public func wiggle(withDuration: TimeInterval, delay: TimeInterval, betweenAngleOne angleOne: CGFloat, angleTwo: CGFloat) {
		let transform = self.transform
		let currentAngle: CGFloat = atan2(transform.b, transform.a)
		var animation: CABasicAnimation?
		var second = CATransform3DMakeRotation(angleTwo, 0, 0, 1.0)
		var secondBeginTime: CFTimeInterval
		if angleOne == currentAngle || angleTwo == currentAngle {
			if angleTwo == currentAngle {
				second = CATransform3DMakeRotation(angleOne, 0, 0, 1.0)
			}
			secondBeginTime = CACurrentMediaTime() + delay
		}
		else {
			let first = CATransform3DMakeRotation(angleOne, 0, 0, 1.0)
			animation = CABasicAnimation(keyPath: "transform")
			animation?.fromValue = NSCATransform3D(self.layer.transform)
			animation?.toValue = NSCATransform3D(first)
			animation?.duration = withDuration / 2.0
			animation?.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
			animation?.isRemovedOnCompletion = false
			animation?.beginTime = CACurrentMediaTime() + delay
			animation?.fillMode = kCAFillModeForwards
			self.add(animation)
			secondBeginTime = CACurrentMediaTime() + withDuration / 2.0 + delay
		}
		animation = CABasicAnimation(keyPath: "transform")
		// Create a basic animation to animate the layer's transform
		animation!.toValue = NSCATransform3D(second)
		// Assign the transform as the animation's value
		animation!.autoreverses = true
		animation!.duration = withDuration
		animation!.repeatCount = Float.infinity
		animation!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		animation!.beginTime = secondBeginTime
		animation!.isRemovedOnCompletion = false
		animation!.fillMode = kCAFillModeForwards
		self.add(animation)
	}
	

	
	/// Hop the view.
	public func hop() {
		self.hop(xPoint: self.superview!.width * 1.5, hopHeight: 40, duration: 0.7, delay: 0, completion: { _ in })
	}
	
	/** Hop the view.
	@param xPoint The place to hop.
	@param hopHeight The height of the hop.
	@param duration The duration of the animation.
	@param delay The delay before the animation is played.
	@param completion The completion callback handler.
	*/
	public func hop(xPoint: CGFloat, hopHeight: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: @escaping (Bool) -> Void) {
		let y: CGFloat = self.center.y
		let baseTransform = self.transform
		let midPoint = CGPointGetMidpoint(self.center, CGPoint(x: xPoint,y: self.centerY))
		UIView.animateKeyframes(withDuration: duration, delay: delay, options: .calculationModeCubic, animations: {() -> Void in
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {() -> Void in
				self.transform = CGConcat(CGScale(0.8, 1.0), CGRotate((-15.0 * CGFloat.pi) / 180.0))
			})
			UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {() -> Void in
				self.center = CGPoint(x: midPoint.x, y: y - hopHeight)
				self.transform = CGConcat(CGScale(1.4, 1), CGRotate((0.0 * CGFloat.pi) / 180.0))
			})
			UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {() -> Void in
				self.center = CGPoint(x: xPoint, y: y)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: {() -> Void in
				self.transform = CGConcat(CGScale(1.1, 1), CGRotate(15.0 * CGFloat.pi / 180.0))
			})
			UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {() -> Void in
				self.transform = baseTransform
			})
			}, completion: completion)
	}
	
	
	
	
	/** Shake the view.
	 @param withDuration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param completion The completion callback handler.
	 */
	public func shake(withDuration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
		let centerY: CGFloat = self.centerY
		let centerX: CGFloat = self.centerX
		UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .calculationModeCubicPaced, animations: {() -> Void in
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {() -> Void in
				self.center = CGPoint(x: centerX - 15, y: centerY)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {() -> Void in
				self.center = CGPoint(x: centerX + 15, y: centerY)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2, animations: {() -> Void in
				self.center = CGPoint(x: centerX - 10, y: centerY)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: {() -> Void in
				self.center = CGPoint(x: centerX + 10, y: centerY)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: {() -> Void in
				self.center = CGPoint(x: centerX + 0, y: centerY)
			})
			}, completion: completion)
	}
	
	/** Shake the view.
	@param completion The completion callback handler.
	*/
	public  func shake(withCompletion: ((Bool) -> Void)? ) {
		self.shake(withDuration: 0.6, delay: 0, completion: withCompletion)
	}
	
	
	
	
	
	
	/** Run forrest. Run.
	 @param toPoint The place run to.
	 @param withCompletion The completion callback handler.
	 */
	public func runForrestRun(toPoint: CGPoint, withCompletion completion: ((Bool) -> Void)?) {
		self.runForrestRun(withDuration: 1, delay: 0, toPoint: toPoint, completion: completion)
	}
	
	
	/** Run forrest. Run.
	 @param duration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param point The place run to.
	 @param completion The completion callback handler.
	 */
	public func runForrestRun(withDuration: TimeInterval, delay: TimeInterval, toPoint point: CGPoint, completion: ((Bool) -> Void)?) {
		let movingRight = point.x > self.centerX
		let baseTransform = self.transform
		var transform = baseTransform
		transform.c = movingRight ? 0.5 : -0.5
		let animation = CABasicAnimation(keyPath: "transform")
		animation.autoreverses = true
		animation.fromValue = NSValue(caTransform3D: CATransform3DMakeAffineTransform(baseTransform))
		animation.toValue = NSValue(caTransform3D: CATransform3DMakeAffineTransform(transform))
		animation.duration = withDuration / 4
		self.layer.add(animation, forKey: "forrest")
		UIView.animate(withDuration: withDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: [], animations: {() -> Void in
			self.center = point
			}, completion: completion)
	}

	
	
	
	/** Stop on a dime
	@param endXPoint The duration of the animation.
	@param duration The duration of the animation.
	@param delay The delay before the animation is played.
	@param completion The completion callback handler.
	*/
	public func turnOnADime(endXPoint: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)?) {
		let movingRight = endXPoint > self.centerX
		let anchorX: CGFloat = movingRight ? self.maxX : self.minX
		let anchorY: CGFloat = self.maxY
		let mult: CGFloat = movingRight ? 1 : -1
		self.layer.anchorPoint = movingRight ? CGPoint(x: 1, y: 1) : CGPoint(x: 0, y: 1)
		let twist: CGFloat = movingRight ? 0.1 : -0.1
		var twistTransform = CGAffineTransform.identity
		twistTransform.c = twist
		let x: CGFloat = endXPoint + (movingRight ? 1 : -1) * self.width / 2
		self.center = CGPoint(x: anchorX, y: anchorY)
		
		

		
		UIView.animateKeyframes(withDuration: duration, delay: delay, options: .calculationModeCubic, animations: { () -> Void in
			var s: Double = 0.0
			var dur: Double = 0.3
			UIView.addKeyframe(withRelativeStartTime: s, relativeDuration: dur / 2, animations: {() -> Void in
				self.transform = twistTransform
			})
			UIView.addKeyframe(withRelativeStartTime: s + dur / 2, relativeDuration: dur / 2, animations: {() -> Void in
				var transform = CGAffineTransform.identity
				transform.c = 0
				self.transform = transform
			})
			UIView.addKeyframe(withRelativeStartTime: s, relativeDuration: dur, animations: {() -> Void in
				self.center = CGPoint(x: x + 20 * mult, y: anchorY)
			})
			s += dur
			dur = 0.2
			UIView.addKeyframe(withRelativeStartTime: s, relativeDuration: dur, animations: {() -> Void in
				var transform = CGAffineTransform.identity
				transform.c = 0
				transform = CGConcat(transform, CGRotate(-2 * CGFloat.pi / 180.0))
				self.transform = transform
				self.center = CGPoint(x: x + 30 * mult, y: anchorY - 16)
			})
			s += dur
			dur = 0.2
			UIView.addKeyframe(withRelativeStartTime: s, relativeDuration: dur, animations: {() -> Void in
				var transform = CGAffineTransform.identity
				transform.c = 0
				transform = CGConcat(transform, CGRotate(-1 * CGFloat.pi / 180.0))
				self.transform = transform
				self.center = CGPoint(x: x + 15 * mult, y: anchorY - 20)
			})
			s += dur
			dur = 0.2
			
			
			
			UIView.addKeyframe(withRelativeStartTime: s, relativeDuration: dur, animations: {() -> Void in
				var transform = CGAffineTransform.identity
				transform = CGConcat(transform, CGRotate(0 * CGFloat.pi / 180.0))
				self.transform = transform
				self.center = CGPoint(x: x, y: anchorY)
			})
			
		}, completion: { (finished) in
			let xx: CGFloat = self.frame.midX
			let yy: CGFloat = self.frame.midY
			self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
			self.center = CGPoint(x: xx, y: yy)
			if (completion != nil) {
				completion!(finished)
			}
		})
	}
}
