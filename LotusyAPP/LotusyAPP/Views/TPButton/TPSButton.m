//
//  TPSButton.m
//  LotusyApp
//
//  Created by Allen on 2015-06-06.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "TPSButton.h"

#define DEFAULT_BUTTON_IMAGE_NAME @"takePhotoSmallButton"

@interface TPSButton ()
@property (nonatomic, strong) UIImage *image;
@end

@implementation TPSButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.image = [UIImage imageNamed: DEFAULT_BUTTON_IMAGE_NAME];
    
    [self setImage:[UIImage imageNamed:@"icn-camera"] forState:UIControlStateNormal];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 35,
                                                                           self.frame.size.height - 35,
                                                                           35,
                                                                           35)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"bunlevel1"];
    [self addSubview:imageView];
}

- (void)drawRect:(CGRect)rect {
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor *strokeColor = [UIColor colorWithRed: 0.984 green: 0.863 blue: 0.314 alpha: 1];
    
    //// Image Declarations
    UIImage *image = _image;
    
    //// Shadow Declarations
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: [UIColor colorWithWhite:0.0 alpha:0.5]];
    [shadow setShadowOffset: CGSizeMake(0.1, -0.1)];
    [shadow setShadowBlurRadius: 7];

    
    //// Oval Drawing
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(5, 5, 100, 100)];
    CGContextSaveGState(context);
    
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
    [strokeColor setFill];
    [ovalPath fill];

    [ovalPath addClip];
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawTiledImage(context, CGRectMake(5.5, -5.5, image.size.width, image.size.height), image.CGImage);
    CGContextRestoreGState(context);
    
    [strokeColor setStroke];
    ovalPath.lineWidth = 5;
    [ovalPath stroke];
    
}

- (void)setImage:(UIImage *)image {
    if (_image == image) {
        return;
    }
    _image = image;
    
    [UIView transitionWithView:self
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self setTitle:@""
                              forState:UIControlStateNormal];
                        [self setBackgroundImage:nil
                                        forState:UIControlStateNormal];
                        [self setImage:nil
                              forState:UIControlStateNormal];
                        [self setNeedsDisplay];
                    } completion:^(BOOL finished) {
                        
                    }];
}

@end
