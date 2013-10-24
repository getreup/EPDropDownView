//
//  EPDropDownView.m
//  FieldData
//
//  Created by Kelsey Regan on 13-08-23.
//  Copyright (c) 2013 Elevated Pixels Software. All rights reserved.
//

#import "EPDropDownView.h"
#import <QuartzCore/QuartzCore.h>

@interface EPDropDownView()
@property(strong, nonatomic) UIButton* backgroundButton;
@end

@implementation EPDropDownView


+(instancetype)dropDownViewWithNibName:(NSString *)nibName owner:(id)owner displayFrame:(CGRect)displayFrame
{
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    EPDropDownView* view = views[0];
    view.displayFrame = displayFrame;
    [view initialize];
    return view;
}

+(instancetype)dropDownViewWithDisplayFrame:(CGRect)displayFrame
{
    EPDropDownView* dropDownView = [[EPDropDownView alloc] initWithFrame:displayFrame];
    dropDownView.displayFrame = displayFrame;
    
    return dropDownView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self ) [self initialize];
    return self;
}

-(void)initialize
{
    // Kelsey: commenting out shadow for now to make UI more flat
//    self.displayView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.displayView.layer.shadowOffset = CGSizeZero;
//    self.displayView.layer.shadowOpacity = 1;
//    self.displayView.layer.shadowRadius = 15;
    self.contentView.frame = self.displayFrame;
    [self addSubview:self.contentView];
    [self addSubview:self.backgroundButton];
    [self sendSubviewToBack:self.backgroundButton];
    
    [self setIsExpanded:NO animated:NO completion:nil];
}

#pragma mark IBActions

-(IBAction)backgroundButtonSelected:(id)sender
{
    self.isExpanded = NO;
}

#pragma mark Properties

-(bool)shouldExpand
{
    return YES; // override if you want to disable for some reason
}

@synthesize isExpanded = _isExpanded;
-(bool)isExpanded
{
    return _isExpanded;
}

-(void)setIsExpanded:(bool)isExpanded
{
    [self setIsExpanded:isExpanded animated:YES completion:nil];
}

-(void)setIsExpanded:(bool)isExpanded animated:(bool)animated completion:(void (^)())completion
{
    if( !self.shouldExpand && isExpanded ) return;
    
    _isExpanded = isExpanded;
    if( isExpanded ) self.hidden = NO;
    [UIView
     animateWithDuration:animated ? .2 : 0 delay:0 options:UIViewAnimationOptionCurveEaseOut
     animations:^
     {
         if( _isExpanded )
         {
             self.contentView.frame = self.displayFrame;
             self.backgroundButton.alpha = .2;
         }
         else
         {
             self.contentView.frame = CGRectMake(self.displayFrame.origin.x, self.displayFrame.origin.y, self.displayFrame.size.width, 0);
             self.backgroundButton.alpha = 0;
         }
     }
     completion:^(BOOL finished)
     {
         if( !isExpanded ) self.hidden = YES;
         if( completion ) completion();
     }];
}

-(UIButton *)backgroundButton
{
    if( !_backgroundButton )
    {
        _backgroundButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backgroundButton.backgroundColor = [UIColor blackColor];
        _backgroundButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_backgroundButton addTarget:self action:@selector(backgroundButtonSelected:) forControlEvents:UIControlEventTouchDown];
    }
    return _backgroundButton;
}

@synthesize contentView = _contentView;
-(UIView *)contentView
{
    if( !_contentView )
    {
        _contentView = [[UIView alloc] initWithFrame:self.displayFrame];
    }
    return _contentView;
}


-(void)setDisplayFrame:(CGRect)displayFrame
{
    _displayFrame = displayFrame;
    self.contentView.frame = self.displayFrame;
    self.isExpanded = self.isExpanded;
}

@end
