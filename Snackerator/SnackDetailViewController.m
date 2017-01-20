//
//  SnackDetailViewController.m
//  Snackerator
//
//  Created by Prayaas Jain on 3/30/15.
//  Copyright (c) 2015 prayaasjain. All rights reserved.
//

#import "SnackDetailViewController.h"
#import "SnackManager.h"

@interface SnackDetailViewController ()

@end

@implementation SnackDetailViewController

@synthesize item;

-(id) initWithSnackItem:(SnackItem *)_item {
    
    if(self = [super init]) {
        self.item = _item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:0.5]];
    
    [self addSnackDetail];
}

-(void) addSnackDetail {
    
    UILabel *snackName = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 70)];
    [snackName setText:item.itemName];
    [snackName setFont:[UIFont fontWithName:@"Helvetica" size:30]];
    [snackName setTextColor:[UIColor whiteColor]];
    [snackName setNumberOfLines:2];
    [snackName setLineBreakMode:NSLineBreakByWordWrapping];
    [self.view addSubview:snackName];
    
    UILabel *calories = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 200, 25)];
    [calories setText:[NSString stringWithFormat:@"Calories: %i", [item.calorieCount intValue]]];
    [calories setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [calories setTextColor:[UIColor whiteColor]];
    [calories setNumberOfLines:1];
    [calories setLineBreakMode:NSLineBreakByWordWrapping];
    [self.view addSubview:calories];
    
    UILabel *energyLevel = [[UILabel alloc] initWithFrame:CGRectMake(50, 135, 200, 150)];
    [energyLevel setText:[NSString stringWithFormat:@"Satisfaction: %@", item.energyLevel]];
    [energyLevel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [energyLevel setTextColor:[UIColor whiteColor]];
    [energyLevel setNumberOfLines:5];
    [energyLevel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.view addSubview:energyLevel];
    
    UILabel *enjoy = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 225, 350, 400, 50)];
    [enjoy setText:@"Enjoy your snack!"];
    [enjoy setFont:[UIFont fontWithName:@"Helvetica" size:25]];
    [enjoy setTextAlignment:NSTextAlignmentCenter];
    [enjoy setTextColor:[UIColor whiteColor]];
    [enjoy setTag:100];
    [enjoy setHidden:YES];
    [self.view addSubview:enjoy];
    
    UIImageView *snackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item.itemImage]];
    [snackImage setFrame:CGRectMake(275, 50, 200, 200)];
    [snackImage setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:snackImage];
    
    
    if([item.quantity intValue] > 0) {
        
        UILabel *quantity = [[UILabel alloc] initWithFrame:CGRectMake(50, 225, 400, 150)];
        [quantity setText:[NSString stringWithFormat:@"Quantity Available: %i", [item.quantity intValue]]];
        [quantity setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [quantity setTextColor:[UIColor whiteColor]];
        [quantity setNumberOfLines:1];
        [quantity setLineBreakMode:NSLineBreakByWordWrapping];
        [self.view addSubview:quantity];
        
        UIView *background1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 155, 445, 260, 60)];
        [background1 setBackgroundColor:[UIColor whiteColor]];
        [background1.layer setCornerRadius:10];
        [self.view addSubview:background1];
        
        UIButton *eatThis = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 150, 450, 250, 50)];
        [eatThis setTitle:@"DISPENSE SNACK" forState:UIControlStateNormal];
        [eatThis setBackgroundColor:[UIColor colorWithRed:51/255.0f green:153/255.0f blue:1.0f alpha:1.0]];
        [eatThis addTarget:self
                    action:@selector(dispenseItem:)
          forControlEvents:UIControlEventTouchUpInside];
        [eatThis setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [eatThis.layer setCornerRadius:10.0];
        [self.view addSubview:eatThis];
        
        UIView *background2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 155, 515, 260, 60)];
        [background2 setBackgroundColor:[UIColor whiteColor]];
        [background2.layer setCornerRadius:10];
        [self.view addSubview:background2];
        
        UIButton *eatOther = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 150, 520, 250, 50)];
        [eatOther setTitle:@"I WANT SOMETHING ELSE" forState:UIControlStateNormal];
        [eatOther setBackgroundColor:[UIColor colorWithRed:51/255.0f green:153/255.0f blue:1.0f alpha:1.0]];
        [eatOther addTarget:self
                    action:@selector(tryAgain:)
          forControlEvents:UIControlEventTouchUpInside];
        [eatOther setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [eatOther.layer setCornerRadius:10.0];
        [self.view addSubview:eatOther];
    }
    else {
        
        UILabel *sorry = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 225, 450, 400, 50)];
        [sorry setText:@"Sorry! This snack is out of stock!"];
        [sorry setFont:[UIFont fontWithName:@"Helvetica" size:25]];
        [sorry setTextAlignment:NSTextAlignmentCenter];
        [sorry setTextColor:[UIColor whiteColor]];
        [self.view addSubview:sorry];
        
        UIButton *eatOther = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 150, 520, 250, 50)];
        [eatOther setTitle:@"GET SOMETHING ELSE" forState:UIControlStateNormal];
        [eatOther setBackgroundColor:[UIColor colorWithRed:51/255.0f green:153/255.0f blue:1.0f alpha:1.0]];
        [eatOther addTarget:self
                     action:@selector(tryAgain:)
           forControlEvents:UIControlEventTouchUpInside];
        [eatOther setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [eatOther.layer setCornerRadius:10.0];
        [self.view addSubview:eatOther];
    }
    
    
}

-(void) goBackToMainView {
    [[SnackManager getInstance] decreaseQuantityForSnack:item];
    [self.delegate didMakeSnackSelection];
}

-(IBAction)dispenseItem:(id)sender {
    [[self.view viewWithTag:100] setHidden:NO];
    [self performSelector:@selector(goBackToMainView) withObject:nil afterDelay:1.0];
}

-(IBAction)tryAgain:(id)sender {
    [self.delegate didMakeSnackSelection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
