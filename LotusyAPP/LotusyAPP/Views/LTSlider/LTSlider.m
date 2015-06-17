//
//  LTSlider.m
//  Slider
//
//  Created by Allen on 2015-06-03.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "LTSlider.h"

#define LT_SLIDER_THICKNESS 5

@implementation LTSlider

- (void)awakeFromNib {
    
    [self setThumbImage:[UIImage imageNamed:@"LT_thumb"] forState:UIControlStateNormal];
    [self setThumbImage:[UIImage imageNamed:@"LT_thumb"] forState:UIControlStateHighlighted];
    self.minimumTrackTintColor = [UIColor colorWithRed: 0.992 green: 0.878 blue: 0.404 alpha: 1];
    self.maximumTrackTintColor = [UIColor whiteColor];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)trackRectForBounds:(CGRect)bounds {
    
    return CGRectMake(bounds.origin.x,
                      self.frame.size.height/2 - LT_SLIDER_THICKNESS/2,
                      bounds.size.width,
                      LT_SLIDER_THICKNESS);
    
}

@end
