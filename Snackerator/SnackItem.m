//
//  SnackItem.m
//  Snackerator
//
//  Created by Prayaas Jain on 3/28/15.
//  Copyright (c) 2015 prayaasjain. All rights reserved.
//

#import "SnackItem.h"

@implementation SnackItem

@synthesize itemId, quantity, itemName, itemImage, calorieCount, energyLevel;

-(id) initWithItemId:(NSNumber *)_itemId itemName:(NSString *)_itemName quantity:(NSNumber *)_quantity itemImage:(NSString *)_itemImage calorieCount:(NSNumber *)_calorieCount energyLevel:(NSString *)_energyLevel {
    
    if(self = [super init]) {
        self.itemId = _itemId;
        self.quantity = _quantity;
        self.itemName = _itemName;
        self.itemImage = _itemImage;
        self.calorieCount = _calorieCount;
        self.energyLevel = _energyLevel;
    }
    
    return self;
}

@end
