//
//  TickleViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/12/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit

class TickleViewController: UIViewController {

	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		
		let cardView = UIView(frame: CGRectCenteredInRect(self.view.bounds, 100, 100), backgroundColor: UIColor.random(), cornerRadius: 10)
		cardView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
		self.view.addSubview(cardView)
		
		cardView.addTapGesture { (sender) in
			
			cardView.tickle(withDuration: 0.8, delay: 0, downScale: 0.97, completion: { (completed) in
				
			})
			
		}
		
		
	}

}




