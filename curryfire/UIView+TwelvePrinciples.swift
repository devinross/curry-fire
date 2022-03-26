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
	
	/// Hop the view.
	@objc public func hop() {
		self.hop(self.superview!.width * 1.5, hopHeight: 40, duration: 0.7, delay: 0, completion: { _ in })
	}
	
	/** Hop the view.
	@param xPoint The place to hop.
	@param hopHeight The height of the hop.
	@param duration The duration of the animation.
	@param delay The delay before the animation is played.
	@param completion The completion callback handler.
	*/
	@objc public func hop(_ xPoint: CGFloat, hopHeight: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)?) {
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
	@objc public func shake(_ withDuration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)? ) {
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
	@objc public  func shake(_ completion: ((Bool) -> Void)? ) {
		self.shake(0.6, delay: 0, completion: completion)
	}
	
	
	
	
	
	
	/** Run forrest. Run.
	 @param toPoint The place run to.
	 @param withCompletion The completion callback handler.
	 */
	@objc public func runForrestRun(_ toPoint: CGPoint, withCompletion completion: ((Bool) -> Void)?) {
		self.runForrestRun(1, delay: 0, toPoint: toPoint, completion: completion)
	}
	
	
	/** Run forrest. Run.
	 @param duration The duration of the animation.
	 @param delay The delay before the animation is played.
	 @param point The place run to.
	 @param completion The completion callback handler.
	 */
	@objc public func runForrestRun(_ duration: TimeInterval, delay: TimeInterval, toPoint point: CGPoint, completion: ((Bool) -> Void)?) {
		let movingRight = point.x > self.centerX
		let baseTransform = self.transform
		var transform = baseTransform
		transform.c = movingRight ? 0.5 : -0.5
		let animation = CABasicAnimation(keyPath: "transform")
		animation.autoreverses = true
		animation.fromValue = NSValue(caTransform3D: CATransform3DMakeAffineTransform(baseTransform))
		animation.toValue = NSValue(caTransform3D: CATransform3DMakeAffineTransform(transform))
		animation.duration = duration / 4
		self.layer.add(animation, forKey: "forrest")
		UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: [], animations: {() -> Void in
			self.center = point
			}, completion: completion)
	}

	
	
	
	/** Stop on a dime
	@param endXPoint The duration of the animation.
	@param duration The duration of the animation.
	@param delay The delay before the animation is played.
	@param completion The completion callback handler.
	*/
	@objc public func turnOnADime(_ endXPoint: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: ((Bool) -> Void)?) {
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
