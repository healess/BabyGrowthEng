//
//  RootViewController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "GrowthHistoryResultController.h"
#import "GrowthHistoryResultDetailController.h"
#import <QuartzCore/QuartzCore.h>
@implementation GrowthHistoryResultController
@synthesize tableViewList;
@synthesize Gender; 
@synthesize toolbar;
@synthesize timer;
@synthesize second;
//============================================================================================================
// 페이스북 공유 버튼 누를시.
//============================================================================================================
-(IBAction)btnFacebookShareTouched
{
	
	BABYGROWTHAppDelegate *appDelegate=(BABYGROWTHAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	
	//버튼을 숨긴후...
	btnCancel.hidden=YES;
	btnFacebookShare.hidden=YES;
	
	
	//화면캡쳐실시한다-레티나인지 아닌지 구별해서..
	if ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] )
	{
		if ( [[UIScreen mainScreen] scale] == 2.0) 
		{
			//레티나
			appDelegate.capturedImage=[self captureScreenInRect:CGRectMake(0,0,640,960)];
			NSLog(@"본기기는 레티나 디스플레이임 (640x960)");
		} 
		else 
		{    
			//일반	
			appDelegate.capturedImage=[self captureScreenInRect:CGRectMake(0,0,320,480)];
			NSLog(@"본기기는 일반 디스플레이임  (320x480)");
		}
	}	
	
	//다시버튼을 보여준다.
	btnCancel.hidden=NO;
	btnFacebookShare.hidden=NO;
	
	
	//모달 디스플레이
	FaceBookShareViewController *controller=[[FaceBookShareViewController alloc] initWithNibName:@"FaceBookShareViewController" bundle:nil];
	controller.delegate=self;
	
	controller.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:controller animated:YES];
}

/*====================================================================================
 캡쳐한다.
 ====================================================================================*/
- (UIImage *)captureScreenInRect:(CGRect)captureFrame
{ 
	
	CALayer *layer; 
    layer = self.view.layer; 
    
	//레티나인지 아닌지 구별해서..
	if ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] )
	{
		if ( [[UIScreen mainScreen] scale] == 2.0) 
		{
			//레티나
			UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.5);
		} 
		else 
		{    
			//일반	
			//UIGraphicsBeginImageContext(self.view.bounds.size); //일반...
			UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.5);
		}
	}
	
	CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame); 
    [layer renderInContext:UIGraphicsGetCurrentContext()]; 
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext(); 
	UIGraphicsEndImageContext(); 
    return screenImage; 	
} 

//============================================================================================================
// 팝업닫기
//============================================================================================================

-(void) faceBookShareViewControllerDidFinish:(FaceBookShareViewController*)controller
{
	[self dismissModalViewControllerAnimated:YES];
	//[tableView reloadData];
	
}

/*======================================================================================
 뷰가나타날때 리뷰쓰라고 권고하는 창을 띄워주기 위해 대기하는 타이머
 ======================================================================================*/
-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	self.timer=[NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(UPDATE_TIME) userInfo:nil repeats:YES];		
	[self setSecond:0];
	
}

/*======================================================================================
 뷰가 사라질때는 타이머를 뜬다.
 ======================================================================================*/

-(void) viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:YES];
	[self setSecond:0];
	[self.timer invalidate];
}


/*======================================================================================
 타이머에 의해 호출되는 함수
 ======================================================================================*/
-(void) UPDATE_TIME
{
	
	int newsecond=[self second]+1;
	[self setSecond:newsecond];	
	NSLog(@"Second:%d",[self second]);
	
	if([self second]>=3)
	{
		[self setSecond:0];
		[self.timer invalidate];//타이머 멈춤
		BABYGROWTHAppDelegate *appDelegate=(BABYGROWTHAppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate ShowMessageBoxRequireReview];
	}
}

//===============================================================================================
// Table View 테이블 내의 섹션수
//===============================================================================================
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

//===============================================================================================
// Table View 섹션내의 로우수
//===============================================================================================
-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger) section
{
	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate retrieveHistoryFromDatabase:nameBtn.titleLabel.text]; //일단 기본 DATA는 파라미터 KSS로 테스트
	int rowCount=[[appDelegate DBData] count];
	return rowCount;
}

//===============================================================================================
// Table View 의 각 옵션 그룹의 Cell 들의 내용을 구성
//===============================================================================================
-(UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell=[table dequeueReusableCellWithIdentifier:@"GrowthHistoryTable"]; //GrowthHistoryTable 로 이름 지어진 Cell 이 큐에 있나?...있으면 재사용
	if(cell==nil)
	{
		//cell=[[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"GrowthHistoryTable"] autorelease]; //최초이면 메모리 할당
		[[NSBundle mainBundle] loadNibNamed:@"GrowthHistoryResultControllerCell" owner:self options:nil];
		cell=tableViewCell;
	}
	
	//DB에서...
	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate retrieveHistoryFromDatabase:nameBtn.titleLabel.text]; //일단 기본 DATA는 파라미터 KSS로 테스트
//	InfantData *mData=[[appDelegate DBData] objectAtIndex:indexPath.row];
	 mData=[[appDelegate DBData] objectAtIndex:indexPath.row];

	//성별 먼저 셋팅
	Gender.text=mData.mGender;

	//측정년월일
	UILabel *lblDate=(UILabel*)[cell viewWithTag:1];
	lblDate.text=mData.mDate;

	//년
	UILabel *lblYear=(UILabel*)[cell viewWithTag:2];
	lblYear.text=[mData.mYear stringByAppendingString:@" Year"];
	
	//월
	UILabel *lblMonth=(UILabel*)[cell viewWithTag:9];
	lblMonth.text=[mData.mMonth stringByAppendingString:@" Month"];
	
	
	//키
	//미국단위 추가 (2012.10)
	UILabel *lblHeight=(UILabel*)[cell viewWithTag:3];
	//lblHeight.text=[mData.mHeight stringByAppendingString:@"cm"];
	lblHeight.text=mData.mHeight;
	
	//키백분율
	UILabel *lblHeightPercent=(UILabel*)[cell viewWithTag:6];
	if([mData.mHeightPercent isEqualToString:@"초과"])
	{
		lblHeightPercent.textColor=[UIColor redColor];
		lblHeightPercent.text=[@"(" stringByAppendingString:[mData.mHeightPercent stringByAppendingString:@")"]];
	}
	else
	{
		lblHeightPercent.textColor=[UIColor blueColor];
		lblHeightPercent.text=[@"(" stringByAppendingString:[mData.mHeightPercent stringByAppendingString:@"%)"]];
	}

	//몸무게
	UILabel *lblWeight=(UILabel*)[cell viewWithTag:4];
	//미국단위 추가 (2012.10)	
	lblWeight.text=mData.mWeight;
	//	lblWeight.text=[mData.mWeight stringByAppendingString:@"kg"];
	
	//몸무게백분율
	UILabel *lblWeightPercent=(UILabel*)[cell viewWithTag:7];
	if([mData.mWeightPercent isEqualToString:@"초과"])
	{
		lblWeightPercent.textColor=[UIColor redColor];
		lblWeightPercent.text=[@"(" stringByAppendingString:[mData.mWeightPercent stringByAppendingString:@")"]];
	}
	else
	{
		lblWeightPercent.textColor=[UIColor blueColor];
		lblWeightPercent.text=[@"(" stringByAppendingString:[mData.mWeightPercent stringByAppendingString:@"%)"]];
	}
	
	//머리둘레
	UILabel *lblLength=(UILabel*)[cell viewWithTag:5];
	//미국단위 추가 (2012.10)		
	lblLength.text=mData.mLength;
	//	lblLength.text=[mData.mLength stringByAppendingString:@"cm"];
	
	//머리둘레백분율
	UILabel *lblLengthPercent=(UILabel*)[cell viewWithTag:8];
	if([mData.mLengthPercent isEqualToString:@"초과"])
	{
		lblLengthPercent.textColor=[UIColor redColor];
		lblLengthPercent.text=[@"(" stringByAppendingString:[mData.mLengthPercent stringByAppendingString:@")"]];
	}
	else
	{
		lblLengthPercent.textColor=[UIColor blueColor];
		lblLengthPercent.text=[@"(" stringByAppendingString:[mData.mLengthPercent stringByAppendingString:@"%)"]];
	}
	//cell.textLabel.text=mData.mDate;
	return cell;
}

//===============================================================================================
// Cell 의 폭과 맞춰줌...
//===============================================================================================

-(CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	return 35;
}

//===============================================================================================
// 각 셀들을 선택할때
//===============================================================================================
-(void) tableView:(UITableView*)table didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath
{
	
	//DB를 읽어서..
	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate retrieveHistoryFromDatabase:nameBtn.titleLabel.text]; //일단 기본 DATA는 파라미터 KSS로 테스트
	mData=[[appDelegate DBData] objectAtIndex:newIndexPath.row];
//	mData=[[appDelegate DBData] objectAtIndex:newIndexPath.row];
	
	
	[self ShowMessageBox2:@"Delete?"];
    [super viewDidLoad];

//	[self alertView:<#(UIAlertView *)alertView#> clickedButtonAtIndex:<#(NSInteger)buttonIndex#>];
//	BABYGROWTHAppDelegate *appDelegate2 = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
//	[appDelegate2 deleteHistoryToDatabase:mData.mIndex2]; //일단 기본 DATA는 파라미터 KSS로 테스트	
	/*
	//이력상세정보표시하면서 인덱스를 넘김.
	GrowthHistoryResultDetailController *growthHistoryResultDetailController=
	[[GrowthHistoryResultDetailController alloc] initWithNibName:@"GrowthHistoryResultDetailController" bundle:nil];
	growthHistoryResultDetailController.delIndex=mData.mIndex2;//삭제할 이력의 인덱스를 넘김
	[self.navigationController pushViewController:growthHistoryResultDetailController animated:YES];
	 */
}
//============================================================================================================
// 메세지박스를 원하는 텍스트로 띄워준다.
//============================================================================================================
-(void) ShowMessageBox2:(NSString*)message
{
	UIAlertView *warn;
	warn= [[UIAlertView alloc]	initWithTitle:nil
									 message:message
									delegate:self
						   cancelButtonTitle:@"Calcel"
						   otherButtonTitles:@"OK",nil];
	
	[warn show];	
	[warn release];
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex { 
	switch(buttonIndex) {
		case 0:
			//cancel
			//NSLog(@" %i ",buttonIndex);

			break;
		case 1:
			//ok
			//해당 View를 화면에 보이도록 처리
			NSLog(@" %i ",mData.mIndex2);
			
			BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
			[appDelegate deleteHistoryToDatabase:[[NSString alloc] initWithFormat:@"%i", mData.mIndex2]]; //일단 기본 DATA는 파라미터 KSS로 테스트
			[tableViewList reloadData];

			
			break;
		default:
			break;
	}
}
//===============================================================================================
//처음 화면 로딩 시 DATA조회
//===============================================================================================

- (void)viewDidLoad 
{
	
    [super viewDidLoad];
	//DB생성체크 부분
    sqlite3 *database;	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];//디렉토리 경로
	NSString *DBPath = [documentsDir stringByAppendingPathComponent:@"infantDB.db"];//경로 담기	
	//NSLog(@"DB생성부분 타나?");
	if (sqlite3_open([DBPath UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Failed to open database");
	}
	char *errorMsg;
	NSString *createSQL = @"CREATE TABLE  if not exists Tb_Growth_History(MP_Index INTEGER PRIMARY KEY autoincrement,	Child_Name TEXT,Gender TEXT,Current_Date TEXT,Birth_Year TEXT,Birth_Month TEXT,Height_Value TEXT,	Height_Percent TEXT, Weight_Value TEXT,	Weight_Percent TEXT,	Leight_Value TEXT,	Leight_Percent TEXT	);";
	
	if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert1(0, @"Error creating table: %s", errorMsg);
	}	
	
	

	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
//	[appDelegate retrieveHistoryFromDatabase:@"%"]; //일단 기본 DATA는 파라미터 KSS로 테스트
	[appDelegate retrieveChildNameFromDatabase];
	int rowCount=[[appDelegate DBData] count];
	NSLog(@" %i ",rowCount);

	//아무것도 입력 안했을때
	if (rowCount==0) {
		[nameBtn setTitle:@"Select" forState:UIControlStateNormal];	
		Gender.text=@"";

	}else{//한명이라도 입력되었을때
	//int rowCount = [[appDelegate DBData] count];//총 로우수 테이블 구성시 루프 돌면서 구현 필요
	InfantData *mData=[[appDelegate DBData] objectAtIndex:0];
	[nameBtn setTitle:mData.mName forState:UIControlStateNormal];	
	//Name.titleLabel.text=mData.mName;
	//childNameValues = [[NSArray alloc] initWithObjects:@"KSS",@"ABC",nil];
	 childNameValues = [[NSMutableArray alloc]initWithObjects: nil];
		for(int i=0 ; i<rowCount; i++){
			InfantData *mData=[[appDelegate DBData] objectAtIndex:i];
			[childNameValues addObject:mData.mName];
		}

		
		childNamePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
		//childNamePicker.tag = MONTH_TAG;
		childNamePicker.showsSelectionIndicator = TRUE;
		childNamePicker.dataSource = self;
		childNamePicker.delegate = self;
		childNamePicker.hidden = YES;
		
		toolbar = [UIToolbar new];
		toolbar.barStyle = UIBarStyleBlackTranslucent;
		[toolbar sizeToFit];
		[toolbar setFrame:CGRectMake(0,215,400,50)];
		toolbar.hidden = YES;	
	}
 }
-(IBAction) selectChildName{	
	if ( childNamePicker.hidden) {
		childNamePicker.hidden = NO;
		[self.view addSubview:childNamePicker];
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
		//[yearValuePicker selectRow:12 inComponent:0 animated:NO];
	}
	else {
		childNamePicker.hidden = YES;
		toolbar.hidden = YES;
		[childNamePicker removeFromSuperview];
	}
}


//피커별 열 갯수 설정 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{	
	return 1;
}
//피커내 로우수 결정
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [childNameValues count];
}
//컬럼 별 피커 값 설정
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [childNameValues objectAtIndex:row];
	
}
//버튼에 피커 Value 셋 하는 부분
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSString *tempChild  = [childNameValues objectAtIndex:[childNamePicker selectedRowInComponent:0]];
	[nameBtn setTitle:tempChild forState:UIControlStateNormal];	
	//Gender.text=mData.mGender;//성별 셋팅
}


//높이설정
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

//툴바생성
- (void)createToolbarItems{  
	
	/*UIBarButtonItem *systemItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:mItem     target:self action:@selector(action:)];
	 
	 NSArray *items = [NSArray arrayWithObjects: systemItem,  nil];
	 
	 [self.toolbar setItems:items animated:NO];
	 */
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed:)] autorelease];
	//[toolbar setItems:[NSArray arrayWithObjects:sendButton, cancelButton, nil]];
	
	[toolbar setItems:[NSArray arrayWithObjects:doneButton, nil]];	
}

//뷰제거
- (void)disappearAll{
	if ( !childNamePicker.hidden) 
	{
		childNamePicker.hidden = YES;		
	}
	if ( !toolbar.hidden) 
	{
		toolbar.hidden = YES;
	}	
	[tableViewList reloadData];//재조회
}
- (void) doneButtonPressed:(id)sender
{
	[self disappearAll];
}
//배경 클릭 시 키보드 제거 혹은 피커 뷰 제거 기능
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	//  [super touchesBegan:touches withEvent:event];
	[self disappearAll];
	
}

-(IBAction) btnCancelTouched
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[childNameValues release];

	[childNamePicker release];

    [super dealloc];
}


@end
