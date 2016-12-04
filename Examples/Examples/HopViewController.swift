//
//  HopViewController.swift
//  Created by Devin Ross on 9/12/16.
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
import curryfire

class HopViewController: UIViewController {

	override func loadView() {
		super.loadView()
		
		self.view.backgroundColor = UIColor.white
		
		let cardView = UIView(frame: CGRectCenteredInRect(self.view.bounds, 100, 100), backgroundColor: UIColor.random(), cornerRadius: 10)
		cardView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
		cardView.backgroundColor = UIColor(hex: 0xa0a3dd)
		self.view.addSubview(cardView)
		
		cardView.addTapGesture { (sender) in
			
			cardView.hop(self.view.width + 150, hopHeight: 50, duration: 0.9, delay: 0, completion: { (finished) in

				cardView.centerX = -50;
				cardView.hop(self.view.width / 2, hopHeight: 30, duration: 1, delay: 1, completion: nil)
				
			})
		}
		
	}

}

