//
//  Farmacias.m
//  proyectoFarmaciOS
//
//  Created by Alvaro Herrera on 3/06/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import "Farmacias.h"
#import "FarmaciasCell.h"
#import "AFNetworking.h"
#import "Farmacia.h"
#import "LocalesVC.h"
#import "MapaTodosVC.h"
#import "DiamondActivityIndicator.h"
#import "FXBlurView.h"
#import "UIViewController+RESideMenu.h"


@interface Farmacias ()
{
    NSMutableArray *farmacias;
    
}
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;
@end

@implementation Farmacias

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

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(124/255.0) green:(156/255.0) blue:(55/255.0) alpha:1]];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320 , 580)];
    imgView.image = [UIImage imageNamed:@"fondo8.jpg"];
    [imgView setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:imgView];
    
    FXBlurView *blurView = [[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    blurView.blurRadius = 15.0f;
    blurView.alpha = 0.99f;
    [blurView setTintColor:[UIColor whiteColor]];
    [self.view addSubview:blurView];
    
    //configurando tabla
    self.tableView.frame = CGRectMake(10, 0, 300, 490);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [blurView addSubview:self.tableView];

    
    //SPinner
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    HUD.labelText=@"Cargando Datos";
	[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    
    UIImage *buttonImage = [UIImage imageNamed:@"general_top_button.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0,0.0,40,40);
    [aButton addTarget:self action:@selector(presentLeftMenuViewController:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"Farmacias";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(240.0f/255.0f) green:(243.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setNavigationBarHidden:NO];


    //esconder boton Back
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    //cache
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4;
    self.imageCache = [[NSCache alloc] init];
    

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{};
    
    [manager GET:@"http://farmaciosservices.somee.com/serviciofarmacia.svc/Farmacias" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *arr = responseObject;
        NSLog(@"JSON: %@", responseObject);
        farmacias = [NSMutableArray array];
        
        for(NSDictionary *dict in arr)
        {
            
            Farmacia *obj = [[Farmacia alloc]init];
            obj.NomFarmacia = [dict objectForKey:@"NomFarmacia"];
            obj.IdFarmacia = [dict objectForKey:@"IdFarmacia"];
            obj.FechaFundacion = [dict objectForKey:@"FechaFundacion"];
            obj.RutaIMG = [dict objectForKey:@"RutaIMG"];
            
            
            [farmacias addObject:obj];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];

}
- (void)myTask {
    sleep(20);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * idf =  ((Farmacia*)[farmacias objectAtIndex:indexPath.row]).IdFarmacia;
    NSLog(@"%@",idf);
    
    LocalesVC *lvc = [[LocalesVC alloc]initWithNibName:@"LocalesVC" bundle:nil];
    [self.navigationController pushViewController:lvc animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:idf forKey:@"idFarmacia"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void) goMap
{
    MapaTodosVC *mp = [[MapaTodosVC alloc]initWithNibName:@"MapaTodosVC" bundle:nil];
    [self.navigationController pushViewController:mp animated:YES];
    
}
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return farmacias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"FarmaciasCell";
    FarmaciasCell *cell = (FarmaciasCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        UINib *cellNib = [UINib nibWithNibName:CellIdentifier bundle:[NSBundle mainBundle]];
        cell = [[cellNib instantiateWithOwner:self options:nil]objectAtIndex:0];
        
    }
    
    NSURL *imageURL = [NSURL URLWithString:((Farmacia*)[farmacias objectAtIndex:indexPath.row]).RutaIMG];
    
    UIImage *cachedImage = [self.imageCache objectForKey:imageURL];
    if (cachedImage)
    {
        cell.imagen.image = cachedImage;
        NSLog(@"cacheee");
    }
    else
    {
        cell.imagen.image = nil;
        
        [self.imageDownloadingQueue addOperationWithBlock:^{
            
            NSURL *imageUrl   = imageURL;
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image    = nil;
            if (imageData)
                image = [UIImage imageWithData:imageData];
            
            if (image)
            {
                
                
                
                
                [self.imageCache setObject:image forKey:imageURL];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        cell.imagen.image = image;
                }];
            }
        }];
        
    }
    
    cell.nombre.text = ((Farmacia*)[farmacias objectAtIndex:indexPath.row]).NomFarmacia;
    cell.fechafundacion.text = ((Farmacia*)[farmacias objectAtIndex:indexPath.row]).FechaFundacion;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.mapa addTarget:self action:@selector(goMap) forControlEvents:UIControlEventTouchUpInside];
    
    
    [HUD removeFromSuperview];
    
    return cell;
}

@end
