//
//  SnackItem.h
//  Snackerator
//
//  Created by Prayaas Jain on 3/28/15.
//  Copyright (c) 2015 prayaasjain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnackItem : NSObject

@property (nonatomic, strong) NSNumber *itemId, *quantity, *calorieCount;
@property (nonatomic, strong) NSString *itemName, *itemImage, *energyLevel;

-(id) initWithItemId:(NSNumber *)itemId itemName:(NSString *)itemName quantity:(NSNumber *)quantity itemImage:(NSString *)itemImage calorieCount:(NSNumber *)calorieCount energyLevel:(NSString *)energyLevel;

@end
