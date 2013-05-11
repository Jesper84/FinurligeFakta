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
#import "FavoriteFactViewController.h"
@interface FavoritterViewController ()

@end

@implementation FavoritterViewController
@synthesize favorites, myTableView, selectedFact;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
    Fakta *fakta = [self.favorites objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.text = fakta.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedFact = [self.favorites objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"pushFavoriteFact" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    FavoriteFactViewController *controller = segue.destinationViewController;
    controller.selectedFact = self.selectedFact;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.favorites count];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *titleToMove = [self.favorites objectAtIndex:sourceIndexPath.row];
    [self.favorites removeObjectAtIndex:sourceIndexPath.row];
    [self.favorites insertObject:titleToMove atIndex:destinationIndexPath.row];
    
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate saveFavoriteList];
    
}

- (void)editFavorites{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing) {
        self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
        self.navigationItem.rightBarButtonItem.title = @"OK";
    }else {
        self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleBordered;
        self.navigationItem.rightBarButtonItem.title = @"Rediger";
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        Fakta *factToBeRemoved = [favorites objectAtIndex:indexPath.row];
        [delegate removeFactFromFavoriteList:factToBeRemoved];
        [self updateFavoriteBadge];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    if ([favorites count] == 0 ) {
        self.navigationItem.rightBarButtonItem = nil;
        self.tableView.editing = NO;
    }
}

- (void)updateFavoriteBadge{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    int number = [delegate.favoriteList count];
    UIViewController *controller = [self.tabBarController.viewControllers objectAtIndex:1];
    
    if (number == 0) {
        controller.tabBarItem.badgeValue = nil;
    } else {
        controller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", number];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    if ([self.favorites count] > 0) {
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Rediger" style:UIBarButtonItemStyleBordered target:self action:@selector(editFavorites)];
        self.navigationItem.rightBarButtonItem = editButton;
    }
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
