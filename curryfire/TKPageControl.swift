//
//  TKPageControl.swift
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
/** `TKPageControl` is a reimplementation of UIPageControl with a little flair. */
public class TKPageControl: UIControl {
	
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.images = [UIImage?]()
		self.isAccessibilityElement = true
		self.accessibilityTraits = UIAccessibilityTraitAdjustable
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
		self.addGestureRecognizer(tap)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/**
	This method allows you to set the background color during a certain state.
	@param currentPage The current page to be selected.
	@param animated Animate the selection of the current page.
	*/
	
	private var _currentPage : Int = 0
	public func setCurrentPage(_ page: Int, animated: Bool) {
		if numberOfPages == 0 {
			return
		}
		let nextPage = max(0,min(numberOfPages - 1, page))
		if !animated {
			_currentPage = nextPage
			return
		}
		let oldPage = _currentPage
		_currentPage = nextPage
		self.accessibilityLabel = NSLocalizedString("Page \(self.currentPage + 1) of \(self.numberOfPages)", comment: "")
		let oldDot : UIImageView = self.dots[oldPage]
		let selected = self.dots[nextPage]
		let center = selected.center
		let prevCenter = oldDot.center
		let oldCenter = oldDot.center
		let duration: TimeInterval = 0.4
		if oldPage + 1 != nextPage && oldPage - 1 != nextPage {
			UIView.beginAnimations(nil, context: nil)
			oldDot.backgroundColor = oldDot.image != nil ? UIColor.clear : self.pageIndicatorTintColor!
			oldDot.tintColor = self.pageIndicatorTintColor!
			selected.backgroundColor = selected.image != nil ? UIColor.clear : self.currentPageIndicatorTintColor!
			selected.tintColor = self.currentPageIndicatorTintColor!
			UIView.commitAnimations()
			return
		}
		let prev: CGFloat = oldCenter.x > center.x ? (selected.maxX + self.dotRadius) : (selected.minX - self.dotRadius)
		UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {() -> Void in
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {() -> Void in
				oldDot.center = CGPoint(x: prev, y: center.y)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7, animations: {() -> Void in
				oldDot.backgroundColor = oldDot.image != nil ? UIColor.clear : self.pageIndicatorTintColor!
				oldDot.tintColor = self.pageIndicatorTintColor!
				selected.backgroundColor = (selected.image != nil) ? UIColor.clear : self.currentPageIndicatorTintColor!
				selected.tintColor = self.currentPageIndicatorTintColor!
			})
			UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {() -> Void in
				let x: CGFloat = center.x > oldCenter.x ? self.BOUNCE : -self.BOUNCE
				selected.center = CGPoint(x: center.x + x, y: selected.center.y)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.2, animations: {() -> Void in
				let x: CGFloat = center.x < oldCenter.x ? self.BOUNCE : (-1.0 * self.BOUNCE)
				selected.center = CGPoint(x: center.x + x / 2, y: selected.center.y)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1, animations: {() -> Void in
				selected.center = center
			})
			UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {() -> Void in
				oldDot.center = prevCenter
			})
			}, completion: { _ in })
	}
	
	/**
	This method allows you to set page indicator as an image instead of a circle.
	@param image The image that should replace the circle.
	@param page The page that should be changed.
	*/
	public func setImage(_ image: UIImage?, forPage page: Int) {
		self.images[page] = image
		_configure()
	}
	
	public func incrementCurrentPage() {
		if self.currentPage + 1 >= self.numberOfPages {
			return
		}
		self.setCurrentPage(self.currentPage + 1, animated: true)
		self.sendActions(for: .valueChanged)
	}
	
	public func decrementCurrentPage() {
		if self.currentPage < 1 {
			return
		}
		self.setCurrentPage(self.currentPage - 1, animated: true)
		self.sendActions(for: .valueChanged)
	}
	///----------------------------
	/// @name Properties
	///----------------------------
	/** The number of pages in the page control. */
	public var numberOfPages: Int = 0 {
		didSet {
			for _ in self.dots.count..<numberOfPages {
				self.images.append(nil)
			}
			_setup()
		}
	}
	/** The current selected page. */
	public var currentPage: Int {
		get {
			return _currentPage
		}
		set(currentPage) {
			_currentPage = currentPage
			_configure()
		}
	}
	/** The color of the page indicators that aren't active. */
	public var pageIndicatorTintColor: UIColor? {
		didSet {
			_configure()
		}
	}
	/** The color of the current page indicator. */
	public var currentPageIndicatorTintColor: UIColor? {
		didSet {
			_configure()
		}
	}
	/** The circle radius of the page indicator. */
	public var dotRadius: CGFloat = 4 {
		didSet {
			_setup()
		}
	}
	/** The space in between page indicators. */
	public var spaceBetweenDots: CGFloat = 20 {
		didSet {
			_setup()
		}
	}
	

	
	private func _configure() {
		var i = 0
		for dot: UIImageView in self.dots {
			
			if let img = self.images[i] {
				dot.image = img.withRenderingMode(.alwaysTemplate)
				dot.backgroundColor = UIColor.clear
				dot.tintColor = currentPage == i ? self.currentPageIndicatorTintColor : self.pageIndicatorTintColor
			}else{
				dot.backgroundColor = currentPage == i ? self.currentPageIndicatorTintColor : self.pageIndicatorTintColor
				dot.image = nil
			}
			i += 1
		}
		self.accessibilityLabel = NSLocalizedString("Page \(self.currentPage + 1) of \(self.numberOfPages)", comment: "")
		
	}
	
	private func _setup() {
		self.dots.forEach { $0.removeFromSuperview() }
		
		let start = (self.frame.width - (DOT_DIAMETER + CGFloat(numberOfPages - 1) * self.spaceBetweenDots)) / 2
		let y = (self.frame.height - DOT_DIAMETER) / 2
		var dots = [UIImageView]() /* capacity: numberOfPages */
		for i in 0..<self.numberOfPages {
			let page = UIImageView(frame: CGRect(x: self.spaceBetweenDots * CGFloat(i) + start, y: y, width: DOT_DIAMETER, height: DOT_DIAMETER))
			page.backgroundColor = UIColor.black
			page.layer.cornerRadius = self.dotRadius
			page.contentMode = .center
			self.addSubview(page)
			dots.append(page)
		}
		self.dots = dots
		self.currentPage = _currentPage
		self.accessibilityLabel = NSLocalizedString("Page \(self.currentPage + 1) of \(self.numberOfPages)", comment: "")
	}
	
	func tapped(_ gesture: UITapGestureRecognizer) {
		let p = gesture.location(in: self)
		if p.x > self.frame.width / 2 {
			self.incrementCurrentPage()
		}
		else {
			self.decrementCurrentPage()
		}
	}
	
	override public func accessibilityIncrement() {
		self.incrementCurrentPage()
	}
	
	override public func accessibilityDecrement() {
		self.decrementCurrentPage()
	}
	
	override public func accessibilityActivate() -> Bool {
		if self.currentPage + 1 >= self.numberOfPages {
			return false
		}
		self.incrementCurrentPage()
		return true
	}
	
	// MARK: Visual Properties
	var dots = [UIImageView]()
	var images = [UIImage?]()
	
	private var DOT_DIAMETER : CGFloat {
		return self.dotRadius * 2
	}
	private let BOUNCE : CGFloat = 5
	
}
