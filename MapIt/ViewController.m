//
//  ViewController.m
//  MapIt
//
//  Created by Daniel Baldwin on 10/7/13.
//  Copyright (c) 2013 Daniel Baldwin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CLLocationManager *locationManager;
    MKCoordinateSpan span;
    NSDictionary *searchAddressDictionary;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    CLLocationCoordinate2D mobileMakersLocation;
    mobileMakersLocation.latitude = 41.893740;
    mobileMakersLocation.longitude = -87.635330;
    
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    
    MKCoordinateRegion region;
    region = MKCoordinateRegionMake(mobileMakersLocation, span);
    _myMapView.region = region;
    
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = mobileMakersLocation;
    point.title = @"Mobile Makers Academy";
    
    _myMapView.centerCoordinate = mobileMakersLocation;
    [_myMapView addAnnotation:point];
    

    
    region = MKCoordinateRegionMake(mobileMakersLocation, span);
    _myMapView.region = region;



}
- (IBAction)onUpdateLocationPressed:(id)sender {
    
    NSString *a = @"http://maps.googleapis.com/maps/api/geocode/json?address=";
    NSString *c = @"&sensor=false";
    NSMutableString *searchField = [[NSMutableString alloc] init];
    
    searchField = _firstTextField.text.mutableCopy;
    searchField = [searchField stringByReplacingOccurrencesOfString:@" " withString:@"+"].mutableCopy;
    NSString *newAddress = [NSString stringWithFormat:@"%@%@%@", a, searchField, c];
    
    NSURL *url = [NSURL URLWithString:newAddress];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         searchAddressDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&connectionError];
         
         
         NSArray *resultsArray = [[NSArray alloc] init];
         resultsArray = [searchAddressDictionary objectForKey:@"results"];
         
         
         NSDictionary *secondDictionary = [[NSDictionary alloc] init];
         secondDictionary = [resultsArray objectAtIndex:0];
         
         NSDictionary *thirdDictionary = [[NSDictionary alloc] init];
         thirdDictionary = secondDictionary[@"geometry"][@"location"];
         
         NSString *latitude = [[NSString alloc] init];
         latitude = [thirdDictionary objectForKey:@"lat"];
         NSString *longitude = [[NSString alloc] init];
         longitude = [thirdDictionary objectForKey:@"lng"];
         
         NSLog(@"%@", latitude);
         NSLog(@"%@", longitude);
         
         CLLocationCoordinate2D  newLocation;
         newLocation.latitude = latitude.doubleValue;
         newLocation.longitude = longitude.doubleValue;
         
         _myMapView.centerCoordinate = newLocation;
         
         
         MKCoordinateRegion newRegion;
         newRegion = MKCoordinateRegionMake(newLocation, span);
         [_myMapView setRegion:newRegion animated:YES];
         
         MKPointAnnotation *newPoint = [[MKPointAnnotation alloc] init];
         newPoint.coordinate = newLocation;
         [_myMapView addAnnotation:newPoint];
         
         
         [_firstTextField resignFirstResponder];
         [_secondTextField resignFirstResponder];
      }];



    
 

    

    
}
@end
