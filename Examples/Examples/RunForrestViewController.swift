//
//  RunForrestViewController.swift
//  Created by Devin Ross on 9/13/16.
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

class RunForrestViewController: UIViewController {

	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		self.title = "Run Forrest Run"

		
		let cardView = UIView(frame: CGRectCenteredInRect(self.view.bounds, 100, 100), backgroundColor: UIColor.random(), cornerRadius: 10)
		cardView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
		self.view.addSubview(cardView)
		
		cardView.addTapGesture { (sender) in
			
			cardView.runForrestRun(to: CGPoint(x:self.view.width*1.5, y: cardView.centerY) , withCompletion: { (complete) in
				cardView.transform = CGAffineTransform.identity
				cardView.center = CGPoint(x: self.view.width * -2, y: cardView.centerY)
				cardView.runForrestRun(to: CGPoint(x: self.view.centerX, y: cardView.centerY), withCompletion: nil)
			})
			
		}
		
		
	}
	
	
	

}

