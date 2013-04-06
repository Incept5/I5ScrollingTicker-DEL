//
//  I5TickerView.h
//  ISITC
//
//  Created by Denis Bregeon on 4/5/13.
//  Copyright (c) 2013 Denis Bregeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol I5ScrollingTickerViewDataSource <NSObject>

@required
- (NSString *) title;
- (NSAttributedString *) nextTicker;

@end

@interface I5ScrollingTickerView : UIView

@property (strong, nonatomic) IBOutlet id<I5ScrollingTickerViewDataSource> dataSource;
@property (readonly) UIFont * font;

- (void) startAnimating;
- (void) stopAnimating;

@end

