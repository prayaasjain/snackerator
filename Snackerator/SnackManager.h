//
//  SnackManager.h
//  Snackerator
//
//  Created by Prayaas Jain on 3/30/15.
//  Copyright (c) 2015 prayaasjain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnackItem.h"

@interface SnackManager : NSObject

+(id) getInstance;
-(void) decreaseQuantityForSnack:(SnackItem *)item;

@end
