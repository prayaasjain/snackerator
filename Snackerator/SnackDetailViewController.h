//
//  SnackDetailViewController.h
//  Snackerator
//
//  Created by Prayaas Jain on 3/30/15.
//  Copyright (c) 2015 prayaasjain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnackItem.h"

@protocol SnackDetailDelegate <NSObject>

-(void) didMakeSnackSelection;

@end

@interface SnackDetailViewController : UIViewController

@property (nonatomic, strong) SnackItem *item;
@property (weak, nonatomic) id<SnackDetailDelegate> delegate;

-(id) initWithSnackItem:(SnackItem *)item;

@end
