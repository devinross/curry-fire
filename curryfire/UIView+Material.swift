//
//  UIView+Material.swift
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

extension UIView {
	
	
	// MARK: Material Like Animations
	
	@objc public func fireMaterialTouchDisk(atPoint: CGPoint) {
		let disk = UIView(frame: CGRect(x: 0, y:0, width:30, height: 30))
		disk.backgroundColor = UIColor(white: 1, alpha: 0.5)
		disk.layer.cornerRadius = disk.frame.width / 2
		disk.center = atPoint
		self.addSubview(disk)
		UIView.animate(withDuration: 0.5, animations: {() -> Void in
			disk.transform = CGAffineTransform(scaleX: 10, y: 10)
			disk.backgroundColor! = UIColor(white: 1, alpha: 0)
			}, completion: {(finished: Bool) -> Void in
				disk.removeFromSuperview()
		})
	}
	
	@objc public  func materialTransition(withSubview: UIView, atPoint point: CGPoint, changes: @escaping () -> Void, completion: ((Bool) -> Void)?) {
		self.materialTransition(withSubview: withSubview, expandCircle: true, atPoint: point, duration: 1, changes: changes, completion: completion)
		return
	}
	
	@objc public func materialTransition(withSubview: UIView, expandCircle: Bool, atPoint point: CGPoint, duration: CFTimeInterval, changes: () -> Void, completion: ((Bool) -> Void)?) {
		let snapshotImage = withSubview.snapshotImage(afterScreenUpdates: false)
		let snapshotView = UIImageView(frame: withSubview.frame)
		snapshotView.image = snapshotImage!
		self.insertSubview(snapshotView, aboveSubview: withSubview)
		changes()
		
		let size = CGFloat(10.0)
		var expandScale = max(withSubview.frame.width, withSubview.frame.height) / size
		expandScale *= 2
		CATransaction.begin()
		do {
			

			CATransaction.setCompletionBlock({
				snapshotView.removeFromSuperview()
				if completion != nil {
					completion!(true)
				}
			})
			let endTransform = expandCircle ? CATransform3DMakeScale(expandScale, expandScale, 1) : CATransform3DIdentity
			let startTransform = expandCircle ? CATransform3DIdentity : CATransform3DMakeScale(expandScale, expandScale, 1)
			let shapeMask = CAShapeLayer()
			shapeMask.frame = CGRect(x: point.x - size / 2,y: point.y - size / 2, width:size, height: size)
			shapeMask.fillColor = UIColor.red.cgColor
			let path = UIBezierPath(ovalIn: CGRect(x:0, y:0, width:size, height: size))
			if expandCircle {
				path.append(UIBezierPath(rect: shapeMask.bounds.insetBy(dx: -500, dy: -500)))
			}
			shapeMask.path = path.cgPath
			snapshotView.layer.mask = shapeMask
			shapeMask.fillRule = kCAFillRuleEvenOdd
			shapeMask.transform = startTransform
			let anime = CABasicAnimation(keyPath: "transform")
			anime.fromValue = NSValue(caTransform3D: shapeMask.transform)
			anime.toValue = NSValue(caTransform3D: endTransform)
			anime.duration = duration
			shapeMask.add(anime, forKey: "material")
			shapeMask.transform = endTransform
		}
		CATransaction.commit()
	}
	
}
