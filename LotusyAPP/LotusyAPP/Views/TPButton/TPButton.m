//
//  TPButton.m
//  LotusyApp
//
//  Created by Allen on 2015-05-15.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "TPButton.h"

#define DEFAULT_BUTTON_IMAGE_NAME @"takePhotoButton"

@interface TPButton ()
@property (nonatomic, strong) UIImage *image;
@end

@implementation TPButton

- (void)awakeFromNib {
    [super awakeFromNib];
    _image = [UIImage imageNamed: DEFAULT_BUTTON_IMAGE_NAME];
}

- (void)drawRect:(CGRect)rect {
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor *strokeColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.45];
    
    //// Image Declarations
    UIImage *image = _image;
    
    //// Oval Drawing
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(5, 5, 190, 190)];
    CGContextSaveGState(context);
    [ovalPath addClip];
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawTiledImage(context, CGRectMake(6, -6, image.size.width, image.size.height), image.CGImage);
    CGContextRestoreGState(context);
    [strokeColor setStroke];
    ovalPath.lineWidth = 8;
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
