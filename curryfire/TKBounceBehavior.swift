//
//  TKBounceBehavior.swift
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

import UIKit

public class TKBounceBehavior: UIDynamicBehavior {
	
	@objc public var gravityBehavior: UIGravityBehavior
	@objc public var pushBehavior: UIPushBehavior
	@objc public var itemBehavior: UIDynamicItemBehavior
	@objc public var collisionBehavior: UICollisionBehavior
	private var _bounceDirection: CGVector = CGVector(dx: 0, dy:2.0)

	public init(items: [UIDynamicItem] ) {
	
		gravityBehavior = UIGravityBehavior(items: items)
		collisionBehavior = UICollisionBehavior(items: items)
		collisionBehavior.translatesReferenceBoundsIntoBoundary = true
		pushBehavior = UIPushBehavior(items: items, mode: .instantaneous)
		pushBehavior.pushDirection = _bounceDirection
		pushBehavior.active = false
		itemBehavior = UIDynamicItemBehavior(items: items)
		itemBehavior.elasticity = 0.45
		
		super.init()
		
		self.addChildBehavior(gravityBehavior)
		self.addChildBehavior(pushBehavior)
		self.addChildBehavior(itemBehavior)
		self.addChildBehavior(collisionBehavior)

	}
	
	@objc public var bounceDirection : CGVector {
		
		get {
			return _bounceDirection
		}
		
		set (vector) {
			_bounceDirection = vector
			self.pushBehavior.pushDirection = vector
			var dx: CGFloat = 0
			var dy: CGFloat = 0
			if vector.dx > 0 {
				dx = -1
			}
			else if vector.dx < 0 {
				dx = 1
			}
			
			if vector.dy > 0 {
				dy = -1
			}
			else if vector.dy < 0 {
				dy = 1
			}
			
			self.gravityBehavior.gravityDirection = CGVector(dx: dx, dy:dy)
		}


	}
	
	@objc public func bounce() {
		self.pushBehavior.active = true
	}
	

}
