//
//  CounterViewController.swift
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

class CounterViewController: UIViewController {
	
	var counterLabel : TKAnimatedCounterLabel?

	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		
		self.counterLabel = TKAnimatedCounterLabel(frame: self.view.bounds.insetBy(dx: 10, dy: 100))
		self.counterLabel?.curve = TKAnimatedCounterLabelAnimationCurveQuadratic
		self.counterLabel?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
		self.counterLabel?.font = UIFont.helveticaNeueUltraLight(withSize: 100)
		self.view.addSubview(self.counterLabel!)
		
		self.counterLabel?.setNumber(0)
		

	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.counterLabel?.setNumber(99, animated: true)
	}

}
