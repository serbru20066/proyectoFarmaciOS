//
//  LocalesCell.h
//  proyectoFarmaciOS
//
//  Created by Alvaro Herrera on 25/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FarmaciasCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *fechafundacion;
@property (weak, nonatomic) IBOutlet UIImageView *imagen;
@property (weak, nonatomic) IBOutlet UIImageView *fondo;
@property (weak, nonatomic) IBOutlet UIButton *mapa;
@property (weak, nonatomic) IBOutlet UIButton *btnDeslizar;



@end
