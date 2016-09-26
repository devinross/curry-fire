//
//  TKSlideToUnlockView.swift
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
import AudioToolbox
import curry

/** The mode that the slider to unlock view is in. */
public enum TKSlideToUnlockViewMode : Int {
	case normal = 0
	case disabled = 1
}

/** `TKSlideToUnlockView` is a control that allows users to slide to unlock like you would the lock screen. */
public class TKSlideToUnlockView: UIControl, UIScrollViewDelegate {
	///----------------------------
	/// @name Properties
	///----------------------------
	/** The shimmering text label that directs the user to act. */
	public var textLabel: TKShimmerLabel
	/** The scroll view that the user slides */
	public var scrollView: UIScrollView!
	/** The view behind the scroll view */
	public var backgroundView: UIImageView!
	/** The arrow */
	public var arrowView: UIImageView!
	/** A read-only property to tell whether to tell the state of the view */
	private(set) var isUnlocked = false
	/** The mode flag to enable of disable the view from acting. If disabled the device will vibrate. */
	public var mode : TKSlideToUnlockViewMode = .normal
	/** Reset the slider view to the original position.
	@param animated If yes, the view will animate to a reset position.
	*/
	public func resetSlider(_ animated: Bool) {
		self.scrollView.setContentOffset(CGPoint(x: self.scrollView.width, y: 0), animated: animated)
	}
	
	// MARK: Init & Friends
	public convenience init() {
		self.init(frame: CGRect(x: 0, y: 15, width: UIScreen.main.bounds.width, height: 62).insetBy(dx: 15, dy: 0))
	}
	
	public override init(frame: CGRect) {
		var theRect = frame
		theRect.size.height = 62
		
		var aFrame = theRect
		aFrame.origin = CGPoint(x: theRect.width, y: 0)
		self.textLabel = TKShimmerLabel(frame: aFrame.insetBy(dx: 40, dy: 10))
		super.init(frame: theRect)
		_setupView()
	}
	
	required public init(coder aDecoder: NSCoder) {
		fatalError("This class does not support NSCoding")
	}
	
	override public func layoutSubviews() {
		_renderScreen()
	}
	
	override public func awakeFromNib() {
		super.awakeFromNib()
		_setupView()
	}
	// MARK: Private Methods
	
	private func _setupView() {
		self.mode = .normal
		self.backgroundView = UIImageView(frame: self.bounds)
		self.backgroundView.layer.cornerRadius = 5
		self.backgroundView.clipsToBounds = true
		self.backgroundView.autoresizingMask = .flexibleHeight
		self.addSubview(self.backgroundView)
		self.scrollView = CustomScrollView(frame: self.bounds)
		self.scrollView.contentSize = CGSize(width: self.scrollView.width * 2, height: 0)
		self.scrollView.backgroundColor = UIColor(red: 76 / 255.0, green: 217 / 255.0, blue: 100 / 255.0, alpha: 0.7)
		self.scrollView.layer.cornerRadius = 5
		self.scrollView.isPagingEnabled = true
		self.scrollView.bounces = false
		self.scrollView.showsHorizontalScrollIndicator = false
		self.scrollView.delegate = self
		self.scrollView.delaysContentTouches = false
		self.scrollView.autoresizingMask = .flexibleHeight
		self.addSubview(self.scrollView)
		self.scrollView.contentOffset = CGPoint(x: self.scrollView.width, y: 0)
		
		let arrow = UIImage(named: "arrow", in: Bundle(for: TKSlideToUnlockView.self), compatibleWith: nil)
		self.arrowView = UIImageView(image: arrow)
		self.arrowView.center = CGPoint(x: self.scrollView.width + 25, y: self.scrollView.height / 2.0)
		self.scrollView.addSubview(self.arrowView)
		var textFrame = self.scrollView.bounds
		textFrame.origin.x = self.scrollView.width
		textFrame = textFrame.insetBy(dx: 40, dy: 10)
		self.textLabel.frame = textFrame
		self.textLabel.text = NSLocalizedString("slide to unlock", comment: "Slide to Unlock")
		self.textLabel.textColor = UIColor.white
		self.textLabel.font = UIFont.systemFont(ofSize: 25)
		self.textLabel.isUserInteractionEnabled = false
		self.textLabel.autoresizingMask = .flexibleHeight
		self.scrollView.addSubview(self.textLabel)
	}
	
	private func _renderScreen() {
		self.alpha = 0

		let p = convert(self.superview!.bounds.origin, from: self.superview!)
		UIGraphicsBeginImageContextWithOptions(self.backgroundView.frame.size, false, 0)
		let context = UIGraphicsGetCurrentContext()
		context!.saveGState()
		context!.translateBy(x: p.x, y: p.y)
		self.superview!.layer.render(in: context!)
		var newImage = UIGraphicsGetImageFromCurrentImageContext()
		context!.restoreGState()
		UIGraphicsEndImageContext()
		newImage = newImage?.applyingBlur(withRadius: 2, tintColor: nil, saturationDeltaFactor: 1, maskImage: nil)
		self.backgroundView.image = newImage
		self.alpha = 1
	}
	
	func _resetShimmer() {
		self.layoutSubviews()
		let dark = (UIColor(white: 1, alpha: 0.40).cgColor as Any)
		let light = (UIColor(white: 1, alpha: 1.0).cgColor as Any)
		self.textLabel.textHighlightLayer.colors = [dark, dark, light, dark, dark]
	}
	
	// MARK: UIScrollViewDelegate
	@objc(scrollViewDidEndDecelerating:) public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.x == 0 {
			self.isUnlocked = true
			self.sendActions(for: .valueChanged)
		}
		_resetShimmer()
	}
	
	@objc(scrollViewDidEndDragging:willDecelerate:) public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if !decelerate {
			_resetShimmer()
		}
	}
	
	@objc(scrollViewWillBeginDragging:) public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		if self.mode == .disabled {
			scrollView.isScrollEnabled = false
			scrollView.isUserInteractionEnabled = false
			scrollView.isScrollEnabled = true
			scrollView.isUserInteractionEnabled = true
			AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
			self.sendActions(for: .touchCancel)
		}
	}
	// MARK: UIView Touches
	
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let white = (UIColor.white.cgColor as Any)
		self.textLabel.textHighlightLayer.colors = [white, white, white, white, white]
		self.sendActions(for: .touchDown)
		if self.mode == .disabled {
			self.stashedBackgroundColor = self.scrollView.backgroundColor
			UIView.beginAnimations(nil, context: nil)
			self.scrollView.backgroundColor = UIColor(red: 233 / 255.0, green: 52 / 255.0, blue: 41 / 255.0, alpha: 0.7)
			UIView.commitAnimations()
		}
	}
	
	override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		self._resetShimmer()
		if self.mode == .disabled {
			UIView.beginAnimations(nil, context: nil)
			self.scrollView.backgroundColor = self.stashedBackgroundColor
			UIView.commitAnimations()
			self.resetSlider(true)
		}
		self.sendActions(for: .touchUpInside)
	}
	
	override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)
		self._resetShimmer()
		if self.mode == .disabled {
			UIView.beginAnimations(nil, context: nil)
			self.scrollView.backgroundColor = self.stashedBackgroundColor
			UIView.commitAnimations()
			self.resetSlider(true)
		}
		
		self.sendActions(for: .touchUpInside)
	}
	// MARK: Public Methods
	
	var stashedBackgroundColor: UIColor!
}
let TRACK_PADDING = 4.0
let SLIDER_VIEW_WIDTH = 82.0
let FADE_TEXT_OVER_LENGTH = 50.0
class CustomScrollView: UIScrollView {
	
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)  {
		self.next!.touchesBegan(touches, with: event)
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if !self.isDragging {
			self.next!.touchesMoved(touches, with: event)
		}
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.next!.touchesCancelled(touches, with: event)
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.next!.touchesEnded(touches, with: event)
	}
}
