//
//  GrowthEstimateBabyController.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "GrowthEstimateBabyController.h"
#import "GrowthEstimateViewController.h"
#import "BABYGROWTHAppDelegate.h"
#import "InfantData.h"

//해당 피커별 태그를 두어 필요한 피커 호출
#define GENDER_TAG 1
#define YEAR_TAG 2
#define MONTH_TAG 3
#define HEIGHT_TAG 4
//미국단위 추가 (2012.10)
#define HEIGHT_FT_TAG 5
//미국단위 추가 (2012.10)

@implementation GrowthEstimateBabyController

@synthesize btnGoToGrowthEstimateAdult;
@synthesize btnCancel;
//미국단위 추가 (2012.10)
@synthesize segGender,segHeight;
//미국단위 추가 (2012.10)

//property로 지정한 delegate를 다른 오브젝트에서 써줘야 하니 @synthesize로 접근가능하게 하는걸 잊지 맙시다.
@synthesize delegate; 
@synthesize toolbar;
#pragma mark -
#pragma mark View lifecycle
//============================================================================================================
// 메세지박스를 원하는 텍스트로 띄워준다.
//============================================================================================================
-(void) ShowMessageBox:(NSString*)message
{
	UIAlertView *warn;
	warn= [[UIAlertView alloc]	initWithTitle:nil
									 message:message
									delegate:nil
						   cancelButtonTitle:@"OK"
						   otherButtonTitles:nil];
	
	[warn show];		
	[warn release];
	
}
//============================================================================================================
// 남아/여아 segmented control 선택시..
//============================================================================================================
-(IBAction) segGenderSelected
{
	if([segGender selectedSegmentIndex]==0)
	{		
		[self.segGender setImage:[UIImage imageNamed:@"man_on.png"] forSegmentAtIndex:0];
		[self.segGender setImage:[UIImage imageNamed:@"woman_off.png"] forSegmentAtIndex:1];
		[genderTypeBtn setTitle:@"B" forState:UIControlStateNormal];
		[[NSUserDefaults standardUserDefaults] setObject:@"B" forKey:@"keyGrowEstimateGender"]; //저장값기억(2012.03.04 by 서정범
	}
	else if([segGender selectedSegmentIndex]==1)
	{
		[self.segGender setImage:[UIImage imageNamed:@"man_off.png"] forSegmentAtIndex:0];
		[self.segGender setImage:[UIImage imageNamed:@"woman_on.png"] forSegmentAtIndex:1];
		[genderTypeBtn setTitle:@"G" forState:UIControlStateNormal];
		[[NSUserDefaults standardUserDefaults] setObject:@"G" forKey:@"keyGrowEstimateGender"]; //저장값기억(2012.03.04 by 서정범
	}
}
//미국단위 추가 (2012.10)
-(IBAction) segHeightSelected
{
	if([segHeight selectedSegmentIndex]==0)
	{		
		[self.segHeight setImage:[UIImage imageNamed:@"btn_ftin02.png"] forSegmentAtIndex:0];
		[self.segHeight setImage:[UIImage imageNamed:@"btn_cm01.png"] forSegmentAtIndex:1];
		segHeightValue=@"ft";
		[[NSUserDefaults standardUserDefaults] setObject:@"ft" forKey:@"keyGrowEstimateHeightUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	else if([segHeight selectedSegmentIndex]==1)
	{
		[self.segHeight setImage:[UIImage imageNamed:@"btn_ftin01.png"] forSegmentAtIndex:0];
		[self.segHeight setImage:[UIImage imageNamed:@"btn_cm02.png"] forSegmentAtIndex:1];
		segHeightValue=@"cm";
		[[NSUserDefaults standardUserDefaults] setObject:@"cm" forKey:@"keyGrowEstimateHeightUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	//NSLog(segHeightValue); 
}
//미국단위 추가 (2012.10)



-(IBAction)btnGoToGrowthEstimateAdultTouched
{
	//입력값 널체크
	if(genderTypeBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Please choose the sex."];
		return;
	}
	if(yearBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Input date of birth."];
		return;
	}
	if(monthBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Input date of birth."];
		return;
	}
	if(heightBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Input height."];
		return;
	}
	if([heightBtn.titleLabel.text intValue]==0)
	{
		[self ShowMessageBox:@"Please input Height over 0 in or 0 cm."];//키는 0 cm 가 될 수 없습니다. 다시 입력해 주세요
		return;
	}

	
	//입력값에 대한 Validation 체크를 한다.
	if([self checkInputValueValid:genderTypeBtn.titleLabel.text Year:yearBtn.titleLabel.text Month:monthBtn.titleLabel.text Height:heightBtn.titleLabel.text])
	{

		
		GrowthEstimateViewController *growthEstimateViewController=
		[[GrowthEstimateViewController alloc] initWithNibName:@"GrowthEstimateViewController" bundle:nil];
		[self.navigationController pushViewController:growthEstimateViewController animated:YES];
		[growthEstimateViewController calcualteBabyHeightPercent:genderTypeBtn.titleLabel.text Year:yearBtn.titleLabel.text Month:monthBtn.titleLabel.text Height:heightBtn.titleLabel.text];	
		[growthEstimateViewController release];		
		
	}
	
}


//============================================================================================================
// 입력값에 대한 Validation 체크를 한다.
//============================================================================================================
-(BOOL)checkInputValueValid:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight
{
	/*
	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate calculateHeightFromDatabase:pGender Year:pYear Month:pMonth Height:pHeight];
	NSLog(@" %@ ",pHeight);
	
	InfantData *mData = [[appDelegate DBData] objectAtIndex:0];

	NSLog(@" %@ ",mData.mPercent);
	
	if([mData.mPercent isEqualToString:@"값이상"])
	{
		[self ShowMessageBox:@"입력한 값은 측정할 수 없는 범위내에 있습니다.\n 확인후 다시 입력해 주세요"];
		return FALSE;
	}
	return TRUE;*/
	
	NSDate* today = [NSDate date];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"yyyy-MM"];
	NSString *str1 =[dateFormatter stringFromDate:today];	
	NSString *str2 =[dateFormatter stringFromDate:today];	
	
	str1=[str1 substringToIndex:4];//년구하기
	str2=[str2 substringFromIndex:5];//월구하기
	int currentYear=[str1 intValue];
	int currentMonth=[str2 intValue];
	
	int birthYear=[pYear intValue];
	int birthMonth=[pMonth intValue];
	
	if(currentYear==birthYear && birthMonth>currentMonth){
		[self ShowMessageBox:@"Input the correct birth."];
		return FALSE;
	}
	return TRUE;
}

-(IBAction) btnCancelTouched
{
	[self.navigationController popViewControllerAnimated:YES];
}

//배경 클릭 시 키보드 제거 혹은 피커 뷰 제거 기능
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
    [super touchesBegan:touches withEvent:event];
	[self disappearAll];
	
}



- (void)viewDidLoad {
    [super viewDidLoad];
	//미국단위 추가 (2012.10)
	segHeightValue=@"ft"; //최초로딩시 디폴트값 설정 필요
	//미국단위 추가 (2012.10)	
	NSDate* today = [NSDate date];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"yyyy-MM"];
	NSString *str1 =[dateFormatter stringFromDate:today];	
	str1=[str1 substringToIndex:4];//년구하기
	int year=[str1 intValue];
	
	
	yearValues = [[NSArray alloc] initWithObjects:[[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],	  
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],	  
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],	
				  [[NSString alloc] initWithFormat:@"%i", year--],
				  [[NSString alloc] initWithFormat:@"%i", year--],	
				  nil]; //년	
	
	//yearValues = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil]; //년
	monthValues = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];  //월
	heightValues = [[NSArray alloc] initWithObjects:@"",@"1",nil]; //키 
	heightValues2 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키 
	heightValues3 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키 
	heightValues4 = [[NSArray alloc] initWithObjects:@"cm",nil]; //키
	
	//미국단위 추가 (2012.10)
	heightFtValues = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키(ft)
	heightFtValues2 = [[NSArray alloc] initWithObjects:@"ft ",nil]; //키(ft)
	heightFtValues3 = [[NSArray alloc] initWithObjects:@"0.",@"1.",@"2.",@"3.",@"4.",@"5.",@"6.",@"7.",@"8.",@"9.",@"10.",@"11.",nil]; //키(in)
	heightFtValues4 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키(in)
	heightFtValues5 = [[NSArray alloc] initWithObjects:@"in",nil]; //키(ft)	
	//미국단위 추가 (2012.10)

	toolbar = [UIToolbar new];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [toolbar sizeToFit];
	//   CGFloat toolbarHeight = [toolbar frame].size.height;
	//   CGRect mainViewBounds = self.view.bounds;
	//    [toolbar setFrame:CGRectMake(CGRectGetMinX	(mainViewBounds),CGRectGetMinY(mainViewBounds) + CGRectGetHeight(mainViewBounds) - (toolbarHeight * 2.0) + 2.0, CGRectGetWidth(mainViewBounds), toolbarHeight)];
    [toolbar setFrame:CGRectMake(0,215,400,50)];
	// [self.view addSubview:toolbar];
	// [self createToolbarItems];
	toolbar.hidden = YES;
	
	
	
	yearValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	//	yearValuePicker.backgroundColor = [UIColor blueColor];
	yearValuePicker.tag = YEAR_TAG;
	yearValuePicker.showsSelectionIndicator = TRUE;
	yearValuePicker.hidden = YES;
	yearValuePicker.dataSource = self;
	yearValuePicker.delegate = self;
	
	monthValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	monthValuePicker.tag = MONTH_TAG;
	monthValuePicker.showsSelectionIndicator = TRUE;
	monthValuePicker.dataSource = self;
	monthValuePicker.delegate = self;
	monthValuePicker.hidden = YES;
	
	heightValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	heightValuePicker.tag = HEIGHT_TAG;
	heightValuePicker.showsSelectionIndicator = TRUE;
	heightValuePicker.dataSource = self;
	heightValuePicker.delegate = self;
	heightValuePicker.hidden = YES;
	
	//미국단위 추가 (2012.10)
	heightFtValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	heightFtValuePicker.tag = HEIGHT_FT_TAG;
	heightFtValuePicker.showsSelectionIndicator = TRUE;
	heightFtValuePicker.dataSource = self;
	heightFtValuePicker.delegate = self;
	heightFtValuePicker.hidden = YES;	
	//미국단위 추가 (2012.10)
	
	//기억값표시 2012.3.4 by 서정범
	[genderTypeBtn	setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateGender"]		forState:UIControlStateNormal];
	if([genderTypeBtn.titleLabel.text isEqualToString:@"B"])
	{
		[segGender setSelectedSegmentIndex:0];
	}
	else if([genderTypeBtn.titleLabel.text isEqualToString:@"G"])
	{
		[segGender setSelectedSegmentIndex:1];
	}
	[yearBtn		setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateBirthYear"]	forState:UIControlStateNormal];
	[monthBtn		setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateBirthMonth"]	forState:UIControlStateNormal];
	[heightBtn		setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateHeight"]		forState:UIControlStateNormal];
	if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateHeightUnit"] isEqualToString:@"ft"])
	{
		[segHeight setSelectedSegmentIndex:0];
	}
	else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateHeightUnit"] isEqualToString:@"cm"])
	{
		[segHeight setSelectedSegmentIndex:1];
	}
}

//피커별 열 갯수 설정 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{	
	if (pickerView.tag == YEAR_TAG){
		return 1;
	}
	if (pickerView.tag == MONTH_TAG){
		return 1;
	}	
	if (pickerView.tag == HEIGHT_TAG){
		return 4;
	}
	//미국단위 추가 (2012.10)	
	if (pickerView.tag == HEIGHT_FT_TAG){
		return 5;
	}		
	//미국단위 추가 (2012.10)		
	return 1;
}

//피커내 로우수 결정
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (pickerView.tag == YEAR_TAG){
		return [yearValues count];
	}
	if (pickerView.tag == MONTH_TAG){
		return [monthValues count];
	}	
	if (pickerView.tag == HEIGHT_TAG){
		switch(component)
		{
			case 0:
				return [heightValues count];
				break;
			case 1:
				return [heightValues2 count];
				break;
			case 2:
				return [heightValues3 count];
				break;
			case 3:
				return [heightValues4 count];
				break;
		}	
	}
	//미국단위 추가 (2012.10)
	if (pickerView.tag == HEIGHT_FT_TAG){
		switch(component)
		{
			case 0:
				return [heightFtValues count];
				break;
			case 1:
				return [heightFtValues2 count];
				break;
			case 2:
				return [heightFtValues3 count];
				break;
			case 3:
				return [heightFtValues4 count];
				break;
			case 4:
				return [heightFtValues5 count];
				break;
		}	
	}		
	//미국단위 추가 (2012.10)	
	return 1;
}

//컬럼 별 피커 값 설정
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (pickerView.tag == YEAR_TAG)
	{
		return [yearValues objectAtIndex:row];
	}
	if (pickerView.tag == MONTH_TAG)
	{
		return [monthValues objectAtIndex:row];
	}
	if (pickerView.tag == HEIGHT_TAG)
	{
		switch(component)
		{
			case 0:
				return [heightValues objectAtIndex:row];
				break;
			case 1:
				return [heightValues2 objectAtIndex:row];
				break;
			case 2:
				return [heightValues3 objectAtIndex:row];
				break;
			case 3:
				return [heightValues4 objectAtIndex:row];
				break;
		}	
	}
	//미국단위 추가 (2012.10)
	if (pickerView.tag == HEIGHT_FT_TAG)
	{
		switch(component)
		{
			case 0:
				return [heightFtValues objectAtIndex:row];
				break;
			case 1:
				return [heightFtValues2 objectAtIndex:row];
				break;
			case 2:
				return [heightFtValues3 objectAtIndex:row];
				break;
			case 3:
				return [heightFtValues4 objectAtIndex:row];
				break;
			case 4:
				return [heightFtValues5 objectAtIndex:row];
				break;
		}	
	}	
	//미국단위 추가 (2012.10)	
	return [yearValues objectAtIndex:row];
}

//버튼에 피커 Value 셋 하는 부분
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (pickerView.tag == YEAR_TAG)
	{
		NSString *yearValue  = [yearValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[yearBtn setTitle:yearValue forState:UIControlStateNormal];				
	}	
	if (pickerView.tag == MONTH_TAG)
	{
		NSString *monthValue  = [monthValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[monthBtn setTitle:monthValue forState:UIControlStateNormal];				
	}	
	if (pickerView.tag == HEIGHT_TAG)
	{
		NSString *Value1  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [heightValues2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [heightValues3 objectAtIndex:[pickerView selectedRowInComponent:2]];
		//미국단위 추가 (2012.10)	
		NSString *Value4  = [heightValues4 objectAtIndex:[pickerView selectedRowInComponent:3]];
		//미국단위 추가 (2012.10)	
		NSString *heightValueTemp=[Value1 stringByAppendingString:Value2];
		heightValueTemp=[heightValueTemp stringByAppendingString:Value3];
		//미국단위 추가 (2012.10)	
		heightValueTemp=[heightValueTemp stringByAppendingString:Value4];
		//미국단위 추가 (2012.10)			
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[heightBtn setTitle:heightValueTemp forState:UIControlStateNormal];		
		NSLog(@" %@ ",heightValueTemp);
	}	
	//미국단위 추가 (2012.10)	
	if (pickerView.tag == HEIGHT_FT_TAG)
	{
		NSString *Value1  = [heightFtValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [heightFtValues2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [heightFtValues3 objectAtIndex:[pickerView selectedRowInComponent:2]];
		NSString *Value4  = [heightFtValues4 objectAtIndex:[pickerView selectedRowInComponent:3]];
		NSString *Value5  = [heightFtValues5 objectAtIndex:[pickerView selectedRowInComponent:4]];
		
		NSString *heightFtValueTemp=[Value1 stringByAppendingString:Value2];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value3];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value4];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value5];		
		
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[heightBtn setTitle:heightFtValueTemp forState:UIControlStateNormal];		
		NSLog(@" %@ ",heightFtValueTemp);
	}	
	//미국단위 추가 (2012.10)		
}

//각 분리된 항목별 디스플레이면적
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 100.0;
	if (pickerView.tag == HEIGHT_TAG) {
		switch(component)
		{
			case 0:
				componentWidth = 60.0;// first column size is wider to hold names
				break;
			case 1:
				componentWidth = 60.0;// first column size is wider to hold names
				break;
			case 2:
				componentWidth = 60.0;// first column size is wider to hold names
				break;
			case 3:
				componentWidth = 100.0;// first column size is wider to hold names
				break;
		}		
	}		
	//미국단위 추가 (2012.10)
	if (pickerView.tag == HEIGHT_FT_TAG) {
		switch(component)
		{
			case 0:
				componentWidth = 60.0;// first column size is wider to hold names
				break;
			case 1:
				componentWidth = 55.0;// first column size is wider to hold names
				break;
			case 2:
				componentWidth = 60.0;// first column size is wider to hold names
				break;
			case 3:
				componentWidth = 40.0;// first column size is wider to hold names
				break;
			case 4:
				componentWidth = 55.0;// first column size is wider to hold names
				break;
		}		
	}		
	//미국단위 추가 (2012.10)	
	return componentWidth;
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
	if ( !yearValuePicker.hidden) 
	{
		yearValuePicker.hidden = YES;
		NSString *yearValue  = [yearValues objectAtIndex:[yearValuePicker selectedRowInComponent:0]];
		[yearBtn setTitle:yearValue forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:yearValue forKey:@"keyGrowEstimateBirthYear"]; //저장값기억(2012.03.04 by 서정범
	}
	if ( !monthValuePicker.hidden) 
	{
		monthValuePicker.hidden = YES;
		NSString *monthValue  = [monthValues objectAtIndex:[monthValuePicker selectedRowInComponent:0]];
		[monthBtn setTitle:monthValue forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:monthValue forKey:@"keyGrowEstimateBirthMonth"]; //저장값기억(2012.03.04 by 서정범
	}
	if ( !heightValuePicker.hidden) 
	{
		heightValuePicker.hidden = YES;
		NSString *Value1  = [heightValues objectAtIndex:[heightValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [heightValues2 objectAtIndex:[heightValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [heightValues3 objectAtIndex:[heightValuePicker selectedRowInComponent:2]];
		//미국단위 추가 (2012.10)
		NSString *Value4  = [heightValues4 objectAtIndex:[heightValuePicker selectedRowInComponent:3]];
		//미국단위 추가 (2012.10)
		NSString *heightValueTemp=[Value1 stringByAppendingString:Value2];
		heightValueTemp=[heightValueTemp stringByAppendingString:Value3];
		//미국단위 추가 (2012.10)
		heightValueTemp=[heightValueTemp stringByAppendingString:Value4];
		//미국단위 추가 (2012.10)
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[heightBtn setTitle:heightValueTemp forState:UIControlStateNormal];		
		[[NSUserDefaults standardUserDefaults] setObject:heightValueTemp forKey:@"keyGrowEstimateHeight"]; //저장값기억(2012.03.04 by 서정범
		NSLog(@" %@ ",heightValueTemp);
	}
	//미국단위 추가 (2012.10)
	if ( !heightFtValuePicker.hidden) 
	{
		heightFtValuePicker.hidden = YES;
		NSString *Value1  = [heightFtValues objectAtIndex:[heightFtValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [heightFtValues2 objectAtIndex:[heightFtValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [heightFtValues3 objectAtIndex:[heightFtValuePicker selectedRowInComponent:2]];
		NSString *Value4  = [heightFtValues4 objectAtIndex:[heightFtValuePicker selectedRowInComponent:3]];
		NSString *Value5  = [heightFtValues5 objectAtIndex:[heightFtValuePicker selectedRowInComponent:4]];
		
		NSString *heightFtValueTemp=[Value1 stringByAppendingString:Value2];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value3];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value4];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value5];		
		
		[heightBtn setTitle:heightFtValueTemp forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:heightFtValueTemp forKey:@"keyGrowEstimateHeight"]; //저장값기억(2012.03.04 by 서정범
		//NSLog(@" %@ ",heightFtValueTemp);
	}	
	//미국단위 추가 (2012.10)
	
	if ( !toolbar.hidden) 
	{
		toolbar.hidden = YES;
	}	
	
	
}
- (void) doneButtonPressed:(id)sender
{
	[self disappearAll];
}

//버튼 클릭 시 해당 피커 호출 
-(IBAction) showYearValuePicker{	
	if ( yearValuePicker.hidden) {
		yearValuePicker.hidden = NO;
		[self.view addSubview:yearValuePicker];
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
		//[yearValuePicker selectRow:12 inComponent:0 animated:NO];
	}
	else {
		yearValuePicker.hidden = YES;
		toolbar.hidden = YES;
		[yearValuePicker removeFromSuperview];
	}
}
-(IBAction) showMonthValuePicker{	
	if ( monthValuePicker.hidden) {
		monthValuePicker.hidden = NO;
		[self.view addSubview:monthValuePicker];
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
	//	[monthValuePicker selectRow:6 inComponent:0 animated:NO];

	}
	else {
		monthValuePicker.hidden = YES;
		toolbar.hidden = YES;
		[monthValuePicker removeFromSuperview];
	}
}
-(IBAction) showHeightValuePicker{	
	//미국단위 추가 (2012.10)	
	if ([segHeightValue isEqualToString:@"cm"]) {	
		//미국단위 추가 (2012.10)	
		
	if ( heightValuePicker.hidden) {
		heightValuePicker.hidden = NO;
		[self.view addSubview:heightValuePicker];
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
	//	[heightValuePicker selectRow:5 inComponent:1 animated:NO];
	}
	else {
		heightValuePicker.hidden = YES;
		toolbar.hidden = YES;
		[heightValuePicker removeFromSuperview];
	}
	//미국단위 추가 (2012.10)
	}else if ([segHeightValue isEqualToString:@"ft"]) {
	if ( heightFtValuePicker.hidden) {
		heightFtValuePicker.hidden = NO;
		[self.view addSubview:heightFtValuePicker];
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
		//[heightValuePicker selectRow:5 inComponent:1 animated:NO];
	}
	else {
		heightFtValuePicker.hidden = YES;
		toolbar.hidden = YES;
		[heightFtValuePicker removeFromSuperview];
	}
}	//미국단위 추가 (2012.10)	
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


- (void)dealloc {//릴리즈 확인 필
	[yearValues release];
	[monthValues release];
	[heightValues release];
	[yearValuePicker release];
	[monthValuePicker release];
	[heightValuePicker release];

	//미국단위 추가 (2012.10)
	[heightFtValuePicker release];
	[heightFtValues release];
	[heightFtValues2 release];
	[heightFtValues3 release];
	[heightFtValues4 release];
	[heightFtValues5 release];
	[segHeightValue release];
	[segHeight release];
	
	//미국단위 추가 (2012.10)
    [super dealloc];
}



@end

