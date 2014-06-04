//
//  Farmacias.h
//  proyectoFarmaciOS
//
//  Created by Alvaro Herrera on 3/06/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface Farmacias : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD *HUD;
     
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *menu;


@end
