//
//  UITextField_Extension.m
//  DinersClub
//
//  Created by Renzo Crisóstomo on 1/10/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "UITextField_Extension.h"

@implementation UITextField_Extension

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [[UIColor grayColor] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
}

@end
