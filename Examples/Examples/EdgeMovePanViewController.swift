//
//  EdgeMovePanViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/26/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit

class EdgeMovePanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.white

		let block = UIView(frame: CGRect(x:self.view.width-100,y: 100, width:100, height:100), backgroundColor: UIColor.random())
		self.view.addSubview(block)


		
		
		
		let pan = TKMoveScreenEdgeGestureRecognizer(TKMoveGestureAxisX, movableView: block, locations: [block.centerX,block.centerX-100]) { (move, point, location) in
			print("\(location) \(point)")
		}
		pan.edges = UIRectEdge.right
		self.view.addGestureRecognizer(pan)
	
	
	}



}
