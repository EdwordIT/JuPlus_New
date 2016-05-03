//
//  JuPlusGetLocation.m
//  JuPlus
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusGetLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface JuPlusGetLocation()<CLLocationManagerDelegate,MAMapViewDelegate,AMapSearchDelegate>
{
    AMapSearchAPI*  search;
}
@end

@implementation JuPlusGetLocation
DEF_SINGLETON(JuPlusGetLocation);

-(void)getLocation
{
    CLLocationManager * locManager = [[CLLocationManager alloc] init];
    locManager.delegate = self;
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locManager startUpdatingLocation];
    locManager.distanceFilter = 100.0f;
    self.locLong = locManager.location.coordinate.longitude?:121.491121;
    self.locLat = locManager.location.coordinate.latitude?:31.243466;
    if (self.locLong!=0) {
        [self getcityName];
    }
}
-(void)getcityName
{
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:self.locLat  longitude:self.locLong];
    regeoRequest.radius = 10000;
    regeoRequest.requireExtension = YES;
    search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:self];
    [search AMapReGoecodeSearch:regeoRequest];

}
#pragma mark=====定位功能以及反选==========
- (void)searchReGeocode
{
    
}
- (void)search:(id)searchRequest error:(NSString*)errInfo
{
   
    NSLog(@"error = %@",errInfo);
}
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSString *cityName =  response.regeocode.addressComponent.city;
    if([cityName isEqualToString:@""])
    {
        cityName = response.regeocode.addressComponent.province;
    }
    self.cityName = cityName;
}

@end
