//
//  PageControlViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/13/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit

class PageControlViewController: UIViewController {

	
	var pageControl : TKPageControl?
	
	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		
		
		self.pageControl = TKPageControl(frame: CGRect(x: 0, y: 180, width: self.view.width, height: 40))
		self.pageControl?.numberOfPages = 5;
		self.pageControl?.currentPageIndicatorTintColor = UIColor.blue
		self.pageControl?.pageIndicatorTintColor = UIColor(white:0, alpha:0.3)
		self.view.addSubview(self.pageControl!)
		
		
	}

}


