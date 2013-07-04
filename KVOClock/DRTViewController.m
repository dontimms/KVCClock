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
    float sliderValue;
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
    // add observer
    [timerControl addObserver:self forKeyPath:@"timeString" options:NSKeyValueObservingOptionNew context:nil];
    
//    [timerControl addObserver:self forKeyPath:@"timerRate" options:NSKeyValueObservingOptionNew context:nil];

    
    [self addObserver:self forKeyPath:@"sliderValue" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float) sliderValue
{
    return sliderOutlet.value;
}

-(void) setSliderValue
{
    [self setValue:@2.0 forKey:@"sliderValue"];
}

- (IBAction)sliderTouchDown:(id)sender
{
}

- (IBAction)sliderTouchDragInside:(id)sender
{
}

// update the slider as values change
- (IBAction)sliderValueChanged:(id)sender
{
    [self setSliderValue];
}

// this happens when sliding is done, and this will update the actual rate variable.
- (IBAction)sliderTouchUpOutside:(id)sender
{
//    [timerControl setValue:@2.0 forKey:@"timerRate"];
}

- (IBAction)sliderTouchDragExit:(id)sender {
}

- (IBAction)sliderTouchCancel:(id)sender {
    NSLog(@"");
}

- (IBAction)sliderTouchDragOutside:(id)sender {
}

- (IBAction)sliderTouchUpInside:(id)sender {
//    [self setValue:@2.0 forKey:@"timerRate"];
    // set this using the method in timerControl.
    [timerControl setSValue:[self sliderValue]];
}

- (IBAction)sliderTouchDragEnter:(id)sender {
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if( [keyPath isEqualToString:@"timeString"]) {
        doTimeLabel.text = [change objectForKey:@"new"];
//        NSLog(@"keypath: %@", keyPath);
 //       NSLog(@"object: %@", object);
//        NSLog(@"change: %@", change);
//        NSLog(@"context: %@", context);
    }
    if( [keyPath isEqualToString:@"sliderValue"]) {
        //doTimeLabel.text = [change objectForKey:@"new"].value;
        NSString * ts = [[NSString alloc] initWithFormat:@"%2@",[change objectForKey:@"new"]];
        doUpdateLabel.text = ts;
    }
    if( [keyPath isEqualToString:@"timerRate"]) {
        NSLog(@"keypath: %@", keyPath);
        NSLog(@"object: %@", object);
        NSLog(@"change: %@", change);
        NSLog(@"context: %@", context);
        //doTimeLabel.text = [change objectForKey:@"new"].value;
//        NSString * ts = [[NSString alloc] initWithFormat:@"%2@",[change objectForKey:@"new"]];
//        doUpdateLabel.text = ts;
//        [timerControl setTimerRate:[change objectForKey:@"new"]]
    }



}
@end
