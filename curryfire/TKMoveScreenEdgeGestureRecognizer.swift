//
//  TKMoveScreenEdgeGestureRecognizer.swift
//  Created by Devin Ross on 9/26/16.
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


/** `TKMoveScreenEdgeGestureRecognizer` is a screen-edge-pan-gesture-recognizer built to move a view between certain locations. */
@objc public class TKMoveScreenEdgeGestureRecognizer: UIScreenEdgePanGestureRecognizer {

	@objc public init(XYAxisWithMovableView: UIView, locations: [CGPoint], moveHandler block: ((_ gesture: TKMoveScreenEdgeGestureRecognizer?,_ position: CGPoint,_ location: CGPoint) -> Void)?) {

		self.axis = TKMoveGestureAxisXY
		self.pointLocations = locations
		self.moveHandler = block
		self.movableView = XYAxisWithMovableView
		self.canMoveOutsideLocationBounds = true
		
		
		super.init(target: nil, action: nil)
		
		self.addTarget(self, action: #selector(TKMoveScreenEdgeGestureRecognizer.pan(_ :)))
		
		//super.init(target: self, action: #selector(TKMoveScreenEdgeGestureRecognizer.pan(_ :)))
		self.velocityDamping = 20
	}

	/** Creates and returns a gesture recognizer to move a view between points.
	@param movableView The view that the gesture will move.
	@param axis The directions the movable can move in.
	@param locations An array of locations that the view can move to. If the axis is X&Y, then the array should contain `NSValue` objects with a `CGPoint`. Otherwise, it should an array of `NSNumbers`.
	@param block A callback block for the gesture-recognizer.
	@return A newly minted move-gesture-recognizer.
	*/
	@objc public init(_ axis: TKMoveGestureAxis, movableView: UIView, locations: [CGFloat], moveHandler block: ((_ gesture: TKMoveScreenEdgeGestureRecognizer?,_ position: CGPoint,_ location: CGPoint) -> Void)?) {
		
		self.axis = axis
		self.axisLocations = locations
		self.moveHandler = block
		self.movableView = movableView
		self.canMoveOutsideLocationBounds = true
		super.init(target: nil, action: nil)
		self.addTarget(self, action: #selector(TKMoveScreenEdgeGestureRecognizer.pan(_ :)))
		self.velocityDamping = 20
	}
	/** The callback of the gesture-recognizer. */
	var moveHandler : ((_ gesture: TKMoveScreenEdgeGestureRecognizer?, _ position: CGPoint, _ location: CGPoint) -> Void)?
	/** The directions the movable can go. */
	private(set) var axis : TKMoveGestureAxis
	/** A flag that indicates if the gesture is active. */
	private(set) var moving = false
	/** A flag that indicates if the movable view is moving to a resting location. */
	var isAnimating: Bool {
		return self.movableView.layer.pop_animation(forKey: "pop") != nil
	}
	/** If YES, it keeps the view within the location bounds. Otherwise NO. */
	var canMoveOutsideLocationBounds = false
	/** The view that the gesture will move. */
	var movableView: UIView
	/** Resting locations for the movable view. */
	var axisLocations = [CGFloat]()
	var pointLocations = [CGPoint]()

	/** The POPSpringAnimation used to animate the movable view to a resting place. */
	@objc public lazy var snapBackAnimation : POPSpringAnimation = {
		var snapBackAnimation = POPSpringAnimation(propertyNamed: self.popAnimationPropertyName())
		snapBackAnimation?.springBounciness = 1.5
		snapBackAnimation?.springSpeed = 2
		snapBackAnimation?.removedOnCompletion = true
		return snapBackAnimation!
	}()
	
	
	/** Reduces the velocity used to determine the resting location after a gesture. */
	var velocityDamping: CGFloat = 0.0
	
	/** Animates the movable view to a certain point.
	@param point The point the movable view will relocate to.
	*/
	public func move(to point: CGPoint) {
		let panView = self.movableView
		let center = panView.center
		var blockPoint = center
		if self.axis == TKMoveGestureAxisXY || self.axis == TKMoveGestureAxisX {
			blockPoint.x = point.x
		}
		if self.axis == TKMoveGestureAxisXY || self.axis == TKMoveGestureAxisY {
			blockPoint.y = point.y
		}
		if self.axis == TKMoveGestureAxisX {
			self.snapBackAnimation.fromValue = (center.x)
			self.snapBackAnimation.toValue = (blockPoint.x)
		}
		else if self.axis == TKMoveGestureAxisY {
			self.snapBackAnimation.fromValue = (center.y)
			self.snapBackAnimation.toValue = (blockPoint.y)
		}
		else {
			self.snapBackAnimation.fromValue = NSCGPoint(center)
			self.snapBackAnimation.toValue = NSCGPoint(blockPoint)
		}
		
		panView.layer.pop_add(self.snapBackAnimation, forKey: "pop")
		let minPoint = self.minimumLocation()
		let maxPoint = self.maximumLocation()
		let perc = CGPoint(x: (blockPoint.x - minPoint.x) / (maxPoint.x - minPoint.x), y: (blockPoint.y - minPoint.y) / (maxPoint.y - minPoint.y))
		if let handler = self.moveHandler {
			handler(nil, perc, blockPoint)
		}
	}
	
	

	
	func closestPoint(toLocation projectedPoint: CGPoint, currentPoint: CGPoint) -> CGPoint {
		var minDistance: CGFloat = 100000000
		var retPoint = CGPoint.zero
		if self.axis == TKMoveGestureAxisXY {
		
			
			for endValue in self.pointLocations {
				let locationPoint = endValue
				let dis: CGFloat = CGPointGetDistance(projectedPoint, locationPoint)
				if dis < minDistance {
					retPoint = locationPoint
					minDistance = dis
				}
			}
			return retPoint
		}

		if self.axis == TKMoveGestureAxisY {
			for number in self.axisLocations {
				let locationPoint = CGPoint(x: currentPoint.x, y: CGFloat(number))
				let dis: CGFloat = CGPointGetDistance(projectedPoint, locationPoint)
				if dis < minDistance {
					retPoint = locationPoint
					minDistance = dis
				}
			}
			return retPoint
		}
		
	
		for number in self.axisLocations {
			let locationPoint = CGPoint(x: CGFloat(number), y: currentPoint.y)
			let dis: CGFloat = CGPointGetDistance(projectedPoint, locationPoint)
			if dis < minDistance {
				retPoint = locationPoint
				minDistance = dis
			}
		}
		return retPoint
	}
	
	func minimumLocation() -> CGPoint {
		if self.axis == TKMoveGestureAxisX {
			return CGPoint(x: CGFloat(self.axisLocations.min()!), y: self.movableView.center.y)
		}else if self.axis == TKMoveGestureAxisY {
			return CGPoint(x: self.movableView.center.x, y: CGFloat(self.axisLocations.min()!))
		}
		

		let sortedArray = self.pointLocations.sorted { (p1, p2) -> Bool in
			if p1.x == p2.x {
				return p1.y < p2.y
			}
			return p1.x < p2.x
		}
		
		return sortedArray.first!
	}
	
	func maximumLocation() -> CGPoint {
		if self.axis == TKMoveGestureAxisX {
			return CGPoint(x: CGFloat(self.axisLocations.max()!), y: self.movableView.center.y)
			
		}else if self.axis == TKMoveGestureAxisY {
			return CGPoint(x: self.movableView.center.y, y: CGFloat(self.axisLocations.max()!))
		}
		
		let sortedArray = self.pointLocations.sorted { (p1, p2) -> Bool in
			if p1.x == p2.x {
				return p1.y < p2.y
			}
			return p1.x < p2.x
		}
		return sortedArray.last!
	}
	
	@objc func pan(_ gesture: UIPanGestureRecognizer) {
		let velocity = self.velocity(in: self.view!)
		let panView = self.movableView
		if self.began || (!self.moving && self.changed) {
			self.startPoint = panView.center
			panView.layer.pop_removeAnimation(forKey: "pop")
			self.moving = true
		}
		var p = self.startPoint
		if self.axis == TKMoveGestureAxisXY || self.axis == TKMoveGestureAxisX {
			p.x += self.translation(in: self.view!).x
		}
		if self.axis == TKMoveGestureAxisXY || self.axis == TKMoveGestureAxisY {
			p.y += self.translation(in: self.view!).y
		}
		if self.axis == TKMoveGestureAxisX {
			p.y = self.movableView.center.y
		}
		if self.axis == TKMoveGestureAxisY {
			p.x = self.movableView.center.x
		}
		if !self.canMoveOutsideLocationBounds {
			let minPoint = self.minimumLocation()
			let maxPoint = self.maximumLocation()
			if self.axis == TKMoveGestureAxisX || self.axis == TKMoveGestureAxisXY {
				p.x = min(maxPoint.x, max(minPoint.x, p.x))
			}
			if self.axis == TKMoveGestureAxisY || self.axis == TKMoveGestureAxisXY {
				p.y = min(maxPoint.y, max(minPoint.y, p.y))
			}
		}
		var blockPoint = p
		if self.state == .changed {
			panView.center = p
		}
		else if self.state == .ended || self.state == .cancelled {
			let projectedX: CGFloat = p.x + velocity.x / self.velocityDamping
			let projectedY: CGFloat = p.y + velocity.y / self.velocityDamping
			let projectedPoint = CGPoint(x: projectedX, y: projectedY)
			blockPoint = self.closestPoint(toLocation: projectedPoint, currentPoint: p)
			if self.axis == TKMoveGestureAxisX {
				self.snapBackAnimation.fromValue = (p.x)
				self.snapBackAnimation.toValue = (blockPoint.x)
				self.snapBackAnimation.velocity = (velocity.x)
			}
			else if self.axis == TKMoveGestureAxisY {
				self.snapBackAnimation.fromValue = (p.y)
				self.snapBackAnimation.toValue = (blockPoint.y)
				self.snapBackAnimation.velocity = (velocity.y)
			}
			else {
				self.snapBackAnimation.fromValue = NSCGPoint(p)
				self.snapBackAnimation.toValue = NSCGPoint(blockPoint)
				self.snapBackAnimation.velocity = NSCGPoint(velocity)
			}
			
			panView.layer.pop_add(self.snapBackAnimation, forKey: "pop")
			self.moving = false
		}
		
		let minPoint = self.minimumLocation()
		let maxPoint = self.maximumLocation()
		let perc = CGPoint(x: (p.x - minPoint.x) / (maxPoint.x - minPoint.x), y: (p.y - minPoint.y) / (maxPoint.y - minPoint.y))
		if let handler = self.moveHandler {
			handler(self, perc, blockPoint)
		}
	}
	
	func popAnimationPropertyName() -> String {
		if self.axis == TKMoveGestureAxisX {
			return kPOPLayerPositionX
		}
		else if self.axis == TKMoveGestureAxisY {
			return kPOPLayerPositionY
		}
		
		return kPOPLayerPosition
	}
	
	var startPoint = CGPoint.zero
}
