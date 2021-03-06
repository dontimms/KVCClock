//
//  DRTTimerControl.m
//  KVOClock
//
//  Created by don on 7/3/13.
//  Copyright (c) 2013 Don Timms. All rights reserved.
//

#import "DRTTimerControl.h"

@implementation DRTTimerControl
{
    NSString * timeStringSharedKey; // time string is visible and contains the string
}

// NSNumber * rateValueLocalKey; // this is the update rate of the timer
NSTimer * timer;
NSInteger counter;

// start the timer on init
- (id)init
{
    self = [super init];
    if (self) {
        [self setInterruptRate:[NSNumber numberWithFloat:10.0]];
        // observe the rateValue locally to set interrupts.
        [self addObserver:self forKeyPath:@"rateValueLocalKey" options:NSKeyValueObservingOptionNew context:nil];
        counter = 0;
    }
    return self;
}

-(NSString *)timeStringSharedKey
{
    // get current time (down to 1/10's)
//TODO: this seems to be called twice for each update. Why?
    counter ++;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormtter = [[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"HH:mm:ss"];
    NSString * dateCount = [[NSString alloc] initWithFormat:@"%@ %003i",[dateFormtter stringFromDate:date],counter];
    if( !(counter % 999) ) counter = 0;
    return dateCount;
}

-(void)setTimeStringSharedKey
{
//TODO: this may be calling timeStringSharedKey twice. Is the complaint? nd. to check.
    [self setValue:[self timeStringSharedKey] forKey:@"timeStringSharedKey"];
}

-(void)doRateValue:(NSNumber *)value
{
    NSNumber * num = value;
    [self setInterruptRate:num];
}

-(void)setInterruptRate:(NSNumber *)rate
{
    // bracket rate
    float timerInterval = [rate floatValue] * 10.;
    if( timerInterval < 0.25 ) timerInterval = 0.25;
    if( timerInterval > 10.0) timerInterval = 10.0;
    
    // clear timer interrupt
    if( timer ) [timer invalidate];
    
    // set new timer interrupt at current rate
    timer = [NSTimer scheduledTimerWithTimeInterval:1/timerInterval target:self selector:@selector(setTimeStringSharedKey) userInfo:nil repeats:YES];
}
@end
