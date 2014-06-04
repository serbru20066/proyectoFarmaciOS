//
//  InfoUsuarioViewController.m
//  proyectoFarmaciOS
//
//  Created by bruno on 25/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import "InfoUsuarioViewController.h"
#import "LoguinViewController.h"
#import "FXBlurView.h"

@interface InfoUsuarioViewController ()

@end

@implementation InfoUsuarioViewController

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
    
    
    
    self.UserName.frame = CGRectMake(-305, 372, 302, 21);
    _profilePictureView=[[FBProfilePictureView alloc] init];
    _profilePictureView.frame=CGRectMake(0, 45, 320, 279);
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320 , 580)];
    imgView.image = [UIImage imageNamed:@"fondo9.jpeg"];
    [self.view addSubview:imgView];
    
    FXBlurView *blurView = [[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    blurView.blurRadius = 10.0f;
    blurView.alpha = 0.99f;
    [blurView setTintColor:[UIColor whiteColor]];
    [self.view addSubview:blurView];
    [blurView addSubview:_profilePictureView];
    [blurView addSubview:self.UserName];
    


    UIImage *buttonImage = [UIImage imageNamed:@"general_top_button.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0,0.0,40,40);
    [aButton addTarget:self action:@selector(presentLeftMenuViewController:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.title = @"Perfil";
[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(124/255.0) green:(156/255.0) blue:(55/255.0) alpha:1]];
    
    
    //Cabecera escondida
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setNavigationBarHidden:NO];
    
    //Boton de FB
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectMake(60, 430,200, 300);
    loginView.delegate=self;
    [self.view addSubview:loginView];
    
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewDidLoad];
    // Obtener datos del NSUSerDefault y mostrarlos
    
    standardDefaults = [NSUserDefaults standardUserDefaults];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //esconder boton Back
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma FB Loguin Delegate






//Programamos en este delegado(de cerrar sesion) porque, cuando estemos en este viewcontroller, siempre sera porque ya estamos logueados
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    LoguinViewController *vc= [[LoguinViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    //resetear variables NSUSerDefault
    NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (NSString *key in [defaultsDictionary allKeys]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

//Este delegado se encarga de mostrar la informacion del usuario
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    
    //Labels con la informacion del usuario
    NSString *fbid = [standardDefaults
                      stringForKey:@"fbid"];
    NSString *fbname = [standardDefaults
                        stringForKey:@"fbname"];
    NSString *fbcorr = [standardDefaults
                        stringForKey:@"fbcorr"];


    //Imagen de perfil

    [self.view addSubview:_profilePictureView];
    _profilePictureView.alpha= 0.0;
    
    [UIView animateWithDuration:1.50f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _profilePictureView.alpha= 1.0;
        _profilePictureView.profileID = fbid;
        self.UserName.frame = CGRectMake(9, 372, 302, 21);
        
    } completion:^(BOOL finished) {
        
    }];

    
    self.UserName.text=[NSString stringWithFormat:@"%@ %@",@"",fbname];
    
}


@end
