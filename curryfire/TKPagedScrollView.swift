//
//  TKPagedScrollView.swift
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

@objc public protocol TKPagedScrollViewDelegate {
	/** Tells the delegate when the user scrolls the content view within the receiver.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	*/
	@objc optional func pagedScrollViewDidScroll(pagedScrollView: TKPagedScrollView?)
	/** The event sent when a paged scroll view will animate to a different page.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	@param page The page that will become the active page.
	*/
	
	@objc optional func pagedScrollView(pagedScrollView: TKPagedScrollView?, willMoveToPage page: Int)
	/** The event sent when a paged scroll view did animate to a different page.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	@param page The page that did become the active page.
	*/
	
	@objc optional func pagedScrollView(pagedScrollView: TKPagedScrollView?, didMoveToPage page: Int)
	/** Tells the delegate when the scroll view is about to start scrolling the content.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	*/
	
	@objc optional func pagedScrollViewWillBeginDragging(pagedScrollView: TKPagedScrollView?)
	/** Tells the delegate when dragging ended in the scroll view.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	@param decelerate YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation. If the value is NO, scrolling stops immediately upon touch-up.
	*/
	
	@objc optional func pagedScrollViewDidEndDragging(pagedScrollView: TKPagedScrollView?, willDecelerate decelerate: Bool)
	/** Tells the delegate that the scroll view is starting to decelerate the scrolling movement.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	*/
	
	@objc optional func pagedScrollViewWillBeginDecelerating(pagedScrollView: TKPagedScrollView?)
	/** Tells the delegate that the scroll view has ended decelerating the scrolling movement.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	*/
	
	@objc optional func pagedScrollViewDidEndDecelerating(pagedScrollView: TKPagedScrollView?)
	/** Tells the delegate when a scrolling animation in the scroll view concludes.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	*/
	
	@objc optional func pagedScrollViewDidEndScrollingAnimation(pagedScrollView: TKPagedScrollView?)
	/** Asks the delegate if the scroll view should scroll to the top of the content.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	*/
	
	@objc optional func pagedScrollViewShouldScrollToTop(pagedScrollView: TKPagedScrollView?) -> Bool
	/** Tells the delegate that the scroll view scrolled to the top of the content.
	@param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
	*/
	
	@objc optional func pagedScrollViewDidScrollToTop(pagedScrollView: TKPagedScrollView?)
}

public enum TKPageScrollDirection : Int {
	case vertical
	case horizontal
}


public class TKPagedScrollView: UIView, UIScrollViewDelegate {
	

	
	
	
	// MARK: INIT

	override convenience init(frame: CGRect) {
		self.init(frame: frame, direction: .vertical)
	}
	
	required public init(coder aDecoder: NSCoder) {
		fatalError("This class does not support NSCoding")
	}
	
	public init(frame: CGRect, direction: TKPageScrollDirection) {
		
		scrollDirection = direction
		scrollView = UIScrollView(frame: CGRect(x:0,y:0,width:frame.size.width,height:frame.size.height))
		currentPage = 0
		animatingPages = false

		_pages = []
		super.init(frame: frame)
		
		self.clipsToBounds = true
		scrollView.delegate = self
		self.scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		self.addSubview(self.scrollView)
	}
	
	
	
	
	

	
	
	// MARK: Actions
	public func scrollToPreviousPage() {
		let currentPage = self.currentPage
		let nextPage = currentPage - 1
		if nextPage < 0 {
			return
		}
		self.animatingPages = true
		self.delegate?.pagedScrollView?(pagedScrollView: self, willMoveToPage: nextPage)

		
		
		

		let showVert = self.scrollView.showsVerticalScrollIndicator
		let showHorz = self.scrollView.showsHorizontalScrollIndicator
		let interactive = self.scrollView.isUserInteractionEnabled
		self.scrollView.isUserInteractionEnabled = false
		self.scrollView.showsVerticalScrollIndicator = self.scrollView.showsHorizontalScrollIndicator == false
		let nextView = self.pages[nextPage]
		for subview: UIView in self.pages {
			subview.move(to: self.scrollView.superview!)
		}
		self.scrollView.setContentOffset(CGPoint.zero, animated: false)
		if _scrollVertical {
			self.scrollView.contentHeight = nextView.height
		}
		else {
			self.scrollView.contentWidth = nextView.width
		}
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {() -> Void in
			if self._scrollVertical {
				nextView.maxY = self.scrollView.maxY
			}
			else {
				nextView.maxX = self.scrollView.maxX
			}
			var min: CGFloat = self._scrollVertical ? self.scrollView.maxY : self.scrollView.maxX
			for i in currentPage..<self.pages.count {
				let page = self.pages[i]
				if self._scrollVertical {
					page.minY = min
					min = page.maxY
				}
				else {
					page.minX = min
					min = page.maxX
				}
			}
			var max: CGFloat = self._scrollVertical ? nextView.minY : nextView.minX
			var i = nextPage - 1
			while i >= 0 {
				let page = self.pages[i]
				if self._scrollVertical {
					page.maxY = max
					max = page.minY
				}
				else {
					page.maxX = max
					max = page.minX
				}
				i -= 1
			}
			}, completion: {(finished: Bool) -> Void in
				self.currentPage = nextPage
				var offset = CGPoint.zero
				if self.scrollDirection == .vertical {
					self.scrollView.contentHeight = nextView.height
					offset = CGPoint(x: 0, y: nextView.height - self.scrollView.height)
				}
				else {
					self.scrollView.contentWidth = nextView.width
					offset = CGPoint(x: nextView.width - self.scrollView.width, y: 0)
				}
				self.scrollView.setContentOffset(offset, animated: false)
				for subview: UIView in self.pages {
					subview.move(to: self.scrollView)
				}
				self.scrollView.isUserInteractionEnabled = interactive
				self.scrollView.showsVerticalScrollIndicator = showVert
				self.scrollView.showsHorizontalScrollIndicator = showHorz
				self.animatingPages = false
				self.delegate?.pagedScrollView?(pagedScrollView: self, didMoveToPage: self.currentPage)
				
		})
	}
	
	public func scrollToNextPage() {
		let currentPage = self.currentPage
		let nextPage = currentPage + 1
		if nextPage >= self.pages.count {
			return
		}
		self.animatingPages = true
		self.delegate?.pagedScrollView?(pagedScrollView: self, willMoveToPage: nextPage)
		
		let showVert = self.scrollView.showsVerticalScrollIndicator
		let showHorz = self.scrollView.showsHorizontalScrollIndicator
		let interactive = self.scrollView.isUserInteractionEnabled
		self.scrollView.isUserInteractionEnabled = false
		self.scrollView.showsVerticalScrollIndicator = self.scrollView.showsHorizontalScrollIndicator == false
		let nextView = self.pages[nextPage]
		for subview: UIView in self.pages {
			subview.move(to: self.scrollView.superview!)
		}
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {() -> Void in
			var min: CGFloat = 0
			for i in nextPage..<self.pages.count {
				let page = self.pages[i]
				if self._scrollVertical {
					page.minY = min
					min = page.maxY
				}
				else {
					page.minX = min
					min = page.maxX
				}
			}
			var max: CGFloat = 0
			var i = nextPage - 1
			while i >= 0 {
				let page = self.pages[i]
				if self._scrollVertical {
					page.maxY = max
					max = page.minY
				}
				else {
					page.maxX = max
					max = page.minX
				}
				i -= 1
			}
			}, completion: {(finished: Bool) -> Void in
				self.currentPage = nextPage
				self.scrollView.setContentOffset(CGPoint.zero, animated: false)
				if self.scrollDirection == .vertical {
					self.scrollView.contentHeight = nextView.height
				}
				else {
					self.scrollView.contentWidth = nextView.width
				}
				self.scrollView.setContentOffset(CGPoint.zero, animated: false)
				for subview: UIView in self.pages {
					subview.move(to: self.scrollView)
				}
				self.scrollView.isUserInteractionEnabled = interactive
				self.scrollView.showsVerticalScrollIndicator = showVert
				self.scrollView.showsHorizontalScrollIndicator = showHorz
				self.animatingPages = false

				
				self.delegate?.pagedScrollView?(pagedScrollView: self, didMoveToPage: self.currentPage)
		})
	}
	
	public func scroll(toPage: Int, animated: Bool) {
		if toPage < 0 || toPage >= self.pages.count {
			return
		}
		self.currentPage = toPage
		if animated {
			UIView.beginAnimations(nil, context: nil)
		}
		self._setupPages()
		if animated {
			UIView.commitAnimations()
		}
	}
	
	
	// MARK: Private
	private var _pages : [UIView]
	private var _scrollVertical : Bool {
		return self.scrollDirection == .vertical
	}
	private func updatePagesLayout() {
		let nextView = self.pages[self.currentPage]
		let vert = self.scrollDirection == .vertical
		if vert {
			self.scrollView.contentSize = CGSize(width:self.scrollView.width, height: nextView.height)
		}
		else {
			self.scrollView.contentSize = CGSize(width: nextView.width, height: self.scrollView.height)
		}
		var min: CGFloat = vert ? nextView.maxY : nextView.maxX
		for i in self.currentPage + 1..<self.pages.count {
			let page = self.pages[i]
			if vert {
				page.minY = min
				min = page.maxY
			}
			else {
				page.minX = min
				min = page.maxX
			}
			self.scrollView.addSubview(page)
		}
		var max: CGFloat = 0
		var i = self.currentPage - 1
		while i >= 0 {
			let page = self.pages[i]
			if vert {
				page.maxY = max
				max = page.minY
			}
			else {
				page.maxX = max
				max = page.minX
			}
			self.scrollView.addSubview(page)
			i -= 1
		}
	}
	
	private func _setupPages() {
		self.scrollView.setContentOffset(CGPoint.zero, animated: false)
		let nextView = self.pages[self.currentPage]
		let vert = self.scrollDirection == .vertical
		if vert {
			self.scrollView.contentSize = CGSize(width: 0,height: nextView.height)
		}
		else {
			self.scrollView.contentSize = CGSize(width: nextView.width, height: 0)
		}
		var min: CGFloat = 0
		for i in self.currentPage..<self.pages.count {
			let page = self.pages[i]
			if vert {
				page.minY = min
				min = page.maxY
			}
			else {
				page.minX = min
				min = page.maxX
			}
			self.scrollView.addSubview(page)
		}
		var max: CGFloat = 0
		var i = self.currentPage - 1
		while i >= 0 {
			let page = self.pages[i]
			if vert {
				page.maxY = max
				max = page.minY
			}
			else {
				page.maxX = max
				max = page.minX
			}
			self.scrollView.addSubview(page)
			i -= 1
		}
	}
	
	
	// MARK: UIScrollViewDelegate
	
	public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let vert = self.scrollDirection == .vertical
		if vert && scrollView.contentOffset.y + scrollView.height > scrollView.contentHeight {
			self.scrollToNextPage()
		}
		else if vert && scrollView.contentOffset.y < 0 {
			self.scrollToPreviousPage()
		}
		else if !vert && scrollView.contentOffset.x + scrollView.width - 30 > scrollView.contentWidth {
			self.scrollToNextPage()
		}
		else if !vert && scrollView.contentOffset.x < -30 {
			self.scrollToPreviousPage()
		}

		self.delegate?.pagedScrollViewDidEndDragging?(pagedScrollView: self, willDecelerate: decelerate)

	}
	
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		self.delegate?.pagedScrollViewDidScroll?(pagedScrollView: self)
	}
	
	public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		self.delegate?.pagedScrollViewWillBeginDragging?(pagedScrollView: self)
	}
	
	public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		self.delegate?.pagedScrollViewWillBeginDecelerating?(pagedScrollView: self)
	}
	
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		self.delegate?.pagedScrollViewDidEndDecelerating?(pagedScrollView: self)
	}
	
	public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		self.delegate?.pagedScrollViewDidEndScrollingAnimation?(pagedScrollView: self)
	}
	
	public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
		if let top = self.delegate?.pagedScrollViewShouldScrollToTop?(pagedScrollView: self){
			return top
		}
		return self.scrollDirection == .vertical
	}
	
	public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
		self.delegate?.pagedScrollViewDidScrollToTop?(pagedScrollView: self)
	}
	
	
	// MARK: PROPERTIES
	
	public var pages : [UIView] {
		
		set (thePages){
			_pages.forEach { $0.removeFromSuperview() }
			_pages = thePages
			_setupPages()
		}
		get{
			return _pages
		}
		
	}
	public var currentPage : Int {

		didSet{
			_setupPages()
		}
	}
	
	private(set) public var scrollDirection : TKPageScrollDirection
	public var scrollView : UIScrollView
	public var animatingPages : Bool
	public var delegate : TKPagedScrollViewDelegate?
	
	


}
