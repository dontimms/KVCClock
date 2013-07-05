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
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];
}

- (IBAction)sliderTouchDragInside:(id)sender
{
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];}

// update the slider as values change
- (IBAction)sliderValueChanged:(id)sender
{
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];
    [self setSliderValueLocalKey];
}

// this happens when sliding is done, and this will update the actual rate variable.
- (IBAction)sliderTouchUpOutside:(id)sender
{
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];
    [self setValue:@0.0 forKey:@"sliderDoneLocalKey"];
}

- (IBAction)sliderTouchDragExit:(id)sender
{
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];
}

- (IBAction)sliderTouchCancel:(id)sender
{
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];
}

- (IBAction)sliderTouchDragOutside:(id)sender
{
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];
}

- (IBAction)sliderTouchUpInside:(id)sender
{
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];
    // set this using the method in timerControl.
    [self setValue:@0.0 forKey:@"sliderDoneLocalKey"];
}

- (IBAction)sliderTouchDragEnter:(id)sender
{
    doSliderStateLabel.text = [[NSString alloc] initWithFormat:@"%s",__FUNCTION__];
}

#pragma mark - key observer for this process
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if( [keyPath isEqualToString:@"timeStringSharedKey"]) {
        doTimeLabel.text = [change objectForKey:@"new"];

    }
    if( [keyPath isEqualToString:@"sliderValueLocalKey"]) {
        NSString * ts = [[NSString alloc] initWithFormat:@"%2@",[change objectForKey:@"new"]];
        doUpdateLabel.text = ts;
    }
    if( [keyPath isEqualToString:@"sliderDoneLocalKey"]) {
        [timerControl doRateValue:[self valueForKey:@"sliderValueLocalKey"]];

    }
}
@end
