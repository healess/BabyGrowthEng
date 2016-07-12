//
//  GrowthEstimateViewController.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "GrowthEstimateViewController.h"
#import "GrowthEstimateResultViewController.h"
#import "BABYGROWTHAppDelegate.h"
#import "InfantData.h"

//해당 피커별 태그를 두어 필요한 피커 호출
#define FATHER_TAG 1
#define MOTHER_TAG 2
//미국단위 추가 (2012.10)
#define HEIGHT_FT_TAG 3
#define HEIGHT_FT_TAG_2 4
//미국단위 추가 (2012.10)
@implementation GrowthEstimateViewController
@synthesize btnGoToGrowthEstimateResult;
@synthesize btnCancel;
@synthesize fatherHeightBtn;
@synthesize motherHeightBtn;
@synthesize toolbar;
@synthesize delegate; 
@synthesize heightPercentValue; 
@synthesize heightValue; 
@synthesize yearValue; 
@synthesize monthValue; 
@synthesize genderValue; 
//미국단위 추가 (2012.10)
@synthesize segHeight,segHeight_2;
//미국단위 추가 (2012.10)

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



-(IBAction)btnGoToGrowthEstimateResult
{
	
	//입력값에대한 널체크를 한다.
	if(fatherHeightBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Please Input Father's Height."];
		return;
	}
	if(motherHeightBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Please Input Mother's Height."];
		return;
	}
	
	
	GrowthEstimateResultViewController *growthEstimateResultViewController=
	[[GrowthEstimateResultViewController alloc] initWithNibName:@"GrowthEstimateResultViewController" bundle:nil];
	
	//growthAnalizeViewController.currentMenu=1;
	[self.navigationController pushViewController:growthEstimateResultViewController animated:YES];
//	[growthEstimateResultViewController calcualteParentHeightValue:fatherHeightBtn.titleLabel.text Mother:motherHeightBtn.titleLabel.text];
	[growthEstimateResultViewController calcualteCurrentHeightValue:self.genderValue.text Year:self.yearValue.text Month:self.monthValue.text Height:self.heightValue.text HeightPercent:self.heightPercentValue.text Father:fatherHeightBtn.titleLabel.text Mother:motherHeightBtn.titleLabel.text];

	[growthEstimateResultViewController release];
}

-(IBAction) btnCancelTouched
{
	[self.navigationController popViewControllerAnimated:YES];
}

//미국단위 추가 (2012.10)
-(IBAction) segHeightSelected
{
	if([segHeight selectedSegmentIndex]==0)
	{		
		[self.segHeight setImage:[UIImage imageNamed:@"btn_ftin02.png"] forSegmentAtIndex:0];
		[self.segHeight setImage:[UIImage imageNamed:@"btn_cm01.png"] forSegmentAtIndex:1];
		segHeightValue=@"ft";
		[[NSUserDefaults standardUserDefaults] setObject:@"ft" forKey:@"keyGrowEstimateFatherHeightUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	else if([segHeight selectedSegmentIndex]==1)
	{
		[self.segHeight setImage:[UIImage imageNamed:@"btn_ftin01.png"] forSegmentAtIndex:0];
		[self.segHeight setImage:[UIImage imageNamed:@"btn_cm02.png"] forSegmentAtIndex:1];
		segHeightValue=@"cm";
		[[NSUserDefaults standardUserDefaults] setObject:@"cm" forKey:@"keyGrowEstimateFatherHeightUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	//NSLog(segHeightValue); 
}

-(IBAction) segHeightSelected_2
{
	if([segHeight_2 selectedSegmentIndex]==0)
	{		
		[self.segHeight_2 setImage:[UIImage imageNamed:@"btn_ftin02.png"] forSegmentAtIndex:0];
		[self.segHeight_2 setImage:[UIImage imageNamed:@"btn_cm01.png"] forSegmentAtIndex:1];
		segHeightValue_2=@"ft";
		[[NSUserDefaults standardUserDefaults] setObject:@"ft" forKey:@"keyGrowEstimateMotherHeightUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	else if([segHeight_2 selectedSegmentIndex]==1)
	{
		[self.segHeight_2 setImage:[UIImage imageNamed:@"btn_ftin01.png"] forSegmentAtIndex:0];
		[self.segHeight_2 setImage:[UIImage imageNamed:@"btn_cm02.png"] forSegmentAtIndex:1];
		segHeightValue_2=@"cm";
		[[NSUserDefaults standardUserDefaults] setObject:@"cm" forKey:@"keyGrowEstimateMotherHeightUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	//NSLog(segHeightValue); 
}
//미국단위 추가 (2012.10)

- (void)viewDidLoad 
{
    [super viewDidLoad];
	//미국단위 추가 (2012.10)
	segHeightValue=@"ft"; //최초로딩시 디폴트값 설정 필요
	segHeightValue_2=@"ft"; //최초로딩시 디폴트값 설정 필요	
	//미국단위 추가 (2012.10)		
	//Done버튼추가
	toolbar = [UIToolbar new];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [toolbar sizeToFit];
    [toolbar setFrame:CGRectMake(0,215,400,50)];
	toolbar.hidden = YES;
	
	fatherHeightValue = [[NSArray alloc] initWithObjects:@"1",nil]; //키 
	fatherHeightValue2 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키 
	fatherHeightValue3 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키 
	fatherHeightValue4 = [[NSArray alloc] initWithObjects:@"cm",nil]; //키

	
	motherHeightValue = [[NSArray alloc] initWithObjects:@"1",nil]; //키 
	motherHeightValue2 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키 
	motherHeightValue3 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키 
	motherHeightValue4 = [[NSArray alloc] initWithObjects:@"cm",nil]; //키

	//미국단위 추가 (2012.10)
	heightFtValues = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키(ft)
	heightFtValues2 = [[NSArray alloc] initWithObjects:@"ft ",nil]; //키(ft)
	heightFtValues3 = [[NSArray alloc] initWithObjects:@"0.",@"1.",@"2.",@"3.",@"4.",@"5.",@"6.",@"7.",@"8.",@"9.",@"10.",@"11.",nil]; //키(in)
	heightFtValues4 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키(in)
	heightFtValues5 = [[NSArray alloc] initWithObjects:@"in",nil]; //키(ft)	

	heightFtValues_2 = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키(ft)
	heightFtValues2_2 = [[NSArray alloc] initWithObjects:@"ft ",nil]; //키(ft)
	heightFtValues3_2 = [[NSArray alloc] initWithObjects:@"0.",@"1.",@"2.",@"3.",@"4.",@"5.",@"6.",@"7.",@"8.",@"9.",@"10.",@"11.",nil]; //키(in)
	heightFtValues4_2 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키(in)
	heightFtValues5_2 = [[NSArray alloc] initWithObjects:@"in",nil]; //키(ft)		
	//미국단위 추가 (2012.10)
	
	
	//해당 피커별 위치 설정 및 속성(태그등) 설정
	fatherHeightValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	fatherHeightValuePicker.tag = FATHER_TAG;
	fatherHeightValuePicker.showsSelectionIndicator = TRUE;
	fatherHeightValuePicker.dataSource = self;
	fatherHeightValuePicker.delegate = self;
	fatherHeightValuePicker.hidden = YES;
	
	motherHeightValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	//	yearValuePicker.backgroundColor = [UIColor blueColor];
	motherHeightValuePicker.tag = MOTHER_TAG;
	motherHeightValuePicker.showsSelectionIndicator = TRUE;
	motherHeightValuePicker.hidden = YES;
	motherHeightValuePicker.dataSource = self;
	motherHeightValuePicker.delegate = self;
	
	//미국단위 추가 (2012.10)
	heightFtValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	heightFtValuePicker.tag = HEIGHT_FT_TAG;
	heightFtValuePicker.showsSelectionIndicator = TRUE;
	heightFtValuePicker.dataSource = self;
	heightFtValuePicker.delegate = self;
	heightFtValuePicker.hidden = YES;	
	
	heightFtValuePicker_2 = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	heightFtValuePicker_2.tag = HEIGHT_FT_TAG;
	heightFtValuePicker_2.showsSelectionIndicator = TRUE;
	heightFtValuePicker_2.dataSource = self;
	heightFtValuePicker_2.delegate = self;
	heightFtValuePicker_2.hidden = YES;		
	//미국단위 추가 (2012.10)
	
	//기억값표시 2012.3.4 by 서정범
	[fatherHeightBtn setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateFatherHeight"]	forState:UIControlStateNormal];
	if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateFatherHeightUnit"] isEqualToString:@"ft"])
	{
		[segHeight setSelectedSegmentIndex:0];
	}
	else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateFatherHeightUnit"] isEqualToString:@"cm"])
	{
		[segHeight setSelectedSegmentIndex:1];
	}
	
	
	[motherHeightBtn setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateMotherHeight"]	forState:UIControlStateNormal];
	if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateMotherHeightUnit"] isEqualToString:@"ft"])
	{
		[segHeight_2 setSelectedSegmentIndex:0];
	}
	else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowEstimateMotherHeightUnit"] isEqualToString:@"cm"])
	{
		[segHeight_2 setSelectedSegmentIndex:1];
	}
	
}


//배경 클릭 시 키보드 제거 혹은 피커 뷰 제거 기능
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	[self disappearAll];
}

//피커별 열 갯수 설정 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{	
	
	if (pickerView.tag == FATHER_TAG){
		return 4;
	}
	if (pickerView.tag == MOTHER_TAG){
		return 4;
	}
	//미국단위 추가 (2012.10)	
	if (pickerView.tag == HEIGHT_FT_TAG){
		return 5;
	}	
	if (pickerView.tag == HEIGHT_FT_TAG_2){
		return 5;
	}		
	//미국단위 추가 (2012.10)		
	return 1;
}


//피커내 로우수 결정
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

	if (pickerView.tag == FATHER_TAG){
		switch(component)
		{
			case 0:
				return [fatherHeightValue count];
				break;
			case 1:
				return [fatherHeightValue2 count];
				break;
			case 2:
				return [fatherHeightValue3 count];
				break;
			case 3:
				return [fatherHeightValue4 count];
				break;
		}	
	}
	if (pickerView.tag == MOTHER_TAG){
		switch(component)
		{
			case 0:
				return [motherHeightValue count];
				break;
			case 1:
				return [motherHeightValue2 count];
				break;
			case 2:
				return [motherHeightValue3 count];
				break;
			case 3:
				return [motherHeightValue4 count];
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
	if (pickerView.tag == HEIGHT_FT_TAG_2){
		switch(component)
		{
			case 0:
				return [heightFtValues_2 count];
				break;
			case 1:
				return [heightFtValues2_2 count];
				break;
			case 2:
				return [heightFtValues3_2 count];
				break;
			case 3:
				return [heightFtValues4_2 count];
				break;
			case 4:
				return [heightFtValues5_2 count];
				break;
		}	
	}		
	//미국단위 추가 (2012.10)		
	return 1;
}


//컬럼 별 피커 값 설정
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (pickerView.tag == FATHER_TAG)
	{
		switch(component)
		{
			case 0:
				return [fatherHeightValue objectAtIndex:row];
				break;
			case 1:
				return [fatherHeightValue2 objectAtIndex:row];
				break;
			case 2:
				return [fatherHeightValue3 objectAtIndex:row];
				break;
			case 3:
				return [fatherHeightValue4 objectAtIndex:row];
				break;
		}	
	}
	if (pickerView.tag == MOTHER_TAG)
	{
		switch(component)
		{
			case 0:
				return [motherHeightValue objectAtIndex:row];
				break;
			case 1:
				return [motherHeightValue2 objectAtIndex:row];
				break;
			case 2:
				return [motherHeightValue3 objectAtIndex:row];
				break;
			case 3:
				return [motherHeightValue4 objectAtIndex:row];
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
	if (pickerView.tag == HEIGHT_FT_TAG_2)
	{
		switch(component)
		{
			case 0:
				return [heightFtValues_2 objectAtIndex:row];
				break;
			case 1:
				return [heightFtValues2_2 objectAtIndex:row];
				break;
			case 2:
				return [heightFtValues3_2 objectAtIndex:row];
				break;
			case 3:
				return [heightFtValues4_2 objectAtIndex:row];
				break;
			case 4:
				return [heightFtValues5_2 objectAtIndex:row];
				break;
		}	
	}		
	//미국단위 추가 (2012.10)	
}


//버튼에 피커 Value 셋 하는 부분
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

	if (pickerView.tag == FATHER_TAG)
	{
		NSString *Value1  = [fatherHeightValue objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [fatherHeightValue2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [fatherHeightValue3 objectAtIndex:[pickerView selectedRowInComponent:2]];
		
		NSString *heightValueTemp=[Value1 stringByAppendingString:Value2];
		heightValueTemp=[heightValueTemp stringByAppendingString:Value3];
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[fatherHeightBtn setTitle:heightValueTemp forState:UIControlStateNormal];		
		NSLog(@" %@ ",heightValueTemp);
		
	}	
	if (pickerView.tag == MOTHER_TAG)
	{
		NSString *Value1  = [motherHeightValue objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [motherHeightValue2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [motherHeightValue3 objectAtIndex:[pickerView selectedRowInComponent:2]];
		
		NSString *heightValueTemp=[Value1 stringByAppendingString:Value2];
		heightValueTemp=[heightValueTemp stringByAppendingString:Value3];
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[motherHeightBtn setTitle:heightValueTemp forState:UIControlStateNormal];		
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
		[fatherHeightBtn setTitle:heightFtValueTemp forState:UIControlStateNormal];		
		NSLog(@" %@ ",heightFtValueTemp);
	}	
	if (pickerView.tag == HEIGHT_FT_TAG_2)
	{
		NSString *Value1  = [heightFtValues_2 objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [heightFtValues2_2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [heightFtValues3_2 objectAtIndex:[pickerView selectedRowInComponent:2]];
		NSString *Value4  = [heightFtValues4_2 objectAtIndex:[pickerView selectedRowInComponent:3]];
		NSString *Value5  = [heightFtValues5_2 objectAtIndex:[pickerView selectedRowInComponent:4]];
		
		NSString *heightFtValueTemp=[Value1 stringByAppendingString:Value2];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value3];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value4];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value5];		
		
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[motherHeightBtn setTitle:heightFtValueTemp forState:UIControlStateNormal];		
		NSLog(@" %@ ",heightFtValueTemp);
	}		
	//미국단위 추가 (2012.10)	
}


//각 분리된 항목별 디스플레이면적
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 100.0;

	if (pickerView.tag == FATHER_TAG) {
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
	if (pickerView.tag == MOTHER_TAG) {
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
	if (pickerView.tag == HEIGHT_FT_TAG_2) {
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

//버튼 클릭 시 해당 피커 호출 
-(IBAction) showFatherHeightPicker{	
	//미국단위 추가 (2012.10)	
	if ([segHeightValue isEqualToString:@"cm"]) {	
		//미국단위 추가 (2012.10)	
		
	if ( fatherHeightValuePicker.hidden) {
		fatherHeightValuePicker.hidden = NO;
		[self.view addSubview:fatherHeightValuePicker];	
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
	//	[fatherHeightValuePicker selectRow:7 inComponent:1 animated:NO];

	}
	else {
		fatherHeightValuePicker.hidden = YES;
		[fatherHeightValuePicker removeFromSuperview];
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
-(IBAction) showMotherHeightPicker{	
	//미국단위 추가 (2012.10)	
	if ([segHeightValue_2 isEqualToString:@"cm"]) {	
		//미국단위 추가 (2012.10)		
	if ( motherHeightValuePicker.hidden) {
		motherHeightValuePicker.hidden = NO;
		[self.view addSubview:motherHeightValuePicker];	
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
	//	[motherHeightValuePicker selectRow:6 inComponent:1 animated:NO];
	}
	else {
		motherHeightValuePicker.hidden = YES;
		[motherHeightValuePicker removeFromSuperview];
	}
	//미국단위 추가 (2012.10)
}else if ([segHeightValue_2 isEqualToString:@"ft"]) {
	if ( heightFtValuePicker_2.hidden) {
		heightFtValuePicker_2.hidden = NO;
		[self.view addSubview:heightFtValuePicker_2];
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
		//[heightValuePicker selectRow:5 inComponent:1 animated:NO];
	}
	else {
		heightFtValuePicker_2.hidden = YES;
		toolbar.hidden = YES;
		[heightFtValuePicker_2 removeFromSuperview];
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
- (void) doneButtonPressed:(id)sender
{
	[self disappearAll];
}
//뷰제거
- (void)disappearAll{
	
	if ( !fatherHeightValuePicker.hidden) {
		fatherHeightValuePicker.hidden = YES;
		NSString *Value1  = [fatherHeightValue objectAtIndex:[fatherHeightValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [fatherHeightValue2 objectAtIndex:[fatherHeightValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [fatherHeightValue3 objectAtIndex:[fatherHeightValuePicker selectedRowInComponent:2]];
		//미국단위 추가 (2012.10)
		NSString *Value4  = [fatherHeightValue4 objectAtIndex:[fatherHeightValuePicker selectedRowInComponent:3]];
		//미국단위 추가 (2012.10)
		NSString *heightValueTemp=[Value1 stringByAppendingString:Value2];
		heightValueTemp=[heightValueTemp stringByAppendingString:Value3];
		//미국단위 추가 (2012.10)
		heightValueTemp=[heightValueTemp stringByAppendingString:Value4];
		//미국단위 추가 (2012.10)		
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[fatherHeightBtn setTitle:heightValueTemp forState:UIControlStateNormal];
		[[NSUserDefaults standardUserDefaults] setObject:heightValueTemp forKey:@"keyGrowEstimateFatherHeight"]; //저장값기억(2012.03.04 by 서정범
		NSLog(@" %@ ",heightValueTemp);
	}
	if ( !motherHeightValuePicker.hidden) {
		motherHeightValuePicker.hidden = YES;
		NSString *Value1  = [motherHeightValue objectAtIndex:[motherHeightValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [motherHeightValue2 objectAtIndex:[motherHeightValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [motherHeightValue3 objectAtIndex:[motherHeightValuePicker selectedRowInComponent:2]];
		//미국단위 추가 (2012.10)
		NSString *Value4  = [motherHeightValue4 objectAtIndex:[motherHeightValuePicker selectedRowInComponent:3]];
		//미국단위 추가 (2012.10)
		NSString *heightValueTemp=[Value1 stringByAppendingString:Value2];
		heightValueTemp=[heightValueTemp stringByAppendingString:Value3];
		//미국단위 추가 (2012.10)
		heightValueTemp=[heightValueTemp stringByAppendingString:Value4];
		//미국단위 추가 (2012.10)		
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[motherHeightBtn setTitle:heightValueTemp forState:UIControlStateNormal];	
				[[NSUserDefaults standardUserDefaults] setObject:heightValueTemp forKey:@"keyGrowEstimateMotherHeight"]; //저장값기억(2012.03.04 by 서정범
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
		
		[fatherHeightBtn setTitle:heightFtValueTemp forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:heightFtValueTemp forKey:@"keyGrowEstimateFatherHeight"]; //저장값기억(2012.03.04 by 서정범
		//NSLog(@" %@ ",heightFtValueTemp);
	}	
	if ( !heightFtValuePicker_2.hidden) 
	{
		heightFtValuePicker_2.hidden = YES;
		NSString *Value1  = [heightFtValues_2 objectAtIndex:[heightFtValuePicker_2 selectedRowInComponent:0]];
		NSString *Value2  = [heightFtValues2_2 objectAtIndex:[heightFtValuePicker_2 selectedRowInComponent:1]];
		NSString *Value3  = [heightFtValues3_2 objectAtIndex:[heightFtValuePicker_2 selectedRowInComponent:2]];
		NSString *Value4  = [heightFtValues4_2 objectAtIndex:[heightFtValuePicker_2 selectedRowInComponent:3]];
		NSString *Value5  = [heightFtValues5_2 objectAtIndex:[heightFtValuePicker_2 selectedRowInComponent:4]];
		
		NSString *heightFtValueTemp=[Value1 stringByAppendingString:Value2];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value3];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value4];
		heightFtValueTemp=[heightFtValueTemp stringByAppendingString:Value5];		
		
		[motherHeightBtn setTitle:heightFtValueTemp forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:heightFtValueTemp forKey:@"keyGrowEstimateMotherHeight"]; //저장값기억(2012.03.04 by 서정범
		//NSLog(@" %@ ",heightFtValueTemp);
	}		
	//미국단위 추가 (2012.10)
	if ( !toolbar.hidden) {
		toolbar.hidden = YES;
	}	 
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
-(void)calcualteBabyHeightPercent:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight
{	
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
	
	int liveYear=currentYear-birthYear;
	int liveMonth=12;
	if (liveYear>0 && birthMonth==currentMonth) {
		liveMonth=12;
		liveYear--;
	}
	else if(birthMonth>currentMonth){
		liveMonth=currentMonth+12-birthMonth;
		liveYear--;
	}else {
		liveMonth=currentMonth-birthMonth;
	}
	//미국단위 추가 (2012.10)
	//문자열 포함 검색을 통한 ft및 cm체크
	NSString *heightResult;
	if ([pHeight rangeOfString:@"ft"].location != NSNotFound) {
		NSString *height1 =[pHeight substringToIndex:1];//ft가져오기
		NSString *height2 =[pHeight substringFromIndex:4];//in가져오기
		height2 = [height2 stringByReplacingOccurrencesOfString:@"in" withString:@""];//계산을 위한 in값 잘라내기 
		//위 방식도 가능 --> urlString = [urlString substringFromIndex:[urlString length]-1];
		float height3=[height1 floatValue];
		float height4=[height2 floatValue];
		height3=height3*30.48f;
		height4=height4*2.54f;
		height3=height3+height4;
		height3=(int)((height3+0.05f)*10)/10.0f;
		heightResult=[[NSString alloc] initWithFormat:@"%.1f", height3];//반올림하여 소수점 한자리만 출력
		NSLog(@"단위 변환 결과 (키) : %@ ",heightResult);
	}
	//cm인경우
	else {
		//NSLog(@"단위 변환 결과 (키:cm) : %@ ",inputHeight);
		//heightResult=inputHeight;
		heightResult = [pHeight stringByReplacingOccurrencesOfString:@"cm" withString:@""];//계산을 위한 in값 잘라내기 
		//NSLog(@"단위 변환 결과 (키:cm) : %@ ",inputHeight);
	}
	//미국단위 추가 (2012.10)
	

	
	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate calculateHeightFromDatabase:pGender Year:[[NSString alloc] initWithFormat:@"%i", liveYear] Month:[[NSString alloc] initWithFormat:@"%i", liveMonth] Height:heightResult];

	InfantData *mData = [[appDelegate DBData] objectAtIndex:0];
	/*InfantData *mData2 = [[appDelegate DBData] objectAtIndex:1];
	InfantData *mData3 = [[appDelegate DBData] objectAtIndex:2];*/

	self.heightPercentValue.text=mData.mPercent;
	//화면내 단순 값 셋팅
	self.heightValue.text=pHeight;
	self.yearValue.text=pYear;
	self.monthValue.text=pMonth;
	self.genderValue.text=pGender;

	
	/*self.result_Weight.text=mData2.mPercent;
	self.result_Length.text=mData3.mPercent;*/
}

- (void)dealloc 
{
	[fatherHeightValue release];
	[fatherHeightValue2 release];
	[fatherHeightValue3 release];
	[fatherHeightValue4 release];
	[motherHeightValue release];
	[motherHeightValue2 release];
	[motherHeightValue3 release];
	[motherHeightValue4 release];
	[motherHeightValuePicker release];
	[fatherHeightValuePicker release];	
	//미국단위 추가 (2012.10)
	[heightFtValuePicker release];
	[heightFtValues release];
	[heightFtValues2 release];
	[heightFtValues3 release];
	[heightFtValues4 release];
	[heightFtValues5 release];
	[segHeightValue release];
	[segHeight release];

	[heightFtValuePicker_2 release];
	[heightFtValues_2 release];
	[heightFtValues2_2 release];
	[heightFtValues3_2 release];
	[heightFtValues4_2 release];
	[heightFtValues5_2 release];
	[segHeightValue_2 release];
	[segHeight_2 release];	
	//미국단위 추가 (2012.10)	
    [super dealloc];
}


@end
