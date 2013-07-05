//
//  DRTViewController.m
//  KVOClock
//
//  Created by don on 7/3/13.
//  Copyright (c) 2013 Don Timms. All rights reserved.
//

#import "DRTViewController.h"
#import "DRTTimerControl.h"

@interface DRTViewController ()

@end


@implementation DRTViewController
{
    DRTTimerControl * timerControl;
    // 3/3 declared instance varible for key (put it in implementation{}
    NSNumber * sliderValueLocalKey;
    Boolean sliderDoneLocalKey;
}

@synthesize doTimeLabel;
@synthesize doUpdateLabel;
@synthesize doSliderStateLabel;
@synthesize sliderOutlet;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    timerControl = [[DRTTimerControl alloc] init];  // start the timer
    // add observers
    [timerControl addObserver:self forKeyPath:@"timeStringSharedKey" options:NSKeyValueObservingOptionNew context:nil];
//    [timerControl addObserver:self forKeyPath:@"timerRateSharedKey" options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:@"sliderValueLocalKey" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"sliderDoneLocalKey" options:NSKeyValueObservingOptionNew context:nil];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - accessor methods for sliderValueLocalKey
// 2/3. accesor method for key
-(NSNumber *) sliderValueLocalKey
{
    return [NSNumber numberWithFloat:sliderOutlet.value];
}

// 2/3. set accessor method for key
-(void) setSliderValueLocalKey
{
    NSNumber * num = [self sliderValueLocalKey];
    [self setValue:num forKey:@"sliderValueLocalKey"];
}

-(Boolean)sliderDoneLocalKey
{
    return true;
}

#pragma mark - slider states for understanding the slider options
- (IBAction)sliderTouchDown:(id)sender
{
}

- (IBAction)sliderTouchDragInside:(id)sender
{
}

// update the slider as values change
- (IBAction)sliderValueChanged:(id)sender
{
    [self setSliderValueLocalKey];
}

// this happens when sliding is done, and this will update the actual rate variable.
- (IBAction)sliderTouchUpOutside:(id)sender
{
    [self setValue:@0.0 forKey:@"sliderDoneLocalKey"];
}

- (IBAction)sliderTouchDragExit:(id)sender {
}

- (IBAction)sliderTouchCancel:(id)sender {
    NSLog(@"");
}

- (IBAction)sliderTouchDragOutside:(id)sender {
}

- (IBAction)sliderTouchUpInside:(id)sender {

    // set this using the method in timerControl.
    [self setValue:@0.0 forKey:@"sliderDoneLocalKey"];

}

- (IBAction)sliderTouchDragEnter:(id)sender {
}

#pragma mark - key observer for this process
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if( [keyPath isEqualToString:@"timeStringSharedKey"]) {
        doTimeLabel.text = [change objectForKey:@"new"];
//        NSLog(@"keypath: %@", keyPath);
 //       NSLog(@"object: %@", object);
//        NSLog(@"change: %@", change);
//        NSLog(@"context: %@", context);
    }
    if( [keyPath isEqualToString:@"sliderValueLocalKey"]) {
        //doTimeLabel.text = [change objectForKey:@"new"].value;
        NSString * ts = [[NSString alloc] initWithFormat:@"%2@",[change objectForKey:@"new"]];
        doUpdateLabel.text = ts;
    }
    if( [keyPath isEqualToString:@"sliderDoneLocalKey"]) {
        NSLog(@"keypath: %@", keyPath);
        NSLog(@"object: %@", object);
        NSLog(@"change: %@", change);
        NSLog(@"context: %@", context);
        NSLog(@"Slider out %@", [self valueForKey:@"sliderValueLocalKey"]);
        // execution gets here when timerRateSharedKey is set, simply update the rate in timerControl
        [timerControl doRateValue:[self valueForKey:@"sliderValueLocalKey"]];
//        [timerControl setValue:[self sliderValueLocalKey] forKey:@"setTimerRateSharedKey"];
//        [timerControl setTimerRate:[change objectForKey:@"new"]];
    }
}
@end
