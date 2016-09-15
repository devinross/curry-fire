//
//  RootViewController.swift
//  Created by Devin Ross on 9/15/16.
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


class RootViewController: UITableViewController {
	
	
	var items : [[String:Any]] = []
	
	let identifier : String  = "cellIdentifier"

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Examples"
		
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
		let section1 = [
			["Paged Scroll View", PagedScrollViewViewController.self],
			["TKMoveGestureRecognizer", MoveGestureViewController.self],
			["TKMoveGestureRecognizer (Card Slide)", CardViewSlideUpViewController.self],
			["Material Transition", MaterialViewController.self],
			["Confetti", ConfettiViewController.self],
			["Animated Counter", CounterViewController.self],
			["Progress Ring", ProgressRingViewController.self],
			["Bounce Animator", BounceAnimatorViewController.self],
			["Page Control", PageControlViewController.self],
			["Smooth Animation", SmoothAnimationViewController.self],
			["Shimmer Label", ShimmerLabelViewController.self],
			["Loading", LoadingViewController.self],
			["Glow", GlowButtonViewController.self],
			["Custom Controls", ControlsViewController.self]
		]
		let section2 = [
			["Shake", ShakeAnimationViewController.self],
			["Zoom", ZoomViewController.self],
			["Wiggle", WiggleViewController.self],
			["Run Forest", RunForrestViewController.self],
			["Tickle", TickleViewController.self],
			["Hop", HopViewController.self],
			["Dime", DimeViewController.self]
		]
		
		self.items = [
			["title": " ",			"cells": section1],
			["title": "Animations", "cells": section2]
		]
		self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.items.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let cells = self.items[section]["cells"] as! [Any]
		return cells.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		let rows = self.items[indexPath.section]["cells"] as! [Any]
		let row = rows[indexPath.row] as! [Any]
		let txt = row[0] as! String

		cell.textLabel?.text = txt
		cell.accessoryType = .disclosureIndicator
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let rows = self.items[indexPath.section]["cells"] as! [Any]
		let row = rows[indexPath.row] as! [Any]
		let classy = row[1] as! UIViewController.Type
		self.navigationController!.pushViewController(classy.init(), animated: true)
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.items[section]["title"] as? String
	}
	


}
