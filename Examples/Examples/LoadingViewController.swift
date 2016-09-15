//
//  LoadingViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/15/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit
import curry
import curryfire

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = UIColor.white
		let loading = TKLoadingView(frame : self.view.bounds)
		self.view.addSubview(loading)
		loading.startAnimating()
	
	}



}
