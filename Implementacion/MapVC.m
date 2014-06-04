//
//  MapVC.m
//  proyectoFarmaciOS
//
//  Created by TKJ on 5/28/14.
//  Copyright (c) 2014 Alvaro Herrera. All rights reserved.
//

#import "MapVC.h"

@interface MapVC ()

@end

@implementation MapVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    UIImage *buttonImage = [UIImage imageNamed:@"btnBack.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0,0.0,20,20);
    [aButton addTarget:self action:@selector(regresar)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"Ubicación";
    
    CLLocationCoordinate2D coordinate;
    float t1 = -12.119203;
    float t2 = -77.035832;
    coordinate.latitude = t1;
    coordinate.longitude = t2;
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    [self.mapView addAnnotation:point];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.01;
    span.longitudeDelta=0.01;

    CLLocationCoordinate2D location= point.coordinate = coordinate;
    region.span=span;
    region.center=location;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)regresar {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
