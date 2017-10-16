//
//  SmartConfigAnimationView.m
//  BlubControlViewControler
//
//  Created by vsKing on 2017/10/16.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "SmartConfigAnimationView.h"


#define DefaultTime 0.05f




@interface SmartConfigAnimationView ()

@property (nonatomic, strong) NSMutableArray *imageViews;

@end


@implementation SmartConfigAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}

- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [NSMutableArray arrayWithCapacity:10];
    }
    return _imageViews;
}

- (NSArray *)images{
    
    return @[
             @"config_link_type_icon_smartconfig_1",
             @"config_link_type_icon_smartconfig_2",
             @"config_link_type_icon_smartconfig_3",
             @"config_link_type_icon_smartconfig_4",
             @"config_link_type_icon_smartconfig_5",
             @"config_link_type_icon_smartconfig_6",
             @"config_link_type_icon_smartconfig_7",
             @"config_link_type_icon_smartconfig_8",
             @"config_link_type_icon_smartconfig_9",
             @"config_link_type_icon_smartconfig_10"
             ];
    
}



- (void)initUI{
    
    
    for (int i = 0; i < 10; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:imageView];
        [imageView setImage:[UIImage imageNamed:[self images][i]]];
        [imageView setHidden:(i!=0)];
        [self.imageViews addObject:imageView];
        
    }
    
    
}



- (void)startAnimation{
    

    
    int count = self.imageViews.count;
    
    for (int i = 0; i < 10; i++) {
        UIImageView * imageView = [self.imageViews objectAtIndex:i];
        [imageView setHidden:NO];
        NSArray * animation = @[
                                  [self getAnimationWithFromValue:0.0 toValue:0.0 duration:DefaultTime*i beginTime:0],
                                  [self getAnimationWithFromValue:1.0 toValue:1.0 duration:DefaultTime beginTime:DefaultTime*i],
                                  [self getAnimationWithFromValue:0.0 toValue:0.0 duration:DefaultTime*(count-i-1) beginTime:DefaultTime*(i+1)]
                                  ];
        [imageView.layer addAnimation:[self groupAnimation:animation durTimes:DefaultTime*count Rep:HUGE] forKey:nil];

        
    }
    

}


- (void)stopAnimation{
    
    for (int i = 0; i < 10; i++) {
        UIImageView * imageView = [self.imageViews objectAtIndex:i];
        [imageView.layer removeAllAnimations];
        
        [imageView setHidden:(i!=0)];
        
    }
}



- (CABasicAnimation *)getAnimationWithFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(CGFloat)duration beginTime:(CGFloat)beginTime{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath : @"opacity" ]; // 必须写 opacity 才行。
    
    animation. fromValue = [NSNumber numberWithFloat : fromValue];
    
    animation. toValue = [NSNumber numberWithFloat : toValue]; // 这是透明度。
    
    animation. autoreverses = YES ;
    
    animation. duration = duration;
    
    animation. repeatCount = MAXFLOAT;
    
    animation. removedOnCompletion = NO ;
    
    animation. fillMode = kCAFillModeForwards ;
    
    animation.beginTime = beginTime;
    //    animation. timingFunction =[CAMediaTimingFunction functionWithName : kCAMediaTimingFunctionEaseIn ]; /// 没有的话是均匀的动画。
    
    return animation;
}




#pragma mark ===== 组合动画 -=============

-( CAAnimationGroup *)groupAnimation:( NSArray *)animationAry durTimes:( float )time Rep:( float )repeatTimes
{
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    
    animation. animations = animationAry;
    
    animation. duration = time;
    
    animation. removedOnCompletion = NO ;
    
    animation. repeatCount = repeatTimes;
    
    animation. fillMode = kCAFillModeForwards ;
    
    return animation;
    
}

@end
