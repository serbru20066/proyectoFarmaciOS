//
//  LoguinViewController.h
//  proyectoFarmaciOS
//
//  Created by bruno on 14/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField_Extension.h"
#import "MBProgressHUD.h"
#import <FacebookSDK/FacebookSDK.h>
#import "RESideMenu.h"

@interface LoguinViewController : UIViewController<UITextFieldDelegate,FBLoginViewDelegate>
{
    NSMutableDictionary *usuArr;
    MBProgressHUD *HUD;
    NSUserDefaults *standardDefaults;
    

}
@property (weak, nonatomic) IBOutlet UIButton *btnIngresar;

 @property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@property (weak, nonatomic) IBOutlet UIImageView *imgFondoTexts;
@property (weak, nonatomic) IBOutlet UITextField_Extension *txtUsuario;
@property (weak, nonatomic) IBOutlet UITextField_Extension *txtContrasena;
- (IBAction)actionBtnIngresar:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *logo1;
@property (weak, nonatomic) IBOutlet UIButton *btnFB;
@end
