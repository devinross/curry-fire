//
//  POPSpringAnimation+Initializer.swift
//  Created by Devin Ross on 9/15/16.
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


import Foundation
import pop

extension POPSpringAnimation {
	
	@objc public class func springAnimation(name: String, toValue value: AnyObject, velocity: AnyObject, bouciness: CGFloat, speed: CGFloat, removeOnCompletion: Bool, completion: ((POPAnimation?, Bool) -> Void)?) -> POPSpringAnimation {
		let spring = POPSpringAnimation(propertyNamed: name)!
		spring.toValue = value
		spring.springBounciness = bouciness
		spring.springSpeed = speed
		spring.removedOnCompletion = removeOnCompletion
		spring.velocity = velocity
		spring.completionBlock = completion
		return spring
	}
	
	@objc public class func springAnimation(point: CGPoint, velocity: CGPoint, bouciness: CGFloat, speed: CGFloat, removeOnCompletion: Bool, completion: ((POPAnimation?, Bool) -> Void)?) -> POPSpringAnimation {
		return springAnimation(name: kPOPLayerPosition, toValue: NSCGPoint(point), velocity: NSCGPoint(velocity), bouciness: bouciness, speed: speed, removeOnCompletion: removeOnCompletion, completion: completion)
	}
	
}
