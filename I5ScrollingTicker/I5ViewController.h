//
//  I5ViewController.h
//  I5ScrollingTicker
//
//  Created by Denis Bregeon on 4/6/13.
//  Copyright (c) 2013 Incept5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "I5ScrollingTickerView.h"

@interface I5ViewController : UIViewController<I5ScrollingTickerViewDataSource>

@property (strong, nonatomic) IBOutlet I5ScrollingTickerView * tickerView;

@end
