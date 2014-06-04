//
//  LocalesVC.h
//  proyectoFarmaciOS
//
//  Created by TKJ on 5/28/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"



@interface LocalesVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD *HUD;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
