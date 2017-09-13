//
//  SmoothAnimationViewController.swift
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
import curry
import curryfire

class SmoothAnimationViewController: UIViewController {

	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		self.view.addSubview(startStopButton)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.addSubview(self.loader)
		self.loader.center = self.view.middle
		self.title = "Smooth Animation"
		
	}
	
	@objc func buttonPressed(){
		
		
		if(!self.loader.isPlayingAnimation){
			
			self.loader.playAnimation(with: self.images, duration: 1.3, repeatCount: 0, withCompletionBlock: nil)
			startStopButton.setTitle("Stop", for: .normal)

		}else{
			
			let frame = self.loader.currentFrame;
			self.loader.stopAnimating()
			let subarray = Array(self.images[frame...self.images.count-1])
			let time = 1.3 * (Double(self.images.count-frame)) / Double(self.images.count)
			self.loader.playAnimation(with: subarray, duration: time, withCompletionBlock:nil)
			startStopButton.setTitle("Start", for: .normal)

		}
			
		
		

	}

	
	// MARK: Properties
	
	lazy var images: [UIImage] = {
		var images = [UIImage]()
		for i in 0..<91 {
			let img = UIImage(named: "loader-\(i)")!
			images.append(img)
		}
		return images
	}()
	
	lazy var startStopButton: UIButton = {
		var startStopButton = UIButton(type: .roundedRect)
		startStopButton.setTitle("Start", for: .normal)
		startStopButton.setTitleColor(UIColor.blue, for: .normal)
		startStopButton.setBorderWith(UIColor.lightGray, width: 1)
		startStopButton.cornerRadius = 5
		startStopButton.frame = CGRect(x: self.view.width / 2 - 50, y: self.view.height - 100, width: 100, height: 40)
		startStopButton.addTarget(self, action: #selector(buttonPressed) , for: .touchUpInside)
		return startStopButton
	}()
	
	lazy var loader: TKAnimatedImageView = {
		var loader: TKAnimatedImageView = TKAnimatedImageView(imageNamed: "loader-0")
		return loader
	}()
	
}
