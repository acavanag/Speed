//
//  WWLocationManager.h
//  Speed
//
//  Created by Andrew Cavanagh on 5/25/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol WWLocaltionManagerDelegate <NSObject>
- (void)didUpdateLocation:(CLLocation *)location;
@end

@interface WWLocationManager : NSObject <CLLocationManagerDelegate>
+ (WWLocationManager *)sharedInstance;
- (void)run;
- (void)stop;
@property (nonatomic, weak) id<WWLocaltionManagerDelegate> delegate;
@end
