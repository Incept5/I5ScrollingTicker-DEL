//
//  I5TickerView.m
//  ISITC
//
//  Created by Denis Bregeon on 4/5/13.
//  Copyright (c) 2013 Denis Bregeon. All rights reserved.
//

#import "I5ScrollingTickerView.h"

@implementation I5ScrollingTickerView {
    UILabel * frontLabel;
    UILabel * backLabel;
    BOOL isAnimating;
}

@synthesize dataSource;

- (void) initLabels
{
    frontLabel = [[UILabel alloc] init];
    backLabel = [[UILabel alloc] init];
    frontLabel.backgroundColor = [UIColor clearColor];
    backLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:frontLabel];
    [self addSubview:backLabel];
    // So that the labels are not overflowing the view.
    self.clipsToBounds = YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLabels];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initLabels];
    }
    return self;
}


- (UIFont *) font
{
    return frontLabel.font;
}

- (void) setDataSource:(id<I5ScrollingTickerViewDataSource>) d
{
    dataSource = d;
    [self stopAnimating];
}

- (void) startAnimating
{
    if (!isAnimating)
    {
        isAnimating = YES;
        [self swapTickers];
    }
}

- (void) setCenter:(CGPoint)center
{
    super.center = center;
    // Ensure the labels are vertically centered.
    frontLabel.center = CGPointMake(frontLabel.bounds.size.width / 2, self.bounds.size.height / 2);
    backLabel.center = CGPointMake(backLabel.bounds.size.width / 2, self.bounds.size.height / 2);
}

- (void) stopAnimating
{
    isAnimating = NO;
    frontLabel.text = [dataSource title];
    backLabel.text = [dataSource title];
    [frontLabel sizeToFit];
    [backLabel sizeToFit];
}

- (void) animateTickers
{
    if (backLabel.center.x + backLabel.bounds.size.width / 2 <= backLabel.superview.bounds.size.width)
    {
        UILabel * temp = backLabel;
        backLabel = frontLabel;
        frontLabel = temp;
        [self swapTickers];
    } else {
        [self keepMovingTicker];
    }
    
}

- (void) keepMovingTicker
{
    [UIView animateWithDuration:5 animations:^{
        backLabel.center = CGPointMake(backLabel.center.x - backLabel.superview.bounds.size.width, backLabel.center.y);
    } completion:^(BOOL finished) {
        if (finished)
        {
            [self animateTickers];
        }
    }];
}

- (void) swapTickers
{
    NSAttributedString * text = [dataSource nextTicker];
    if (text)
    {
        [backLabel setAttributedText: text];
        [backLabel sizeToFit];
    }
    backLabel.center = CGPointMake(self.bounds.size.width + backLabel.bounds.size.width / 2, self.bounds.size.height / 2);
    frontLabel.center = frontLabel.center;
    [UIView animateWithDuration:5 animations:^{
        backLabel.center = CGPointMake(backLabel.bounds.size.width / 2, backLabel.center.y);
        frontLabel.center = CGPointMake(frontLabel.center.x -self.bounds.size.width, frontLabel.center.y);
    } completion:^(BOOL finished) {
        if (finished)
        {
            [self animateTickers];
        }
    }];
    
}

@end
