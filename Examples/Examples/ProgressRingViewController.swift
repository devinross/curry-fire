//
//  ProgressRingViewController.swift
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

class ProgressRingViewController: UIViewController {
	
	
	var progreessRingOne : TKProgressRingView?
	var progreessRingTwo : TKProgressRingView?
	var progreessRingThree : TKProgressRingView?

	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.black
		
		let rr = self.view.bounds
		
		self.progreessRingOne = TKProgressRingView(frame: rr, radius: 66+31+31, strokeWidth: 30)
		self.progreessRingOne?.progressColor = UIColor(hex: 0xe40520)
		self.progreessRingOne?.curve = TKProgressRingAnimationCurveLinear
		self.progreessRingOne?.progress = 0.001
		self.view.addSubview(self.progreessRingOne!)

		self.progreessRingTwo = TKProgressRingView(frame: rr, radius: 66+31, strokeWidth: 30)
		self.progreessRingTwo?.progressColor = UIColor(hex: 0x3fde00)
		self.progreessRingTwo?.curve = TKProgressRingAnimationCurveQuadratic
		self.progreessRingTwo?.progress = 0.001
		self.view.addSubview(self.progreessRingTwo!)
		
		self.progreessRingThree = TKProgressRingView(frame: rr, radius: 66, strokeWidth: 30)
		self.progreessRingThree?.progressColor = UIColor(hex: 0x00c0df)
		self.progreessRingThree?.curve = TKProgressRingAnimationCurveSpring
		self.progreessRingThree?.progress = 0.001
		self.progreessRingThree?.springAnimation.springSpeed = 10
		self.progreessRingThree?.springAnimation.springBounciness = 15
		self.progreessRingThree?.springAnimation.dynamicsFriction = 14
		self.progreessRingThree?.springAnimation.dynamicsMass = 1
		self.view.addSubview(self.progreessRingThree!)
		
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.progreessRingOne?.setProgress(0.65, duration: 0.6)
		
		let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
		DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
			self.progreessRingTwo?.setProgress(0.45, duration: 1)
			
			let dispatchTime2: DispatchTime = DispatchTime.now() + Double(Int64(0.8 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
			DispatchQueue.main.asyncAfter(deadline: dispatchTime2, execute: {
				self.progreessRingThree?.setProgress(0.3, duration: 0.3)
			})
			
		})

	}
	
	

}

