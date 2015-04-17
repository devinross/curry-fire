//
//  UILabel+Initializers.m
//  Created by Devin Ross on 4/17/15.
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

#import "UILabel+Initializers.h"

@implementation UILabel (Initializers)

+ (instancetype) labelWithFrame:(CGRect)frame attributedText:(NSAttributedString*)attributedText font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    return [[[self class] alloc] initWithFrame:frame attributedText:attributedText font:font textColor:textColor textAlignment:alignment];
}
- (instancetype) initWithFrame:(CGRect)frame attributedText:(NSAttributedString*)attributedText font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    self = [self initWithFrame:frame];
    
    self.textColor = textColor;
    self.font = font;
    self.attributedText = attributedText;
    self.textAlignment = alignment;

    return self;
}

+ (instancetype) labelWithFrame:(CGRect)frame text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    return [[[self class] alloc] initWithFrame:frame text:text font:font textColor:textColor textAlignment:alignment];
}
- (instancetype) initWithFrame:(CGRect)frame text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    self = [self initWithFrame:frame];
    
    self.textColor = textColor;
    self.textAlignment = alignment;
    self.font = font;
    self.text = text;
    
    return self;
}

+ (instancetype) labelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    return [[[self class] alloc] initWithFrame:frame font:font textColor:textColor textAlignment:alignment];
}
- (instancetype) initWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    self = [self initWithFrame:frame];
    
    self.textColor = textColor;
    self.textAlignment = alignment;
    self.font = font;
    
    return self;
}

+ (instancetype) labelWithFrame:(CGRect)frame textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    return [[[self class] alloc] initWithFrame:frame textColor:textColor textAlignment:alignment];
}
- (instancetype) initWithFrame:(CGRect)frame textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    self = [self initWithFrame:frame];
    
    self.textColor = textColor;
    self.textAlignment = alignment;

    return self;
}

+ (instancetype) labelWithFrame:(CGRect)frame attributedText:(NSAttributedString*)attributedText textAlignment:(NSTextAlignment)alignment{
    return [[[self class] alloc] initWithFrame:frame attributedText:attributedText textAlignment:alignment];
}
- (instancetype) initWithFrame:(CGRect)frame attributedText:(NSAttributedString*)attributedText textAlignment:(NSTextAlignment)alignment{
    self = [self initWithFrame:frame];
    
    self.attributedText = attributedText;
    self.textAlignment = alignment;
    
    return self;
}

+ (instancetype) labelWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    return [[[self class] alloc] initWithFrame:frame text:text textColor:textColor textAlignment:alignment];
}
- (instancetype) initWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
    self = [self initWithFrame:frame];
    
    self.textColor = textColor;
    self.textAlignment = alignment;
    self.text = text;
    
    return self;
}


@end
