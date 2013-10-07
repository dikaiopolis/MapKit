//
//  ViewController.h
//  MapIt
//
//  Created by Daniel Baldwin on 10/7/13.
//  Copyright (c) 2013 Daniel Baldwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
- (IBAction)onUpdateLocationPressed:(id)sender;

@end
