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
	

	
}
