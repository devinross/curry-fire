//
//  RootViewController.m
//  Created by Devin Ross on 4/22/15.
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

#import "RootViewController.h"
#import "MoveGestureViewController.h"
#import "MaterialViewController.h"
#import "CardViewSlideUpViewController.h"
#import "ConfettiViewController.h"
#import "ZoomViewController.h"
#import "WiggleViewController.h"
#import "ShakeAnimationViewController.h"
#import "RunForrestViewController.h"
#import "NavigationPushPopTransitionViewController.h"
#import "CounterViewController.h"
#import "ProgressRingViewController.h"
#import "ControlsViewController.h"
#import "BounceAnimatorViewController.h"
#import "PageControlViewController.h"

#import <Examples-Swift.h>


@implementation RootViewController
#define IDENTIFIER @"cellIdentifier"

- (void) viewDidLoad{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Examples", @"");
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER];
	
	NSArray *section1 = @[
  
  @[NSLocalizedString(@"Paged Scroll View", @""),       NSStringFromClass([PagedScrollViewViewController class])],
  @[NSLocalizedString(@"TKMoveGestureRecognizer", @""), NSStringFromClass([MoveGestureViewController class])],
  @[NSLocalizedString(@"TKMoveGestureRecognizer (Card Slide)", @""),            NSStringFromClass([CardViewSlideUpViewController class])],
  @[NSLocalizedString(@"Material Transition", @""),     NSStringFromClass([MaterialViewController class])],
  @[NSLocalizedString(@"Confetti", @""),                NSStringFromClass([ConfettiViewController class])],
  @[NSLocalizedString(@"Animated Counter", @""),        NSStringFromClass([CounterViewController class])],
  @[NSLocalizedString(@"Progress Ring", @""),           NSStringFromClass([ProgressRingViewController class])],
  @[NSLocalizedString(@"Bounce Animator", @""),          NSStringFromClass([BounceAnimatorViewController class])],
  @[NSLocalizedString(@"Page Control", @""),          NSStringFromClass([PageControlViewController class])],
  
  
    @[NSLocalizedString(@"Smooth Animation", @""),          NSStringFromClass([SmoothAnimationViewController class])],

  
  
  @[NSLocalizedString(@"Custom Controls", @""),         NSStringFromClass([ControlsViewController class])] ];
	
	NSArray *section2 = @[@[NSLocalizedString(@"Shake", @""),                   NSStringFromClass([ShakeAnimationViewController class])],
						  @[NSLocalizedString(@"Zoom", @""),                    NSStringFromClass([ZoomViewController class])],
						  @[NSLocalizedString(@"Wiggle", @""),                  NSStringFromClass([WiggleViewController class])],
						  @[NSLocalizedString(@"Run Forest", @""),				NSStringFromClass([RunForrestViewController class])],
						  @[NSLocalizedString(@"Tickle", @""),					NSStringFromClass([TickleViewController class])],
						  @[NSLocalizedString(@"Hop", @""),						NSStringFromClass([HopViewController class])],
						  @[NSLocalizedString(@"Dime", @""),					NSStringFromClass([DimeViewController class])]
						  ];
				   
	self.items = @[@{@"title" : @"", @"cells" : section1 },  @{@"title":@"Animations", @"cells" : section2 }];
	
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items[section][@"cells"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.section][@"cells"][indexPath.row][0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *ctr = NSClassFromString(self.items[indexPath.section][@"cells"][indexPath.row][1]).new;
    [self.navigationController pushViewController:ctr animated:YES];
    
}
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return self.items[section][@"title"];
}

@end
