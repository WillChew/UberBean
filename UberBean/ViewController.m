//
//  ViewController.m
//  UberBean
//
//  Created by Will Chew on 2018-06-22.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "NetworkManager.h"

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSArray *cafes;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [NetworkManager getCafesAtLatitude:@"43.6446" andLongitude:@"-79.3950" completion:^(NSArray<Cafe*>*cafes) {
        self.cafes = cafes;
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            NSLog(@"WORKING");
            
        }];
    }];





self.locationManager = [[CLLocationManager alloc]init];
self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
self.locationManager.distanceFilter = 20;
self.locationManager.delegate = self;
[self.locationManager requestWhenInUseAuthorization];
[self.locationManager requestLocation];

self.mapView.delegate = self;
self.mapView.showsUserLocation = YES;



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    }
}






-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = locations[0];
    NSLog(@"Got location");
    [self.mapView setRegion:MKCoordinateRegionMake(loc.coordinate, MKCoordinateSpanMake(0.1, 0.1)) animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"Error : %@" , error.localizedDescription);
    }
}

@end
