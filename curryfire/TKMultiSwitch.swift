//
//  TKMultiSwitch.swift
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
import curry

@objc public enum TKMultiSwitchStyle : Int {
	case hollow
	case filled
}

/** `TKMultiSwitch` a slide control with multiple options. Sort of like a `UISwitch` mixed with a `UISegmentControl`. */
open class TKMultiSwitch: UIControl, UIGestureRecognizerDelegate {
	
	/**
	Initialize a `TKMultiSwitch` instance.
	@param items The items in the switch view.
	@param style The style of the switcher.
	@return A `TKMultiSwitch` object.
	*/
	@objc public init(items: [String], style: TKMultiSwitchStyle) {
		
		let height: CGFloat = 40
		self.style = style
		selectionInset = 3
		offsetFromCenter = -1
		
		super.init(frame: CGRect(x: 10, y: 6, width: 320 - 20, height: height))
		
		font = UIFont.systemFont(ofSize: 12)
		
		self.backgroundColor = UIColor(white: 0.95, alpha: 1)
		self.clipsToBounds = false
		self.layer.cornerRadius = self.frame.height / 2
		self.isMultipleTouchEnabled = false
		let per: CGFloat = CGFloat(self.frame.width) / CGFloat(items.count)
		self.selectionView = UIView(frame: CGRect(x: 0, y: 0, width: per, height: height).insetBy(dx: self.selectionInset, dy: self.selectionInset))
		self.selectionView.layer.borderColor = self.tintColor!.cgColor
		self.selectionView.layer.cornerRadius = self.selectionView.frame.height / 2
		self.selectionView.layer.borderWidth = 1
		self.selectionView.isUserInteractionEnabled = false
		self.addSubview(self.selectionView)
		var i = 0
		var labels = [UILabel]() /* capacity: items.count */
		for txt: String in items {
			let label = UILabel(frame: CGRect(x: per * CGFloat(i), y: 0, width: per, height: height))
			label.font = self.font
			label.text = txt
			label.textAlignment = .center
			let selected : Bool = i == indexOfSelectedItem
			if style == .hollow {
				label.textColor = self.tintColor!
				label.alpha = CGFloat(selected ? 1.0 : UNSELECTED_ALPHA)
			}
			label.accessibilityTraits = selected ? (UIAccessibilityTraits(rawValue: UIAccessibilityTraits.selected.rawValue | UIAccessibilityTraits.button.rawValue)) : UIAccessibilityTraits.button
			self.addSubview(label)
			labels.append(label)
			i += 1
		}
		self.labels = labels
		self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.pan))
		self.panGesture?.delegate = self
		self.addGestureRecognizer(self.panGesture!)
		self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap))
		self.tapGesture?.delegate = self
		self.addGestureRecognizer(self.tapGesture!)
		self.longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longtap))
		self.longPressGesture?.minimumPressDuration = 0.25
		self.longPressGesture?.delegate = self
		self.addGestureRecognizer(self.longPressGesture!)
	}
	/**
	Initialize a `TKMultiSwitch` instance.
	@param items The items in the switch view.
	@return A `TKMultiSwitch` object.
	*/
	@objc convenience public init(items: [String]) {
		self.init(items: items, style: .hollow)
	}
	
	required public init(coder aDecoder: NSCoder) {
		fatalError("This class does not support NSCoding")
	}
	
	convenience init() {
		self.init(items: [""], style: .hollow)
	}
	
	convenience override init(frame: CGRect) {
		self.init(items: [""], style: .hollow)
	}
	
	/** The index of the selected item. */
	private var _indexOfSelectedItem : Int = 0
	@objc public var indexOfSelectedItem: Int  {
		get {
			return _indexOfSelectedItem
		}
		set(indexOfSelectedItem) {
			self.selectItem(at: indexOfSelectedItem, animated: false)
		}
	}
	/** The select padding. */
	@objc public var selectionInset: CGFloat {
		didSet {
			self.needsReadjustment = true
			self.setNeedsLayout()
		}
	}
	/** The font used. */
	@objc public var font: UIFont? {
		didSet {
			self.needsReadjustment = true
			self.setNeedsLayout()
		}
	}
	/** Choose between a hollow or filled selection indicator. */
	@objc public var style: TKMultiSwitchStyle {
		didSet {
			self.needsReadjustment = true
			self.setNeedsLayout()
		}
	}
	/** If the style is a filled selection, then this will be used for the current select label. */
	@objc public var selectedTextColor: UIColor? {
		didSet {
			self.needsReadjustment = true
			self.setNeedsLayout()
		}
	}
	/** If the style is a filled selection, then this will be used for the current unselected labels. */
	@objc public var textColor: UIColor? {
		didSet {
			self.needsReadjustment = true
			self.setNeedsLayout()
		}
	}
	
	/**
	Select an item manually.
	@param index The index of the item.
	@param animated Animate the selection of the item.
	*/
	@objc public func selectItem(at index: Int, animated: Bool) {
		let per: CGFloat = self.frame.width / CGFloat(self.labels.count)
		self.offsetFromCenter = -1
		if(index == _indexOfSelectedItem){
			return
		}
		if animated {
			UIView.beginAnimations(nil, context: nil)
		}
		self.selectionView.transform = CGAffineTransform.identity
		self.selectionView.center = CGPoint(x: self.selectionInset + per * CGFloat(index) + self.selectionView.frame.width / 2, y: self.selectionView.center.y)
		var i = 0
		for label: UILabel in self.labels {
			let selected = i == index
			label.accessibilityTraits = selected ? (UIAccessibilityTraits(rawValue: UIAccessibilityTraits.selected.rawValue | UIAccessibilityTraits.button.rawValue)) : UIAccessibilityTraits.button

			if self.style == .filled {
				if animated {
					UIView.transition(with: label, duration: 0.3, options: [.transitionCrossDissolve, .beginFromCurrentState], animations: {() -> Void in
						label.textColor = selected ? self.selectedTextColor : self.textColor
						label.alpha = 1
						}, completion: { _ in })
				}
				else {
					label.textColor = selected ? self.selectedTextColor : self.textColor
					label.alpha = 1
				}
			}
			else {
				label.alpha = i == index ? 1 : UNSELECTED_ALPHA
			}
			i += 1
		}
		if animated {
			UIView.commitAnimations()
		}
		_indexOfSelectedItem = index
		
	}
	@objc public var panGesture: UIPanGestureRecognizer?
	@objc public var longPressGesture: UILongPressGestureRecognizer?
	@objc public var tapGesture: UITapGestureRecognizer?
	
	
	
	override open func layoutSubviews() {
		super.layoutSubviews()
		self.readjustLayout()
	}
	
	override open var frame: CGRect {
		didSet {
			self.needsReadjustment = true
			self.setNeedsLayout()
		}
	}
	
	override open var bounds: CGRect {
		didSet {
			self.needsReadjustment = true
			self.setNeedsLayout()
		}
	}
	
	func readjustLayout() {
		if !self.needsReadjustment {
			return
		}
		self.needsReadjustment = false
		let height: CGFloat = self.frame.height
		self.layer.cornerRadius = height / 2
		let per: CGFloat = self.frame.width / CGFloat(self.labels.count)
		self.selectionView.frame = CGRect(x: 0, y: 0, width: per, height: height).insetBy(dx: self.selectionInset, dy: self.selectionInset)
		if self.style == .hollow {
			self.selectionView.layer.borderColor = self.tintColor!.cgColor
			self.selectionView.layer.cornerRadius = self.selectionView.frame.height / 2
			self.selectionView.layer.borderWidth = 1
			self.selectionView.backgroundColor = UIColor.clear
		}
		else {
			self.selectionView.layer.borderColor = self.tintColor!.cgColor
			self.selectionView.layer.cornerRadius = self.selectionView.frame.height / 2
			self.selectionView.layer.borderWidth = 0
			self.selectionView.backgroundColor = self.tintColor!
		}
		var i = 0
		for label: UILabel in self.labels {
			label.frame = CGRect(x: per * CGFloat(i), y: 0, width: per, height: CGFrameGetHeight(self))
			label.font = self.font
			let selected = i == indexOfSelectedItem
			label.accessibilityTraits = selected ? (UIAccessibilityTraits(rawValue: UIAccessibilityTraits.selected.rawValue | UIAccessibilityTraits.button.rawValue)) : UIAccessibilityTraits.button
			if self.style == .filled {
				label.textColor = selected ? self.selectedTextColor : self.textColor
				label.alpha = 1
			}
			else {
				label.alpha = selected ? 1 : UNSELECTED_ALPHA
			}

			i += 1
		}
		let label = self.labels[indexOfSelectedItem]
		let x: CGFloat = (label as AnyObject).center.x
		self.selectionView.center = CGPoint(x: x, y: CGFrameGetHeight(self) / 2)
	}
	
	override open func tintColorDidChange() {
		super.tintColorDidChange()
		for label: UILabel in self.labels {
			label.textColor = self.tintColor!
		}
		self.selectionView.layer.borderColor = self.tintColor!.cgColor
		self.readjustLayout()
	}
	
	
	// MARK: UIGesture Actions
	@objc func longtap(_ press: UILongPressGestureRecognizer) {
		let point = press.location(in: self)
		let per: CGFloat = self.frame.width / CGFloat(self.labels.count)
		let index : Int = Int(point.x / per)
		if press.began {
			UIView.beginAnimations(nil, context: nil)
			UIView.setAnimationBeginsFromCurrentState(true)
			UIView.setAnimationCurve(.easeInOut)
			self.selectionView.transform = scale_up()
			if index != indexOfSelectedItem {
				var x: CGFloat = point.x
				x = min(self.frame.width - (self.selectionView.frame.width / 2), x)
				x = max(self.selectionView.frame.width / 2, x)
				self.selectionView.center = CGPoint(x: x, y: self.selectionView.center.y)
				self.offsetFromCenter = 0
				var i = 0
				for label: UILabel in self.labels {
					let selected = i == index
					label.accessibilityTraits = selected ? (UIAccessibilityTraits(rawValue: UIAccessibilityTraits.selected.rawValue | UIAccessibilityTraits.button.rawValue)) : UIAccessibilityTraits.button

					if self.style == .filled {
						UIView.transition(with: label, duration: 0.3, options: [.transitionCrossDissolve, .beginFromCurrentState], animations: {() -> Void in
							label.textColor = selected ? self.selectedTextColor : self.textColor
							label.alpha = 1
							}, completion: { _ in })
					}
					else {
						label.alpha = selected ? 1 : UNSELECTED_ALPHA
					}
					i += 1
				}
			}
			else {
				var x: CGFloat = point.x
				x = min(self.frame.width - (self.selectionView.frame.width / 2), x)
				x = max(self.selectionView.frame.width / 2, x)
				self.selectionView.center = CGPoint(x: x, y: self.selectionView.center.y)
			}
			UIView.commitAnimations()
		}
		else if press.ended || press.cancelled {
			let per: CGFloat = self.frame.width / CGFloat(self.labels.count)
			let index : Int = Int(self.selectionView.center.x / per)
			UIView.beginAnimations(nil, context: nil)
			UIView.setAnimationBeginsFromCurrentState(true)
			self.selectionView.transform = CGAffineTransform.identity
			UIView.commitAnimations()
			UIView.beginAnimations(nil, context: nil)
			self.selectionView.transform = CGAffineTransform.identity
			self.selectionView.center = CGPoint(x: self.selectionInset + per * CGFloat(index) + self.selectionView.frame.width / 2, y: self.selectionView.center.y)
			UIView.commitAnimations()
			self.offsetFromCenter = -1
			if indexOfSelectedItem == index {
				return
			}
			_indexOfSelectedItem = Int(index)
			self.sendActions(for: .valueChanged)
		}
		
	}
	
	@objc func pan(_ pan: UIPanGestureRecognizer) {
		let p = pan.location(in: self)
		if pan.began {
			if self.offsetFromCenter == -1 {
				self.offsetFromCenter = p.x - self.selectionView.center.x
			}
			UIView.beginAnimations(nil, context: nil)
			UIView.setAnimationCurve(.easeInOut)
			self.selectionView.transform = scale_up()
			UIView.commitAnimations()
		}
		let per: CGFloat = self.frame.width / CGFloat(self.labels.count)
		let index : Int = Int(self.selectionView.center.x / per)
		if pan.changed {
			var x: CGFloat = p.x - self.offsetFromCenter
			x = min(self.frame.width - (self.selectionView.frame.width / 2), x)
			x = max(self.selectionView.frame.width / 2, x)
			UIView.beginAnimations(nil, context: nil)
			self.selectionView.center = CGPoint(x: x, y: self.selectionView.center.y)
			UIView.commitAnimations()
			UIView.beginAnimations(nil, context: nil)
			var i = 0
			for label: UILabel in self.labels {
				if self.style == .filled {
					UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {() -> Void in
						label.textColor = i == index ? self.selectedTextColor : self.textColor
						label.alpha = 1
						}, completion: { _ in })
				}
				else {
					label.alpha = i == index ? 1 : UNSELECTED_ALPHA
				}
				i += 1
			}
			UIView.commitAnimations()
		}
		if pan.ended || pan.cancelled {
			UIView.beginAnimations(nil, context: nil)
			self.selectionView.transform = CGAffineTransform.identity
			self.selectionView.center = CGPoint(x: self.selectionInset + per * CGFloat(index) + self.selectionView.frame.width / 2, y: self.selectionView.center.y)
			UIView.commitAnimations()
			UIView.beginAnimations(nil, context: nil)
			var i = 0
			for label: UILabel in self.labels {
				let selected = i == index
				label.accessibilityTraits = selected ? (UIAccessibilityTraits(rawValue: UIAccessibilityTraits.selected.rawValue | UIAccessibilityTraits.button.rawValue)) : UIAccessibilityTraits.button

				if self.style == .filled {
					UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {() -> Void in
						label.textColor = selected ? self.selectedTextColor : self.textColor
						label.alpha = 1
						}, completion: { _ in })
				}
				else {
					label.alpha = selected ? 1 : UNSELECTED_ALPHA
				}
				i += 1
			}
			UIView.commitAnimations()
			self.offsetFromCenter = -1
			if indexOfSelectedItem == index {
				return
			}
			_indexOfSelectedItem = index
			self.sendActions(for: .valueChanged)
		}
	}
	
	@objc func tap(_ tap: UITapGestureRecognizer) {
		let point = tap.location(in: self)
		let per: CGFloat = self.frame.width / CGFloat(self.labels.count)
		let index = Int(point.x / per)
		self.offsetFromCenter = -1
		UIView.beginAnimations(nil, context: nil)
		UIView.setAnimationBeginsFromCurrentState(true)
		UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
		self.selectionView.transform = CGAffineTransform.identity
		self.selectionView.center = CGPoint(x: self.selectionInset + per * CGFloat(index) + self.selectionView.frame.width / 2, y: self.selectionView.center.y)
		var i = 0
		for label: UILabel in self.labels {
			let selected = i == index
			label.accessibilityTraits = selected ? (UIAccessibilityTraits(rawValue: UIAccessibilityTraits.selected.rawValue | UIAccessibilityTraits.button.rawValue)) : UIAccessibilityTraits.button

			if self.style == .filled {
				UIView.transition(with: label, duration: 0.3, options: [.transitionCrossDissolve, .beginFromCurrentState], animations: {() -> Void in
					label.textColor = selected ? self.selectedTextColor : self.textColor
					label.alpha = 1
					}, completion: { _ in })
			}
			else {
				label.alpha = selected ? 1.0 : UNSELECTED_ALPHA
			}
			i += 1
		}
		UIView.commitAnimations()
		if index == indexOfSelectedItem {
			return
		}
		_indexOfSelectedItem = Int(index)
		self.sendActions(for: .valueChanged)
	}
	
	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		if self.longPressGesture == gestureRecognizer && self.panGesture == otherGestureRecognizer {
			return true
		}
		if (gestureRecognizer is UITapGestureRecognizer) || (otherGestureRecognizer is UITapGestureRecognizer) {
			return false
		}
		if gestureRecognizer == self.panGesture || (otherGestureRecognizer is UIPanGestureRecognizer) {
			return false
		}
		return true
	}
	
	
	private var selectionView: UIView!
	private var labels = [UILabel]()
	private var offsetFromCenter: CGFloat = 0.0
	private var needsReadjustment = false
	private let UNSELECTED_ALPHA : CGFloat = 0.5
	private func up_scale() -> CGFloat{
		return (self.frame.height / (self.frame.height - self.selectionInset * 2))
	}
	private func scale_up() -> CGAffineTransform {
		return CGScale(up_scale(), up_scale())
	}
}
