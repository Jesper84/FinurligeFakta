//
//  FavoritterViewController.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 10/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "FavoritterViewController.h"
#import "AppDelegate.h"
#import "Fakta.h"
@interface FavoritterViewController ()

@end

@implementation FavoritterViewController
@synthesize favorites;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
    Fakta *fakta = [self.favorites objectAtIndex:indexPath.row];
    cell.textLabel.text = fakta.title;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.favorites count];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AppDelegate *delegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    self.favorites = delegate.favoriteList;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
