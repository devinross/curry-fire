//
//  PagedScrollViewViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/12/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

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
