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
#import "CustomTransitionViewController.h"
#import "ConfettiViewController.h"
#import "ZoomViewController.h"
#import "WiggleViewController.h"
#import "ShakeAnimationViewController.h"
#import "RunForrestViewController.h"
#import "NavigationPushPopTransitionViewController.h"


@implementation RootViewController
#define IDENTIFIER @"cellIdentifier"

- (void) viewDidLoad{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Examples", @"");
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER];
    self.items = @[NSLocalizedString(@"TKMoveGestureRecognizer", @""),
                   NSLocalizedString(@"Material Transition", @""),
                   NSLocalizedString(@"Card SlideUp", @""),
                   NSLocalizedString(@"Custom Transition", @""),
                   NSLocalizedString(@"Confetti", @""),
                   NSLocalizedString(@"Zoom", @""),
                   NSLocalizedString(@"Wiggle", @""),
                   NSLocalizedString(@"Shake", @""),
                   NSLocalizedString(@"Run Forrest Run", @"")];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *ctr;
    
    if(indexPath.row == 0)
        ctr = MoveGestureViewController.new;
    else if(indexPath.row == 1)
        ctr = MaterialViewController.new;
    else if(indexPath.row == 2)
        ctr = CardViewSlideUpViewController.new;
    else if(indexPath.row == 3)
        ctr = NavigationPushPopTransitionViewController.new;
    else if(indexPath.row == 4)
        ctr = ConfettiViewController.new;
    else if(indexPath.row == 5)
        ctr = ZoomViewController.new;
    else if(indexPath.row == 6)
        ctr = WiggleViewController.new;
    else if(indexPath.row == 7)
        ctr = ShakeAnimationViewController.new;
    else if(indexPath.row == 8)
        ctr = RunForrestViewController.new;
    
    
    
    
    [self.navigationController pushViewController:ctr animated:YES];
    
}

@end
