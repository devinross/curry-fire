//
//  TKShimmerLabel.swift
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


public enum TKShimmerLabelDirection : Int {
	case leftToRight
	case rightToLeft
}

public class TKShimmerLabel: UILabel {


	/// The gradient layer that masks the text label to create the shimmer effect.
	public var textHighlightLayer : CAGradientLayer
	
	/// The direction the shimmer should move.
	public var direction : TKShimmerLabelDirection {
		didSet{
			_startShimmerAnimation()
		}
	}

	
	/// The duration of the shimmer animation
	public var shimmerDuration : TimeInterval = 4.0

	
	override public init(frame: CGRect) {
		direction = TKShimmerLabelDirection.leftToRight
		textHighlightLayer = CAGradientLayer()
		shimmerDuration = 4.0

		super.init(frame: frame)


		self.textAlignment = .center
		self.backgroundColor = UIColor.clear
		let dark = (UIColor(white: 1, alpha: 0.40).cgColor as AnyObject)
		let light = (UIColor(white: 1, alpha: 1.0).cgColor as AnyObject)
		self.textHighlightLayer.frame = self.bounds.insetBy(dx: -400, dy: 0)
		self.textHighlightLayer.colors = [dark, dark, light, dark, dark]
		self.textHighlightLayer.locations = [0, 0.46, 0.5, 0.54, 1]
		self.textHighlightLayer.startPoint = CGPoint.zero
		self.textHighlightLayer.endPoint = CGPoint(x: 1.0, y: 0)
		self.layer.mask = self.textHighlightLayer
		NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
	}
	
	required public init(coder aDecoder: NSCoder) {
		fatalError("This class does not support NSCoding")
	}
	

	// MARK: Private Animation Methods
	
	private func _animationStartPoint() -> CGFloat {
		let x: CGFloat = self.textHighlightLayer.frame.width / 2.0
		if self.direction == TKShimmerLabelDirection.leftToRight {
			return -x + self.frame.width
		}
		return x
	}
	
	private func _animationEndPoint() -> CGFloat {
		let x: CGFloat = self.textHighlightLayer.frame.width / 2.0
		if self.direction == TKShimmerLabelDirection.leftToRight {
			return x
		}
		return -x + self.frame.width
	}
	
	private func _startShimmerAnimation() {
		if self.superview == nil {
			return
		}
		self.textHighlightLayer.removeAllAnimations()
		let animation = CABasicAnimation(keyPath: "position.x")
		animation.repeatCount = Float.infinity
		animation.toValue = self._animationEndPoint()
		animation.fromValue = self._animationStartPoint()
		animation.duration = self.shimmerDuration
		self.textHighlightLayer.add(animation, forKey: "position.x")
	}
	
	// MARK: Methods That Trigger The Animation To Start
	
	func applicationDidBecomeActive(sender: AnyObject) {
		_startShimmerAnimation()
	}
	
	override public func willMove(toWindow: UIWindow?) {
		_startShimmerAnimation()
	}
	

	

}
