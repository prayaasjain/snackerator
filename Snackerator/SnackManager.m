//
//  SnackManager.m
//  Snackerator
//
//  Created by Prayaas Jain on 3/30/15.
//  Copyright (c) 2015 prayaasjain. All rights reserved.
//

#import "SnackManager.h"

@implementation SnackManager

static SnackManager *snackMgr = nil;

+(id) getInstance {
    
    @synchronized(self) {
        if(snackMgr == nil) {
            snackMgr = [[self alloc] _init];
        }
    }
    return snackMgr;
}

-(id)_init {
    
    if(self = [super init]) {
    }
    return self;
}

-(void) decreaseQuantityForSnack:(SnackItem *)item {
    int q = [item.quantity intValue];
    if(q > 0)
        --q;
    item.quantity = [NSNumber numberWithInt:q];
}

@end
