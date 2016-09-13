//
//  PagedScrollViewViewController.swift
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

class PagedScrollViewViewController: UIViewController, TKPagedScrollViewDelegate {
	
	
	
	override func loadView() {
		super.loadView()
		
		self.edgesForExtendedLayout = UIRectEdge(rawValue: UInt(0))
		self.view.backgroundColor = UIColor.white
		
		let scroll = TKPagedScrollView(frame: self.view.bounds, direction: TKPageScrollDirection.vertical)
		scroll.delegate = self
		scroll.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(scroll)
		
		
		let viewOne = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 1000) )
		view.backgroundColor = UIColor.random()
		scroll.addSubview(viewOne)

		
		let gradient = TKGradientView(frame: viewOne.bounds)
		gradient.colors = [UIColor(white: 0, alpha: 0), UIColor(white: 0, alpha: 0.5)]
		viewOne.addSubview(gradient)
		
		
		
		let viewTwo = UIView(frame: CGRect(x: 0, y: viewOne.maxY, width: self.view.width, height: 2000) , backgroundColor: UIColor.random())
		scroll.addSubview(viewTwo)

		let gradient2 = TKGradientView(frame: viewTwo.bounds)
		gradient.colors = [UIColor(white: 0, alpha: 0), UIColor(white: 0, alpha: 0.5)]
		viewTwo.addSubview(gradient2)
		
		let viewThree = UIView(frame: CGRect(x: 0, y: viewTwo.maxY, width: self.view.width, height: 2000) , backgroundColor: UIColor.random())
		scroll.addSubview(viewThree)
		
		let viewFour = UIView(frame: CGRect(x: 0, y: viewThree.maxY, width: self.view.width, height: 3000) , backgroundColor: UIColor.random())
		scroll.addSubview(viewFour)
		
		scroll.pages = [viewOne,viewTwo,viewThree,viewFour]


		
	}

}
