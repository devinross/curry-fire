//
//  ZoomViewController.swift
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

class ZoomViewController: UIViewController {

	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		
		let cardView = UIView(frame: CGRectCenteredInRect(self.view.bounds, 100, 100), backgroundColor: UIColor.random(), cornerRadius: 10)
		cardView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
		self.view.addSubview(cardView)
		
		cardView.addTapGesture { (sender) in
			
			cardView.zoom(toYPoint: -1000, completion: { (complete) in
				
				let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
				DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
					
					cardView.centerY = self.view.height + 100
					UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
						cardView.centerY = self.view.height / 2
					}, completion: nil)
					
				})
				
				
			})
			
			
		}
		
		
	}


}


