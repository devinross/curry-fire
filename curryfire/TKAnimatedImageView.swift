//
//  TKAnimatedImageView.swift
//  Created by Devin Ross on 9/26/16.
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

/** `TKAnimatedImageView` is a reimplementation of UIImageView animated images with better access to the current frame in the animation sequence. */
public class TKAnimatedImageView: UIImageView {
	
	/** Play an animation sequence with the given image frames.
	@param images A array of `UIImage` objects.
	@param duration The duration of the animation.
	@param completion The completion block called upon the animation completing.
	*/
	public func playAnimation(with images: [UIImage], duration: TimeInterval, withCompletionBlock finished: ((_ finished: Bool) -> Void)?) {
		self.playAnimation(with: images, duration: duration, repeatCount: 1, withCompletionBlock: finished)
	}
	
	/** Play an animation sequence with the given image frames.
	@param images A array of `UIImage` objects.
	@param duration The duration of the animation.
	@param repeatCount The number of times the animation sequence plays.
	@param completion The completion block called upon the animation completing.
	*/
	public func playAnimation(with images: [UIImage], duration: TimeInterval, repeatCount: Int, withCompletionBlock finished: ((_ finished: Bool) -> Void)?) {
		if self.playingAnimation {
			self.animationDisplayLink.remove(from: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
			self.playingAnimation = false
			self.currentFrame = 0
			self.theImages = []
			if let block = self.completionBlock {
				block(false)
			}
			self.completionBlock = nil
		}
		if images.count < 1 || duration <= 0 {
			return
		}
		self.playingAnimation = true
		self.duration = duration
		self.loops = repeatCount
		self.theImages = images
		self.image! = images.first!
		self.completionBlock = finished
		self.startTime = -1
		self.animationDisplayLink.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
	}
	/** Stop animating. */
	
	override public func stopAnimating() {
		super.stopAnimating()
		if self.playingAnimation {
			self.animationDisplayLink.remove(from: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
			self.playingAnimation = false
			if let block = self.completionBlock {
				block(false)
			}
			self.theImages = []
		}
	}
	
	public var isPlayingAnimation: Bool {
		return self.playingAnimation
	}
	/** Returns the image of the current frame being displayed */
	public var currentImage: UIImage? {
		return self.theImages[self.currentFrame]
	}
	
	/** The current frame index. */
	private(set) public var currentFrame : Int = 0
	
	private let FRAME_RATE = 60.0
	
	func tick(_ sender: CADisplayLink) {
		if self.startTime < 0 {
			self.startTime = sender.timestamp
		}
		let timeLapse = sender.timestamp - self.startTime
		let perc : CGFloat = CGFloat(timeLapse) / CGFloat(self.duration)
		let loops = Int(floor(perc))
		if self.loops > 0 && loops == self.loops {
			self.image! = self.theImages.last!
			self.animationDisplayLink.remove(from: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
			self.playingAnimation = false
			
			if let block = self.completionBlock {
				block(true)
			}
			return
		}
		let framePerc: CGFloat = perc - CGFloat(loops)
		var ii : CGFloat = framePerc * CGFloat(self.theImages.count)
		ii = min(CGFloat(self.theImages.count - 1), ii)
		self.currentFrame = Int(ii)
		self.image = self.theImages[self.currentFrame]
	}

	
	
	lazy var animationDisplayLink : CADisplayLink = {
		var animationDisplayLink = CADisplayLink(target: self, selector: #selector( TKAnimatedImageView.tick(_:) ) )
		animationDisplayLink.frameInterval = 1
		return animationDisplayLink
	}()

	var theImages = [UIImage]()
	private var completionBlock : TKAnimationCompletionBlock?
	var startTime : CFTimeInterval = -1
	var duration : TimeInterval = 0
	var loops : Int = 0
	var playingAnimation = false
	
}
typealias TKAnimationCompletionBlock = (_ completed: Bool) -> Void
