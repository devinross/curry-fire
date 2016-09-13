//
//  ControlsViewController.swift
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

class ControlsViewController: UIViewController {

	override func loadView() {
		super.loadView()
		
		self.view.backgroundColor = UIColor.white
		self.title = "Controls"
		
		let multiswitch1 = TKMultiSwitch(items: ["Option 1","Option 2"])
		multiswitch1.frame = CGRectMakeWithSize(10, 64 + 80, (multiswitch1.frame.size))
		multiswitch1.addTarget(self, action: #selector(changedSwitchValue), for: .valueChanged)
		self.view.addSubview(multiswitch1)
		
		let multiswitch2 = TKMultiSwitch(items: ["One","Two","Three"])
		multiswitch2.frame = CGRectMakeWithSize(10, 64 + 140, (multiswitch2.frame.size))
		multiswitch2.addTarget(self, action: #selector(changedSwitchValue), for: .valueChanged)
		self.view.addSubview(multiswitch2)
		
		let pegSlider = TKPegSlider(frame: CGRect(x:10, y: 64 + 200, width:40, height:40))
		pegSlider.frame = CGRectMakeWithSize(10, 80, (pegSlider.frame.size))
		pegSlider.numberOfPegs = 8
		pegSlider.leftEndImage = UIImage(named: "sad")
		pegSlider.rightEndImage = UIImage(named: "happy")
		pegSlider.addTarget(self, action: #selector(changedPegValue), for: .valueChanged)
		self.view.addSubview(pegSlider)
		
	}
	
	func changedSwitchValue(switcher: TKMultiSwitch){
		print("\(switcher)")
	}
	
	func changedPegValue(slider: TKPegSlider){
		print("\(slider)")
	}

}



