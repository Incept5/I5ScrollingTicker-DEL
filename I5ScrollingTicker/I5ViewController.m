//
//  I5ViewController.m
//  I5ScrollingTicker
//
//  Created by Denis Bregeon on 4/6/13.
//  Copyright (c) 2013 Incept5. All rights reserved.
//

#import "I5ViewController.h"

@interface I5ViewController ()

@end

@implementation I5ViewController {
    NSMutableArray * twits;
}

@synthesize tickerView;

- (NSString *) title
{
    return @"Example Stream";
}

- (NSAttributedString *) nextTicker
{
    NSAttributedString * result = nil;
    if ([twits count] > 0)
    {
        result = [twits objectAtIndex:0];
        [twits removeObjectAtIndex:0];
        if ([twits count] < 10)
        {
            [twits addObject:result];
        }
    }
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    twits = [NSMutableArray arrayWithObjects:[[NSAttributedString alloc] initWithString:@"First Text" ], [[NSAttributedString alloc] initWithString:@"Second Text"], [[NSAttributedString alloc] initWithString:@"And a very long text that will not fit in a single row"], nil];
    [tickerView stopAnimating];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tickerView startAnimating];
    });
}

- (void) viewWillDisappear:(BOOL)animated
{
    [tickerView stopAnimating];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


#pragma mark - Table view delegate

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [tickerView stopAnimating];
}


@end
