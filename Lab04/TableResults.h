//
//  TableResults.h
//  Lab04
//
//  Created by Alejandra B on 01/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TableResults : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;

@end
