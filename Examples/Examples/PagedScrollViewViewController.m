//
//  PagedScrollViewViewController.m
//  Created by Devin Ross on 6/18/15.
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

#import "PagedScrollViewViewController.h"


@implementation PagedScrollViewViewController

- (void) loadView{
    [super loadView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.scrollView = [[TKPagedScrollView alloc] initWithFrame:self.view.bounds direction:TKPageScrollDirectionVertical];
    self.scrollView.delegate = self;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.scrollView];

    
    UIView *viewOne = [UIView viewWithFrame:CGRectMake(0, 0, self.view.width, 1000) backgroundColor:[UIColor randomColor]];
    
    TKGradientView *gradient = [[TKGradientView alloc] initWithFrame:viewOne.bounds];
    gradient.colors = @[[UIColor colorWithWhite:0 alpha:0.0],[UIColor colorWithWhite:0 alpha:0.5]];
    [viewOne addSubview:gradient];
    
    UIView *viewTwo = [UIView viewWithFrame:CGRectMake(0, viewOne.maxY, self.view.width, 2000) backgroundColor:[UIColor randomColor]];

    gradient = [[TKGradientView alloc] initWithFrame:viewTwo.bounds];
    gradient.colors = @[[UIColor colorWithWhite:0 alpha:0.0],[UIColor colorWithWhite:0 alpha:0.5]];
    [viewTwo addSubview:gradient];
    
    UIView *viewThree = [UIView viewWithFrame:CGRectMake(0, viewTwo.maxY, self.view.width, 2000) backgroundColor:[UIColor randomColor]];

    UIView *viewFour = [UIView viewWithFrame:CGRectMake(0, viewThree.maxY, self.view.width, 3000) backgroundColor:[UIColor randomColor]];

    self.scrollView.pages = @[viewOne,viewTwo,viewThree,viewFour];
    
    

}





@end
