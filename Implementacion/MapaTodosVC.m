//
//  MapaTodosVC.m
//  proyectoFarmaciOS
//
//  Created by Alvaro Herrera on 31/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import "MapaTodosVC.h"
#import "AFNetworking.h"
#import "Local.h"
@interface MapaTodosVC ()
{
    NSArray *data;
    NSMutableArray *locales;
}
@end

@implementation MapaTodosVC

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
    
    UIImage *buttonImage = [UIImage imageNamed:@"btnBack.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0,0.0,20,20);
    [aButton addTarget:self action:@selector(regresar)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"Ubicaciones";
    
    //SPinner
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    HUD.labelText=@"Cargando Ubicaciones";
	[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    
    [self Service];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)regresar {
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) locateAnnotation
{
    for (int i=0; i<locales.count; i++) {
        
        CLLocationCoordinate2D coordinate;
        NSString  *t1 = ((Local*)[locales objectAtIndex:i]).Latitud;
        NSString  *t2 = ((Local*)[locales objectAtIndex:i]).Longitud;
        
        coordinate.latitude = [t1 floatValue];
        coordinate.longitude = [t2 floatValue];
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate;
        [self.mapa addAnnotation:point];
    }
 
    [HUD removeFromSuperview];
 
    
}

-(void) Service
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    
    NSDictionary *params = @{};
    
    
    [manager POST:@"http://mifarma.katucms.com/api/get-drug-stores?apikey=1D2C49CB91C134A76E2AEC6DBFB2A" parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         
         data=[responseObject objectForKey:@"drug_stores"];
         locales = [NSMutableArray array];
         
         
         for(NSDictionary *dict in data)
         {
             Local *obj = [[Local alloc] init];
             obj.Latitud = [dict objectForKey:@"c_latitud_drug_store"];
             obj.Longitud = [dict objectForKey:@"c_longitud_drug_store"];
             [locales addObject:obj];
         }
         NSLog(@"JSON: %@", locales);
         
         [self locateAnnotation];
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
     }];


}

- (void)myTask {
    sleep(20);
}
@end
