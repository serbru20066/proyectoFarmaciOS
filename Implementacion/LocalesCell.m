//
//  LocalesCell.m
//  proyectoFarmaciOS
//
//  Created by TKJ on 5/28/14.
//  Copyright (c) 2014 Alvaro Herrera. All rights reserved.
//

#import "LocalesCell.h"

@implementation LocalesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.option.image = [UIImage imageNamed:@"locate.png"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    

}

@end
