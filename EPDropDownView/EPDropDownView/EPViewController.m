//
//  EPViewController.m
//  EPDropDownView
//
//  Created by Kelsey Regan on 2013-10-23.
//  Copyright (c) 2013 Elevated Pixels Software. All rights reserved.
//

#import "EPViewController.h"
#import "EPDropDownView.h"
@interface EPViewController ()
@property(strong, nonatomic) EPDropDownView* dropDownView;
@end

@implementation EPViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dropDownView = [EPDropDownView dropDownViewWithDisplayFrame:CGRectMake(50, 0, self.view.frame.size.width-100, 350)];
    self.dropDownView.frame = self.view.bounds;
    self.dropDownView.contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dropDownView];
}

-(IBAction)toggleDropDown:(id)sender
{
    self.dropDownView.isExpanded ^= YES;
}

@end
