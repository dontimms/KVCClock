//
//  DRTViewController.h
//  KVOClock
//
//  Created by don on 7/3/13.
//  Copyright (c) 2013 Don Timms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRTViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *doTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *doUpdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *doSliderStateLabel;
@property (weak, nonatomic) IBOutlet UISlider *sliderOutlet;
- (IBAction)sliderTouchDown:(id)sender;
- (IBAction)sliderTouchDragInside:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)sliderTouchUpOutside:(id)sender;
- (IBAction)sliderTouchDragExit:(id)sender;
- (IBAction)sliderTouchDragOutside:(id)sender;
- (IBAction)sliderTouchUpInside:(id)sender;
- (IBAction)sliderTouchDragEnter:(id)sender;
- (IBAction)sliderTouchCancel:(id)sender;


@end
