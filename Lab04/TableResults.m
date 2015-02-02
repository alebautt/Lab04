//
//  TableResults.m
//  Lab04
//
//  Created by Alejandra B on 01/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import "TableResults.h"
#import "VarGlobal.h"
#import "CellResults.h"
#import "classBD.h"

int position;

@interface TableResults ()

@end

@implementation TableResults

- (void)viewDidLoad {
    NSLog(@"en load");
   // [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    int counter = 0;
    position = 0;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // [self initController];
    globalArray = [NSMutableArray arrayWithArray:[[classBD getSharedInstance]allRecords]];
    //recorres areglos
    for(NSArray *element in globalArray) {
        if([[element objectAtIndex:1] integerValue] == score){
            position = counter;
        }
        counter++;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}




-(void)viewDidAppear:(BOOL)animated{
       NSLog(@"principio de appear");
    //creo el objeto de tipo indexpath para localizar la celda de la tabla
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:position inSection:0];
    //en q posicion quiero el dato
    [self.tblView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionMiddle
                                animated:YES];
    [self.tblView selectRowAtIndexPath:idxPath
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
    NSLog(@"final de appear");
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"%lu", (unsigned long)globalArray.count);
     return globalArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"CellResults";
   
    CellResults *cell = (CellResults *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[CellResults alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSMutableArray *record = globalArray[indexPath.row];
    
    cell.lblClicsTotal.text       = [record objectAtIndex:1];
    cell.lblDate.text      = [record objectAtIndex:0];
    
    NSLog(@"clics %@ fecha %@", [record objectAtIndex:1],[record objectAtIndex:0]);
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnBack:(id)sender {
    
}
    

@end
