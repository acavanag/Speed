//
//  WWLocationManager.m
//  Speed
//
//  Created by Andrew Cavanagh on 5/25/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "WWLocationManager.h"

@interface WWLocationManager()
@property (nonatomic, strong) CLLocationManager *locMgr;
@end

@implementation WWLocationManager

+ (WWLocationManager *)sharedInstance {
    static WWLocationManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        [_sharedInstance configure];
    });
    
    return _sharedInstance;
}

- (void)configure
{
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.delegate = self;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locMgr.distanceFilter = kCLDistanceFilterNone;
    self.locMgr.pausesLocationUpdatesAutomatically = NO;
}

- (void)run
{
    [self.locMgr startUpdatingLocation];
}

- (void)stop
{
    [self.locMgr stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (self.delegate) [self.delegate didUpdateLocation:[locations lastObject]];
}

@end
