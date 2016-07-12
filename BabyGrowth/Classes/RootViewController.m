//
//  RootViewController.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "RootViewController.h"
#import "GrowthAnalizeViewController.h"
#import "GrowthEstimateBabyController.h"
#import "GrowthBMIMeasureController.h"
#import "GrowthHistoryResultController.h"

@implementation RootViewController
@synthesize btnGoToGrowthAnalize;
@synthesize btnGoToGrowthEstimate;
@synthesize btnGoToGrowthBMIMeasure;
@synthesize btnGoToGrowthHistory;
@synthesize btnGoToFaceBookPage;

@synthesize timer;
@synthesize second;

/*======================================================================================
 뷰가나타날때 리뷰쓰라고 권고하는 창을 띄워주기 위해 대기하는 타이머
 ======================================================================================*/
-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	//self.timer=[NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(UPDATE_TIME) userInfo:nil repeats:YES];		
	//[self setSecond:0];
	
}

/*======================================================================================
 뷰가 사라질때는 타이머를 뜬다.
 ======================================================================================*/

-(void) viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:YES];
	//[self setSecond:0];
	//[self.timer invalidate];
}


/*======================================================================================
 타이머에 의해 호출되는 함수
 ======================================================================================*/
-(void) UPDATE_TIME
{
	
	int newsecond=[self second]+1;
	[self setSecond:newsecond];	
	NSLog(@"Second:%d",[self second]);
	
	if([self second]>=1)
	{
		[self setSecond:0];
		[self.timer invalidate];//타이머 멈춤
		BABYGROWTHAppDelegate *appDelegate=(BABYGROWTHAppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate ShowMessageBoxRequireReview];
	}
}

-(IBAction)btnGoToGrowthAnalizeTouched
{
	GrowthAnalizeViewController *growthAnalizeViewController=
	[[GrowthAnalizeViewController alloc] initWithNibName:@"GrowthAnalizeViewController" bundle:nil];
	
	//growthAnalizeViewController.currentMenu=1;
	[self.navigationController pushViewController:growthAnalizeViewController animated:YES];
	[growthAnalizeViewController release];

}
-(IBAction)btnGoToGrowthEstimateTouched
{
	GrowthEstimateBabyController *growthEstimateBabyController=
	[[GrowthEstimateBabyController alloc] initWithNibName:@"GrowthEstimateBabyController" bundle:nil];
	
	//growthAnalizeViewController.currentMenu=1;
	[self.navigationController pushViewController:growthEstimateBabyController animated:YES];
	[growthEstimateBabyController release];
	
}

-(IBAction)btnGoToGrowthBMIMeasureTouched
{
	GrowthBMIMeasureController *growthBMIMeasureController=
	[[GrowthBMIMeasureController alloc] initWithNibName:@"GrowthBMIMeasureController" bundle:nil];
	
	//growthAnalizeViewController.currentMenu=1;
	[self.navigationController pushViewController:growthBMIMeasureController animated:YES];
	[growthBMIMeasureController release];
	
}

-(IBAction)btnGoToGrowthHistoryTouched
{
	GrowthHistoryResultController *growthHistoryResultController=
	[[GrowthHistoryResultController alloc] initWithNibName:@"GrowthHistoryResultController" bundle:nil];
	
	//growthAnalizeViewController.currentMenu=1;
	[self.navigationController pushViewController:growthHistoryResultController animated:YES];
	[growthHistoryResultController release];	
//	[self ShowMessageBox:@"조만간 성장 이력 기능을 \n 제공할 예정입니다.\n 조금만 기다려 주세요^^"];
//	return FALSE;
}

-(IBAction)btnGoToFaceBookPageTouched
{
	NSURL *url = [[NSURL alloc] initWithString: @"http://m.facebook.com/profile.php?id=356267797790791"];
	[[UIApplication sharedApplication] openURL:url];
}

//============================================================================================================
// 메세지박스를 원하는 텍스트로 띄워준다.
//============================================================================================================
-(void) ShowMessageBox:(NSString*)message
{
	UIAlertView *warn;
	warn= [[UIAlertView alloc]	initWithTitle:nil
									 message:message
									delegate:nil
						   cancelButtonTitle:@"확인"
						   otherButtonTitles:nil];
	
	[warn show];		
	[warn release];
	
}
#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */




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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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





#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

