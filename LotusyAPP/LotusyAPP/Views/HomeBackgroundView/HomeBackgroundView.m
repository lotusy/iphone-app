//
//  HomeBackgroundView.m
//  LotusyApp
//
//  Created by Allen on 2015-06-09.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "HomeBackgroundView.h"

#define HOME_BACKGROUND_COLOR [UIColor colorWithRed:0.984 green:0.863 blue:0.314 alpha:1.000]

@interface HomeBackgroundView ()
@property (strong, nonatomic) CAEmitterLayer *emitterLayer;
@end

@implementation HomeBackgroundView

+ (Class)layerClass {
    return [CAEmitterLayer class];
}

- (void)awakeFromNib {
    
    self.backgroundColor = HOME_BACKGROUND_COLOR;
    
    NSMutableArray *emitterCells = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i<16; i++) {
        NSString *name = [NSString stringWithFormat:@"foodsbg-%ld", (long)i];
        CAEmitterCell *cell = [self newFoodsbgCellsWithName:name];
        [emitterCells addObject:cell];
    }
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    _emitterLayer = (CAEmitterLayer *)self.layer;
    _emitterLayer.emitterPosition = CGPointMake(width/2, height/2);
    _emitterLayer.emitterSize = frame.size;
    _emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    _emitterLayer.emitterCells = emitterCells;
    _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CAEmitterCell *)newFoodsbgCellsWithName:(NSString *)name {
    
    UIImage *image = [[UIImage imageNamed:name]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (id)[image CGImage];
    cell.name = name;
    cell.scale = 0.2f;
    cell.scaleRange = 0.1f;
    
    cell.lifetime = 20.0f;
    cell.lifetimeRange = 4.25f;
    cell.birthRate = 0.1;
    
    cell.velocity = 5.0f;
    cell.velocityRange = 30.0f;
    cell.emissionRange = M_PI;
    cell.emissionLatitude = -M_PI_2;
    
    return cell;
}

- (void)animated:(BOOL)animated {
    _emitterLayer.speed = animated ? 1 : 0;
}

@end
