//
//  LocalesCell.m
//  proyectoFarmaciOS
//
//  Created by Alvaro Herrera on 25/05/14.
//  Copyright (c) 2014 Alvaro Herrera. All rights reserved.
//

#import "FarmaciasCell.h"
#import "MapaTodosVC.h"

@implementation FarmaciasCell

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
//    self.imagen.frame = CGRectMake(210, 20, 50, 50);
//    self.mapa.frame = CGRectMake(210, 20, 50, 50);
//    self.imagen.layer.cornerRadius = self.imagen.frame.size.height /2;
//    self.imagen.layer.masksToBounds = YES;


    
    
    
    self.fondo.layer.cornerRadius = self.imagen.frame.size.height /2;
    self.fondo.layer.masksToBounds = YES;
    [self.fondo.layer setBorderColor: [[UIColor colorWithRed:124/255.0 green:156/255.0 blue:55/255.0 alpha:1.0] CGColor]];
    
   
    
    
    [self.fondo.layer setBorderWidth: 5.0];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark Options Button Methods
- (void)showOptionsToLeftForGestureRecognizer
{
    
    
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
//        self.imagen.alpha = 0.0f;
        self.mapa.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}
- (void)showOptionsToRightForGestureRecognizer
{
    
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
//        self.imagen.alpha =1.0f;
        self.mapa.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}
#pragma mark Gesture Recognizer Methods
- (void)pan:(UIPanGestureRecognizer *)sender
{
    
    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
        UIPanGestureRecognizerDirectionUndefined,
        UIPanGestureRecognizerDirectionUp,
        UIPanGestureRecognizerDirectionDown,
        UIPanGestureRecognizerDirectionLeft,
        UIPanGestureRecognizerDirectionRight
    };
    
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            if (direction == UIPanGestureRecognizerDirectionUndefined) {
                
                CGPoint velocity = [sender velocityInView:self];
                
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        direction = UIPanGestureRecognizerDirectionDown;
                    } else {
                        direction = UIPanGestureRecognizerDirectionUp;
                    }
                }
                
                else {
                    if (velocity.x > 0) {
                        direction = UIPanGestureRecognizerDirectionRight;
                    } else {
                        direction = UIPanGestureRecognizerDirectionLeft;
                    }
                }
            }
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            switch (direction) {
                case UIPanGestureRecognizerDirectionUp: {
                    [self handleUpwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionDown: {
                    [self handleDownwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionLeft: {
                    [self handleLeftGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionRight: {
                    [self handleRightGesture:sender];
                    break;
                }
                default: {
                    break;
                }
            }
        }
            
        case UIGestureRecognizerStateEnded: {
            direction = UIPanGestureRecognizerDirectionUndefined;
            break;
        }
            
        default:
            break;
    }
    
}
- (void)handleUpwardsGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Up");
}

- (void)handleDownwardsGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Down");
}

- (void)handleLeftGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Left");
    [self showOptionsToLeftForGestureRecognizer];
}

- (void)handleRightGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Right");
    [self showOptionsToRightForGestureRecognizer];
}
@end
