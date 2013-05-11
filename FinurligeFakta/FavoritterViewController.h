//
//  FavoritterViewController.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 10/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fakta.h"
@interface FavoritterViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *favorites;
@property (strong, nonatomic) Fakta *selectedFact;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@end
