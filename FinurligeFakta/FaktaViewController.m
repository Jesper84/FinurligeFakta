//
//  FaktaViewController.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "FaktaViewController.h"
#import "FaktaQueryService.h"

@interface FaktaViewController ()

@end

@implementation FaktaViewController
@synthesize faktaText, titleLabel, shareButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighligt = [[UIImage imageNamed:@"orangeButtonHighlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [shareButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [shareButton setBackgroundImage:buttonImageHighligt forState:UIControlStateHighlighted];
    
    FaktaQueryService *service = [[FaktaQueryService alloc] init];
    [service setDelegate:self];
    [service queryGuid];
}

- (IBAction)showShareMenu:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Blaf" message:@"Blaf" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)factRequestComplete:(NSDictionary *)factData{
    faktaText.text = [factData valueForKey:@"content"];
    titleLabel.text = [factData valueForKey:@"title"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
