//
//  EPDropDownView.h
//  FieldData
//
//  Created by Kelsey Regan on 13-08-23.
//  Copyright (c) 2013 Elevated Pixels Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPDropDownView : UIView

+(instancetype)dropDownViewWithNibName:(NSString *)nibName owner:(id)owner displayFrame:(CGRect)displayFrame;
+(instancetype)dropDownViewWithDisplayFrame:(CGRect)displayFrame;

-(void)initialize;

@property(nonatomic) CGRect displayFrame;
@property(readonly, strong, nonatomic) UIView* contentView;
@property(nonatomic) bool isExpanded;
@property(readonly, nonatomic) bool shouldExpand;
-(void)setIsExpanded:(bool)isExpanded animated:(bool)animated completion:(void (^)())completion;

@end
