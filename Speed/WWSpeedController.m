//
//  WWSpeedController.m
//  Speed
//
//  Created by Andrew Cavanagh on 5/25/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "WWSpeedController.h"

typedef enum {
    kMPH = 0,
    kKPH = 1
} UnitMode;

@interface WWSpeedController ()
{
    UnitMode units;
}
@property (weak, nonatomic) IBOutlet UIButton *unitsButton;
@property (nonatomic, assign) CLLocationSpeed speed;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@end

static const double mphFactor = 2.23694;
static const double kphFactor = 3.6;

@implementation WWSpeedController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    units = kMPH;
    [self.unitsButton setTintColor:[UIColor whiteColor]];
    [[WWLocationManager sharedInstance] setDelegate:self];
    [[WWLocationManager sharedInstance] run];
}

- (void)didUpdateLocation:(CLLocation *)location
{
    _speed = location.speed;
    [self updateSpeedLabel];
}

- (IBAction)toggleUnits:(id)sender
{
    if (units == kMPH) units = kKPH;
    else if (units == kKPH) units = kMPH;
    [self updateSpeedLabel];
}

- (void)updateSpeedLabel
{
    NSString *speedString = nil;
    if (units == kMPH) speedString = [NSString stringWithFormat:@"%.1f mph", _speed*mphFactor];
    else if (units == kKPH) speedString = [NSString stringWithFormat:@"%.1f kph", _speed*kphFactor];
    
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:speedString];
    [mString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:128] range:NSMakeRange(0, speedString.length-6)];
    [mString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:32] range:NSMakeRange(speedString.length-6, 2)];
    [mString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] range:NSMakeRange(speedString.length-4, 4)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.speedLabel setAttributedText:mString];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
