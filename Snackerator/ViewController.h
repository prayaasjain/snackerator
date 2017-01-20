//
//  ViewController.h
//  Snackerator
//
//  Created by Prayaas Jain on 3/28/15.
//  Copyright (c) 2015 prayaasjain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SnackDetailViewController.h"

@interface ViewController : UIViewController<SnackDetailDelegate> {
    NSArray *availableSnacks;
    NSMutableArray *displayedSnacks;
    NSTimer *blinkTimer;
    NSTimer *controlTimer;
    UIView *popViewMenu;
    UIView *popViewInfo;
    
    AVAudioPlayer *audioPlayer;
    
}


@end

