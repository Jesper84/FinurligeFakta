//
//  FavoriteFactViewController.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 11/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "FavoriteFactViewController.h"

@interface FavoriteFactViewController ()

@end

@implementation FavoriteFactViewController
@synthesize selectedFact, factText, factTitle;
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
    self.factTitle.text = self.selectedFact.title;
    self.factText.text = self.selectedFact.content;
    self.sentByLabel.text = self.selectedFact.author;
    self.navigationItem.title = self.selectedFact.title;
    
    self.factText.hidden = NO;
    self.factTitle.hidden = NO;
    self.sentByLabel.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
