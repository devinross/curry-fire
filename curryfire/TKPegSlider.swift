//
//  TKPegSlider.swift
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

/// `TKPegSlider` a slider control with set points.
public class TKPegSlider: UIControl {
	
	/// The index of the selected item.
	@objc public var selectedPegIndex : Int  {
		
		get{
			return _selectedPegIndex
		}
		set (segment) {
			selectPegAtIndex(index: segment, animated: false)
		}
		
	}
	
	/// The index of the selected item.
	@objc public var numberOfPegs : Int = 8 {
		
		didSet {
			if _selectedPegIndex >= numberOfPegs {
				_selectedPegIndex = numberOfPegs - 1
			}
			self._setupPegs()
		}
		
	}
	
	/// The left side image.
	@objc public var leftEndImage : UIImage? {
		get{
			return self.leftImageView.image
		}
		set(image){
			self.leftImageView.image = image?.withRenderingMode(.alwaysTemplate)
		}
	}

	/// The right side image.
	@objc public var rightEndImage : UIImage? {
		get{
			return self.rightImageView.image
		}
		set(image) {
			self.rightImageView.image = image?.withRenderingMode(.alwaysTemplate)
		}
	}
	
	
	public override init(frame: CGRect) {
		var aframe = frame;
		aframe.size = CGSize(width: 300, height: 40)
		rightImageView = UIImageView(frame: CGRect(x:aframe.width - 40, y:0, width:40,height: 40).insetBy(dx: 6, dy: 6))
		leftImageView = UIImageView(frame: CGRect(x:0, y:0, width:40, height:40).insetBy(dx: 6, dy: 6))



		
		super.init(frame: aframe)
		
		self.backgroundColor = UIColor(white: 0.95, alpha: 1)
		self.clipsToBounds = false
		self.layer.cornerRadius = self.frame.height / 2
		self.addSubview(self.leftImageView)
		self.addSubview(self.rightImageView)

		_setupPegs()
		let pan = UIPanGestureRecognizer(target: self, action: #selector(self.pan))
		self.addGestureRecognizer(pan)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
	// MARK: PRIVATE
	private var _selectedPegIndex : Int = 0
	private var leftImageView : UIImageView
	private var rightImageView : UIImageView
	private var pegs : [UIView] = []
	private let SCALE_DOWN : CGAffineTransform = CGScale(0.18, 0.18)
	private let OFF_PEG_ALPHA : CGFloat = CGFloat(0.5)

	private func _setupPegs() {
		var pegReserves = [UIView]()
		pegReserves += self.pegs
		
		self.pegs.forEach { $0.removeFromSuperview() }

		
		if numberOfPegs == 0 {
			return
		}
		let leftPad: CGFloat = 16 + (self.leftImageView.image != nil ? 40 : 3)
		let rightPad: CGFloat = 16 + (self.rightImageView.image != nil ? 40 : 3)
		let per: CGFloat = (self.frame.width - leftPad - rightPad) / CGFloat(numberOfPegs - 1)
		var pegs = [AnyObject]() /* capacity: numberOfPegs */
		for i in 0..<numberOfPegs {
			var reservePeg: UIView?
			
			if pegReserves.count > 0 {
				reservePeg = pegReserves.last!
				pegReserves.removeLast()
			}
			
			let peg : UIView = (reservePeg != nil) ? reservePeg! : UIView(frame: CGRect(x:0, y:0, width:24, height: 24))
			
			peg.transform = CGAffineTransform.identity

			peg.layer.cornerRadius = peg.frame.height / 2
			
			peg.backgroundColor = self.tintColor
			peg.tag = i
			peg.alpha = selectedPegIndex == i ? CGFloat(1) : OFF_PEG_ALPHA
			peg.transform = selectedPegIndex == i ? CGAffineTransform.identity : SCALE_DOWN
			let x: CGFloat = leftPad + per * CGFloat(i)
			peg.center = CGPoint(x:x, y: self.frame.height / 2)
			pegs.append(peg)
			self.addSubview(peg)
		}
		self.pegs = pegs as! [UIView]
	}
	private func _indexOfSelectAtPoint(point: CGFloat) -> Int {
		let leftPad: CGFloat = 16 + (self.leftImageView.image != nil ? 40 : 3)
		let rightPad: CGFloat = 16 + (self.rightImageView.image != nil ? 40 : 3)
		let per: CGFloat = (self.frame.width - leftPad - rightPad) / CGFloat(numberOfPegs - 1)
		var index = (point + (per / 2) - leftPad) / per
		index = max(0, index)
		return max(0, min(numberOfPegs - 1, Int(index)))
	}
	
	override public func tintColorDidChange() {
		super.tintColorDidChange()
		self._setupPegs()
		self.leftImageView.tintColor = self.tintColor
		self.rightImageView.tintColor = self.tintColor
	}
	
	@objc func pan(gesture: UIPanGestureRecognizer) {
		let p = gesture.location(in: self)
		let index = self._indexOfSelectAtPoint(point: p.x)
		UIView.beginAnimations(nil, context: nil)
		var i = 0
		for peg in self.pegs {
			peg.alpha = i == index ? 1.0 : OFF_PEG_ALPHA
			peg.transform = i == index ? CGAffineTransform.identity : SCALE_DOWN
			i += 1
		}
		UIView.commitAnimations()
		if index != _selectedPegIndex {
			_selectedPegIndex = index
			self.sendActions(for: .valueChanged)
		}
	}
	
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		let touch = touches.first!
		let p = touch.location(in: self)
		let index = self._indexOfSelectAtPoint(point: p.x)
		UIView.beginAnimations(nil, context: nil)
		var i = 0
		for peg in self.pegs {
			peg.alpha = i == index ? 1 : OFF_PEG_ALPHA
			peg.transform = i == index ? CGAffineTransform.identity : SCALE_DOWN
			i += 1
		}
		UIView.commitAnimations()
		if index != _selectedPegIndex {
			_selectedPegIndex = index
			self.sendActions(for: .valueChanged)
		}
	}
	
	
	// MARK: Functions
	/**
	 Select an item manually.
	 @param index The index of the item.
	 @param animated Animate the selection of the item.
	 */
	@objc public func selectPegAtIndex(index: Int, animated: Bool) {
		_selectedPegIndex = index
		if animated {
			UIView.beginAnimations(nil, context: nil)
		}
		var i = 0
		for peg: UIView in self.pegs {
			peg.alpha = i == index ? 1 : OFF_PEG_ALPHA
			peg.transform = i == index ? SCALE_DOWN : CGAffineTransform.identity
			i += 1
		}
		if animated {
			UIView.commitAnimations()
		}
	}



}
