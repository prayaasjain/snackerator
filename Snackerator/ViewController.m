//
//  ViewController.m
//  Snackerator
//
//  Created by Prayaas Jain on 3/28/15.
//  Copyright (c) 2015 prayaasjain. All rights reserved.
//

#import "ViewController.h"
#import "SnackItem.h"

@interface ViewController () {
    SnackItem *selectedSnack;
}

@end

static int INTERFRAME_WIDTH = 50;
static int FRAME_WIDTH = 120;
static int FRAME_HEIGHT = 120;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0]];
    
    UILabel *titleBanner = [[UILabel alloc] initWithFrame:CGRectMake(256, 50, 512, 150)];
    [titleBanner setText:@"Snackerator"];
    [titleBanner setFont:[UIFont fontWithName:@"Helvetica" size:50]];
    [titleBanner setTextAlignment:NSTextAlignmentCenter];
    [titleBanner setTextColor:[UIColor colorWithRed:51/255.0f green:153/255.0f blue:1.0f alpha:1.0]];
    [self.view addSubview:titleBanner];
    
    UIView *backgroundStrip = [[UIView alloc] initWithFrame:CGRectMake(0, 210, self.view.frame.size.width, 180)];
    [backgroundStrip setBackgroundColor:[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]];
    [self.view addSubview:backgroundStrip];
    
    [self setupSnackerator];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}

-(NSMutableArray *) getSnacks {
    
    NSMutableArray *collectSnacks = [NSMutableArray new];
    SnackItem *peanuts = [[SnackItem alloc] initWithItemId:[NSNumber numberWithInt:1011] itemName:@"Salted Peanuts" quantity:[NSNumber numberWithInt:5] itemImage:@"saltedPeanuts.png" calorieCount:[NSNumber numberWithInt:250] energyLevel:@"High Energy Snack. This shall keep you going for 2 hours."];
    [collectSnacks addObject:peanuts];
    
    SnackItem *doritos = [[SnackItem alloc] initWithItemId:[NSNumber numberWithInt:1011] itemName:@"Doritos" quantity:[NSNumber numberWithInt:5] itemImage:@"doritos.png" calorieCount:[NSNumber numberWithInt:350] energyLevel:@"Low Energy Snack. This shall keep you going for 1 hour."];
    [collectSnacks addObject:doritos];
    
    SnackItem *pretzels = [[SnackItem alloc] initWithItemId:[NSNumber numberWithInt:1011] itemName:@"Mini Pretzels" quantity:[NSNumber numberWithInt:5] itemImage:@"pretzels.png" calorieCount:[NSNumber numberWithInt:200] energyLevel:@"High Energy Snack. This shall keep you going for 2 hours."];
    [collectSnacks addObject:pretzels];
    
    SnackItem *brownie = [[SnackItem alloc] initWithItemId:[NSNumber numberWithInt:1011] itemName:@"Fiber One Brownie" quantity:[NSNumber numberWithInt:5] itemImage:@"fibreOneBrownie.png" calorieCount:[NSNumber numberWithInt:90] energyLevel:@"Medium Energy Snack. This shall keep you going for 1.5 hours."];
    [collectSnacks addObject:brownie];
    
    SnackItem *dairymilk = [[SnackItem alloc] initWithItemId:[NSNumber numberWithInt:1011] itemName:@"Dairy Milk" quantity:[NSNumber numberWithInt:5] itemImage:@"dairymilk.png" calorieCount:[NSNumber numberWithInt:225] energyLevel:@"Extreme Energy Snack. This shall keep you going for 3 hours."];
    [collectSnacks addObject:dairymilk];
    
    return collectSnacks;
}

-(void) setupSnackerator {
    
    availableSnacks = [NSArray arrayWithArray:[self getSnacks]];
    displayedSnacks = [NSMutableArray new];
    
    NSURL *corkSoundURL   = [[NSBundle mainBundle] URLForResource: @"cork2" withExtension: @"aif"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:corkSoundURL error:nil];
    
    float yCoordinate = 240;
    long int totalWidth = [availableSnacks count]*FRAME_WIDTH + ([availableSnacks count] - 1)*INTERFRAME_WIDTH;
    float xCoordinate = (self.view.frame.size.width - totalWidth)/2;
    
    for(int i=1; i<=[availableSnacks count]; i++) {
        SnackItem *s = [availableSnacks objectAtIndex:i-1];
        UIImageView *snackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:s.itemImage]];
        [snackImage setTag:i];
        [snackImage setContentMode:UIViewContentModeScaleAspectFit];
        [snackImage setFrame:CGRectMake(xCoordinate, yCoordinate, FRAME_WIDTH, FRAME_HEIGHT)];
        [self.view addSubview:snackImage];
        [displayedSnacks addObject:snackImage];
        
        xCoordinate += FRAME_WIDTH + INTERFRAME_WIDTH;
    }
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 105, 595, 210, 85)];
    [background setBackgroundColor:[UIColor whiteColor]];
    [background.layer setCornerRadius:10];
    [self.view addSubview:background];
    
    UIButton *feedMe = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 600, 200, 75)];
    [feedMe setBackgroundColor:[UIColor colorWithRed:51/255.0f green:153/255.0f blue:1.0f alpha:1.0]];
    [feedMe setTitle:@"FEED ME" forState:UIControlStateNormal];
    [feedMe setTintColor:[UIColor whiteColor]];
    [feedMe addTarget:self
               action:@selector(fetchSnack:)
     forControlEvents:UIControlEventTouchUpInside];
    [feedMe.layer setCornerRadius:10.0];
    [self.view addSubview:feedMe];
}

-(void) prepareAndDisplaySnackInfo {
    
    for(UIImageView *s in displayedSnacks) {
        if(s.isHighlighted) {
            s.highlighted = NO;
            s.layer.shadowColor = [UIColor clearColor].CGColor;
        }
    }
    
    SnackDetailViewController *sdvc = [[SnackDetailViewController alloc] initWithSnackItem:selectedSnack];
    [sdvc setModalPresentationStyle:UIModalPresentationFormSheet];
    [sdvc setDelegate:self];
    [self presentViewController:sdvc animated:YES completion:nil];
}

-(void) didMakeSnackSelection {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)highlightSnackWithTag:(NSInteger)tag {
    
    for(UIImageView *s in displayedSnacks) {
        if(s.isHighlighted) {
            s.highlighted = NO;
            s.layer.shadowColor = [UIColor clearColor].CGColor;
        }
        
        if(s.tag == tag) {
            //[audioPlayer play];
            s.highlighted = YES;
            s.layer.shadowColor = [UIColor colorWithRed:1.0f green:204/255.0f blue:0.0f alpha:1].CGColor;
            s.layer.shadowOffset = CGSizeMake(0.0, 0.0);
            s.layer.shadowRadius = 20.0;
            s.layer.shadowOpacity = 1.0;
            s.layer.masksToBounds = NO;
        }
    }
    
}

-(IBAction)fetchSnack:(id)sender {
    blinkTimer = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                                  target:self
                                                selector:@selector(randomSelectionSequence)
                                                userInfo:nil
                                                 repeats:NO];
    controlTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(stopBlinkTimer) userInfo:nil repeats:NO];
    
}

-(void)randomSelectionSequence {
    int tag = (arc4random() % [availableSnacks count]) + 1;
    [self highlightSnackWithTag:tag];
    
    blinkTimer = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                                  target:self
                                                selector:@selector(randomSelectionSequence)
                                                userInfo:nil
                                                 repeats:NO];
}

-(void)setSelectedSnack {
    float scaleFactor = 1.25;
    for(UIImageView *s in displayedSnacks) {
        if(s.isHighlighted) {
            selectedSnack = [availableSnacks objectAtIndex:s.tag-1];
            NSLog(@"Selected Snack Number: %li", s.tag-1);
            
            CGRect originalFrame = s.frame;
            CGRect newFrame = originalFrame;
            newFrame.size.width *= scaleFactor;
            newFrame.size.height *= scaleFactor;
            newFrame.origin.x -= (newFrame.size.width - originalFrame.size.width)/2;
            newFrame.origin.y -= (newFrame.size.height - originalFrame.size.height)/2;
            
            [UIView animateWithDuration:1.0
                             animations:^{
                                 s.frame = newFrame;
                             }completion:^(BOOL finished) {
                                 s.frame = originalFrame;
                                 [self prepareAndDisplaySnackInfo];
                             }];
        }
    }
        
}

-(void)stopBlinkTimer {
    [blinkTimer invalidate];
    blinkTimer = nil;
    [self setSelectedSnack];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
