//
//  LocationManager.m
//  Mo9Client
//
//  Created by ChenJian on 15/11/20.
//  Copyright © 2015年 mo9. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()<CLLocationManagerDelegate>
{
}
@property (nonatomic, copy) LocationResult block;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation LocationManager

+ (LocationManager *)manager {
    static LocationManager *__manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[LocationManager alloc] init];
    });
    return __manager;
}

- (void)startLocationCompletion:(LocationResult)completion {
    if (_locationManager) {
        [self destroy];
    }
    self.block = completion;
    [self startLocation];
}

- (void)startLocation {
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void)startGeoWith:(CLLocationCoordinate2D)coodinate {
    
}

- (void)willStartLocatingUser {
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.location = newLocation;
    [self.locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            if (placemarks.count>0) {
                CLPlacemark *m = placemarks[0];
                self.block(m.locality);
            }else {
                self.block(@"");
            }
            [self destroy];
        }else {
            self.block(@"");
            [self destroy];
        }
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.block(@"");
    [self destroy];

}

-(void)destroy {
    self.locationManager = nil;
    self.block = nil;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

@end
