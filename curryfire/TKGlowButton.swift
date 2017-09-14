//
//  TKGlowButton.swift
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

/// `TKGlowButton` is a subclassed `UIButton` that allows the background of a button to glow on touch.
@objc open class TKGlowButton: UIButton {
	
	private var normalBackgroundColor : UIColor?
	private var selectedBackgroundColor : UIColor?
	private var highlightedBackgroundColor : UIColor?

	/**
	 This method allows you to set the background color during a certain state.
	 @param color The background color of the button.
	 @param state The state to which the color will appear.
	 */
	@objc public func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
		if state == .normal {
			normalBackgroundColor = color
			self.backgroundColor = color
		}
		else if state == .highlighted {
			highlightedBackgroundColor = color
		}
		else if state == .selected {
			selectedBackgroundColor = color
		}
		
	}
	
	override open var isSelected: Bool {
		didSet {
			var clr = UIColor.clear
			var txtColor = UIColor.clear
			if isSelected && (selectedBackgroundColor != nil) {
				clr = selectedBackgroundColor!
				txtColor = self.titleColor(for: .selected)!
			}
			else if !isSelected && (normalBackgroundColor != nil) {
				clr = normalBackgroundColor!
				txtColor = self.titleColor(for: .normal)!
			}
			
			UIView.beginAnimations(nil, context: nil)
			self.backgroundColor = clr
			self.imageView!.tintColor = txtColor
			UIView.commitAnimations()
		}

	}
	override open var isHighlighted: Bool {
		didSet {
			var clr = UIColor.clear
			var txtColor = UIColor.clear
			if isHighlighted && (highlightedBackgroundColor != nil) {
				clr = highlightedBackgroundColor!
				txtColor = self.titleColor(for: .highlighted)!
			}
			else if !isHighlighted && (normalBackgroundColor != nil) {
				clr = normalBackgroundColor!
				txtColor = self.titleColor(for: .normal)!
			}
			
			UIView.beginAnimations(nil, context: nil)
			self.backgroundColor = clr
			self.imageView!.tintColor = txtColor
			UIView.commitAnimations()
		}
	}
}
