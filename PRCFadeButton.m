//
//  PRCFadeButton.m
//  Parachute
//
//  Created by Steven Mok on 16/4/25.
//  Copyright © 2016年 ZAKER. All rights reserved.
//

#import "PRCFadeButton.h"

@interface PRCFadeButton () {
    BOOL _realtimeHighlighted;
    BOOL _locksHighlighted;
}

@end

@implementation PRCFadeButton

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _fadeDuration = 0.15;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _fadeDuration = 0.15;
    }
    return self;
}

- (void)unlockHighlighed
{
    _locksHighlighted = NO;

    [self setHighlighted:_realtimeHighlighted];
}

- (void)lockHighlighted
{
    _locksHighlighted = YES;

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(unlockHighlighed) object:nil];
    [self performSelector:@selector(unlockHighlighed) withObject:nil afterDelay:_fadeDuration];
}

- (void)setHighlighted:(BOOL)highlighted
{
    _realtimeHighlighted = highlighted;

    BOOL oldValue = [self isHighlighted];

    if (oldValue != highlighted && !_locksHighlighted) {
        if (highlighted) {
            // lock highlight state for a moment then user can see this animation
            [self lockHighlighted];
        }

        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionFade;
        transition.duration = _fadeDuration;
        [self.layer addAnimation:transition forKey:@"FadeHighlight"];

        [super setHighlighted:highlighted];
    }
}

@end
