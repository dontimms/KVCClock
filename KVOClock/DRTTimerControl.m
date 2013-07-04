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
    NSString * timeString; // time string is visible and contains the string

}

NSNumber * sliderValue; // this is the update rate of the timer
NSTimer * timer;
NSInteger counter;

// start the timer on init
- (id)init
{
    self = [super init];
    if (self) {
        [self setInterruptRate:[NSNumber numberWithFloat:10.0]];
        [self addObserver:self forKeyPath:@"sliderValue" options:NSKeyValueObservingOptionNew context:nil];
        counter = 0;
    }
    return self;
}

// called
-(NSString *)timeString
{
    // get current time (down to 1/10's)
    counter ++;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormtter = [[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"HH:mm:ss"];
    NSString * dateCount = [[NSString alloc] initWithFormat:@"%@ %4i",[dateFormtter stringFromDate:date],counter];
    if( !(counter % 1000) ) counter = 0;
    return dateCount;

}

-(void)setTimeString
{
    [self setValue:[self timeString] forKey:@"timeString"];
}

-(NSNumber *)sliderValue
{
    return sliderValue;
}

-(void)setSliderValue
{
 //   [self setValue:@2.0 forKey:@"sliderValue"];
}

-(void)setSValue:(float)value
{
    NSNumber * num = [NSNumber numberWithFloat:value];
    sliderValue = num;
    [self setValue:[self sliderValue] forKey:@"sliderValue"];
}

// invoked only at init & when slider changes value.
-(void)setInterruptRate:(NSNumber *)rate
{
    // bracket rate
    float timerInterval = [rate floatValue] * 10.;
    if( timerInterval < 0.25 ) timerInterval = 0.25;
    if( timerInterval > 10.0) timerInterval = 10.0;
    
    // clear timer interrupt
    if( timer ) [timer invalidate];
    
    // set new timer interrupt at current rate
    timer = [NSTimer scheduledTimerWithTimeInterval:1/timerInterval target:self selector:@selector(setTimeString) userInfo:nil repeats:YES];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if( [keyPath isEqualToString:@"sliderValue"]) {
        NSNumber * num = [change objectForKey:@"new"];
        [self setInterruptRate:num];
    }
}

@end
