//
//  GrowthAnalizeViewController.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "GrowthAnalizeViewController.h"
#import "BABYGROWTHAppDelegate.h"
#import "InfantData.h"
#import "GrowthAnalizeResultViewController.h"

//해당 피커별 태그를 두어 필요한 피커 호출
#define GENDER_TAG 1
#define YEAR_TAG 2
#define MONTH_TAG 3
#define HEIGHT_TAG 4
#define WEIGHT_TAG 5
#define LENGTH_TAG 6
//미국단위 추가 (2012.10)
#define HEIGHT_FT_TAG 7
#define WEIGHT_LB_TAG 8
#define LENGTH_IN_TAG 9
//미국단위 추가 (2012.10)

@implementation GrowthAnalizeViewController
@synthesize btnGoToGrowthAnalizeResult;
@synthesize btnCancel;
//미국단위 추가 (2012.10)
@synthesize segGender,segHeight,segWeight,segLength;
//미국단위 추가 (2012.10)
//property로 지정한 delegate를 다른 오브젝트에서 써줘야 하니 @synthesize로 접근가능하게 하는걸 잊지 맙시다.
@synthesize delegate; 
@synthesize toolbar;

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
		[[NSUserDefaults standardUserDefaults] setObject:@"B" forKey:@"keyGrowAnalizeGender"]; //저장값기억(2012.03.04) by 서정범
	}
	else if([segGender selectedSegmentIndex]==1)
	{
		[self.segGender setImage:[UIImage imageNamed:@"man_off.png"] forSegmentAtIndex:0];
		[self.segGender setImage:[UIImage imageNamed:@"woman_on.png"] forSegmentAtIndex:1];
		[genderTypeBtn setTitle:@"G" forState:UIControlStateNormal];
		[[NSUserDefaults standardUserDefaults] setObject:@"G" forKey:@"keyGrowAnalizeGender"]; //저장값기억(2012.03.04) by 서정범
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
		[[NSUserDefaults standardUserDefaults] setObject:@"ft" forKey:@"keyGrowAnalizeHeightUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	else if([segHeight selectedSegmentIndex]==1)
	{
		[self.segHeight setImage:[UIImage imageNamed:@"btn_ftin01.png"] forSegmentAtIndex:0];
		[self.segHeight setImage:[UIImage imageNamed:@"btn_cm02.png"] forSegmentAtIndex:1];
		segHeightValue=@"cm";
		[[NSUserDefaults standardUserDefaults] setObject:@"cm" forKey:@"keyGrowAnalizeHeightUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	//NSLog(segHeightValue); 
}

-(IBAction) segWeightSelected
{
	if([segWeight selectedSegmentIndex]==0)
	{		
			[self.segWeight setImage:[UIImage imageNamed:@"btn_lbs02.png"] forSegmentAtIndex:0];
			[self.segWeight setImage:[UIImage imageNamed:@"btn_kg01.png"] forSegmentAtIndex:1];
			segWeightValue=@"lb";
			[[NSUserDefaults standardUserDefaults] setObject:@"lb" forKey:@"keyGrowAnalizeWegihtUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	else if([segWeight selectedSegmentIndex]==1)
	{
			[self.segWeight setImage:[UIImage imageNamed:@"btn_lbs01.png"] forSegmentAtIndex:0];
			[self.segWeight setImage:[UIImage imageNamed:@"btn_kg02.png"] forSegmentAtIndex:1];
			segWeightValue=@"kg";
			[[NSUserDefaults standardUserDefaults] setObject:@"kg" forKey:@"keyGrowAnalizeWegihtUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	//NSLog(segHeightValue); 
}

-(IBAction) segLengthSelected
{
	if([segLength selectedSegmentIndex]==0)
	{		
			[self.segLength setImage:[UIImage imageNamed:@"btn_inch02.png"] forSegmentAtIndex:0];
			[self.segLength setImage:[UIImage imageNamed:@"btn_cm01.png"] forSegmentAtIndex:1];
			segLengthValue=@"in";
			[[NSUserDefaults standardUserDefaults] setObject:@"in" forKey:@"keyGrowAnalizeLengthUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	else if([segLength selectedSegmentIndex]==1)
	{
			[self.segLength setImage:[UIImage imageNamed:@"btn_inch01.png"] forSegmentAtIndex:0];
			[self.segLength setImage:[UIImage imageNamed:@"btn_cm02.png"] forSegmentAtIndex:1];
			segLengthValue=@"cm";
			[[NSUserDefaults standardUserDefaults] setObject:@"cm" forKey:@"keyGrowAnalizeLengthUnit"]; //저장값기억(2012.10.14) by 서정범
	}
	//NSLog(segHeightValue); 
}
//미국단위 추가 (2012.10)

-(IBAction)btnGoToGrowthAnalizeResultTouched
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
	if(lengthBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Input head circumference."];
		return;
	}
	if([lengthBtn.titleLabel.text intValue]==0)
	{
		[self ShowMessageBox:@"Please input Head Circumference over 0 in or 0 cm."];//머리둘레는 0 cm 가 될 수 없습니다.\n 다시 입력해 주세요
		return;
	}
	if(heightBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Input height."];
		return;
	}
	if([heightBtn.titleLabel.text intValue]==0)
	{
		[self ShowMessageBox:@"Please input Height over 0 in or 0 cm."];//키는 0 cm 가 될 수 없습니다.\n 다시 입력해 주세요
		return;
	}
	if(weightBtn.titleLabel.text==nil)
	{
		[self ShowMessageBox:@"Input weight."];
		return;
	}
	if([weightBtn.titleLabel.text intValue]==0)
	{
		[self ShowMessageBox:@"Please input Weight over 0 in or 0 lb."];//몸무게는 0 kg 이 될 수 없습니다.\n 다시 입력해 주세요
		return;
	}
	
	//입력값에 대한 Validation 체크를 한다.
	if([self checkInputValueValid:genderTypeBtn.titleLabel.text Year:yearBtn.titleLabel.text Month:monthBtn.titleLabel.text Height:heightBtn.titleLabel.text Weight:weightBtn.titleLabel.text Length:lengthBtn.titleLabel.text])
	{
	
		GrowthAnalizeResultViewController *growthAnalizeResultViewController=
		[[GrowthAnalizeResultViewController alloc] initWithNibName:@"GrowthAnalizeResultViewController" bundle:nil];
	
		//growthAnalizeViewController.currentMenu=1;
		[self.navigationController pushViewController:growthAnalizeResultViewController animated:YES];
		[growthAnalizeResultViewController rootViewControllerDidEnd:genderTypeBtn.titleLabel.text Year:yearBtn.titleLabel.text Month:monthBtn.titleLabel.text Height:heightBtn.titleLabel.text Weight:weightBtn.titleLabel.text Length:lengthBtn.titleLabel.text];
		[growthAnalizeResultViewController release];
	}
	
}


//============================================================================================================
// 입력값에 대한 Validation 체크를 한다.
//============================================================================================================
-(BOOL)checkInputValueValid:(NSString *)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)inputHeight Weight:(NSString*)inputWeight Length:(NSString*)inputLength
{
	/*
	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate readDataFromDatabase:inputGender Year:inputYear Month:inputMonth Height:inputHeight Weight:inputWeight Length:inputLength];
	InfantData *mData = [[appDelegate DBData] objectAtIndex:0];
	InfantData *mData2 = [[appDelegate DBData] objectAtIndex:1];
	InfantData *mData3 = [[appDelegate DBData] objectAtIndex:2];
	
	
	if([mData.mPercent isEqualToString:@"값이상"])
	{
		[self ShowMessageBox:@"입력한 값은 측정할 수 없는 범위내에 있습니다.\n 확인후 다시 입력해 주세요"];
		return FALSE;
	}
	if([mData2.mPercent isEqualToString:@"값이상"])
	{
		[self ShowMessageBox:@"입력한 값은 측정할 수 없는 범위내에 있습니다.\n 확인후 다시 입력해 주세요"];
		return FALSE;
	}
	if([mData3.mPercent isEqualToString:@"값이상"])
	{
		[self ShowMessageBox:@"입력한 값은 측정할 수 없는 범위내에 있습니다.\n 확인후 다시 입력해 주세요"];
		return FALSE;
	}
	return TRUE;
	 */

	NSDate* today = [NSDate date];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"yyyy-MM"];
	NSString *str1 =[dateFormatter stringFromDate:today];	
	NSString *str2 =[dateFormatter stringFromDate:today];	
	
	str1=[str1 substringToIndex:4];//년구하기
	str2=[str2 substringFromIndex:5];//월구하기
	int currentYear=[str1 intValue];
	int currentMonth=[str2 intValue];
	
	int birthYear=[inputYear intValue];
	int birthMonth=[inputMonth intValue];
	
	if(currentYear==birthYear && birthMonth>currentMonth)
	{
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

  //  [super touchesBegan:touches withEvent:event];
	[self disappearAll];

}


- (void)viewDidLoad 
{
    [super viewDidLoad];
	//미국단위 추가 (2012.10)
	segHeightValue=@"ft"; //최초로딩시 디폴트값 설정 필요
	segWeightValue=@"lb"; //최초로딩시 디폴트값 설정 필요
	segLengthValue=@"in"; //최초로딩시 디폴트값 설정 필요	
	//미국단위 추가 (2012.10)
	
	NSDate* today = [NSDate date];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"yyyy-MM"];
	NSString *str1 =[dateFormatter stringFromDate:today];	
	str1=[str1 substringToIndex:4];//년구하기
	int year=[str1 intValue];

	//genderValues = [[NSArray alloc] initWithObjects:@"B",@"G",nil];  //피커뷰 값 Set

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
	monthValues = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",
				   nil];  //월
	heightValues = [[NSArray alloc] initWithObjects:@"",@"1",nil]; //키 
	heightValues2 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키 
	heightValues3 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키 
	heightValues4 = [[NSArray alloc] initWithObjects:@"cm",nil]; //키
	
	
	weightValues = [[NSArray alloc] initWithObjects:@"",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //몸무게
	weightValues2 = [[NSArray alloc] initWithObjects:@"0.",@"1.",@"2.",@"3.",@"4.",@"5.",@"6.",@"7.",@"8.",@"9.",nil]; //몸무게
	weightValues3 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //몸무게
	weightValues4 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //몸무게
	weightValues5 = [[NSArray alloc] initWithObjects:@"kg",nil]; //몸무게
	
	lengthValues = [[NSArray alloc] initWithObjects:@"3",@"4",@"5",nil];	 //머리둘레
	lengthValues2 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];	 //머리둘레
	lengthValues3 = [[NSArray alloc] initWithObjects:@"cm",nil];	 //머리둘레
	//미국단위 추가 (2012.10)
	heightFtValues = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키(ft)
	heightFtValues2 = [[NSArray alloc] initWithObjects:@"ft ",nil]; //키(ft)
	heightFtValues3 = [[NSArray alloc] initWithObjects:@"0.",@"1.",@"2.",@"3.",@"4.",@"5.",@"6.",@"7.",@"8.",@"9.",@"10.",@"11.",nil]; //키(in)
	heightFtValues4 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //키(in)
	heightFtValues5 = [[NSArray alloc] initWithObjects:@"in",nil]; //키(ft)	
	
	weightLbValues = [[NSArray alloc] initWithObjects:@"",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //몸무게(lb)
	weightLbValues2 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //몸무게(lb)
	weightLbValues3 = [[NSArray alloc] initWithObjects:@"0.",@"1.",@"2.",@"3.",@"4.",@"5.",@"6.",@"7.",@"8.",@"9.",nil]; //몸무게(lb)
	weightLbValues4 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //몸무게(lb)
	weightLbValues5 = [[NSArray alloc] initWithObjects:@"lbs",nil]; //몸무게(lb)

	lengthInValues = [[NSArray alloc] initWithObjects:@"",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //머리둘레(In)
	lengthInValues2 = [[NSArray alloc] initWithObjects:@"0.",@"1.",@"2.",@"3.",@"4.",@"5.",@"6.",@"7.",@"8.",@"9.",nil]; //머리둘레(In)
	lengthInValues3 = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil]; //머리둘레(In)
	lengthInValues4 = [[NSArray alloc] initWithObjects:@"in",nil]; //키(ft)		
	//미국단위 추가 (2012.10)

	//해당 피커별 위치 설정 및 속성(태그등) 설정
	genderValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	genderValuePicker.tag = GENDER_TAG;
	genderValuePicker.showsSelectionIndicator = TRUE;
	genderValuePicker.dataSource = self;
	genderValuePicker.delegate = self;
	genderValuePicker.hidden = YES;
	
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
	
	weightValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	weightValuePicker.tag = WEIGHT_TAG;
	weightValuePicker.showsSelectionIndicator = TRUE;
	weightValuePicker.dataSource = self;
	weightValuePicker.delegate = self;
	weightValuePicker.hidden = YES;
	
	lengthValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	lengthValuePicker.tag = LENGTH_TAG;
	lengthValuePicker.showsSelectionIndicator = TRUE;
	lengthValuePicker.dataSource = self;
	lengthValuePicker.delegate = self;
	lengthValuePicker.hidden = YES;
	
	//미국단위 추가 (2012.10)
	heightFtValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	heightFtValuePicker.tag = HEIGHT_FT_TAG;
	heightFtValuePicker.showsSelectionIndicator = TRUE;
	heightFtValuePicker.dataSource = self;
	heightFtValuePicker.delegate = self;
	heightFtValuePicker.hidden = YES;	
	
	weightLbValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	weightLbValuePicker.tag = WEIGHT_LB_TAG;
	weightLbValuePicker.showsSelectionIndicator = TRUE;
	weightLbValuePicker.dataSource = self;
	weightLbValuePicker.delegate = self;
	weightLbValuePicker.hidden = YES;	
	
	lengthInValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	lengthInValuePicker.tag = LENGTH_IN_TAG;
	lengthInValuePicker.showsSelectionIndicator = TRUE;
	lengthInValuePicker.dataSource = self;
	lengthInValuePicker.delegate = self;
	lengthInValuePicker.hidden = YES;	
	//미국단위 추가 (2012.10)
	
	
	//기억값표시 2012.3.4 by 서정범
	[genderTypeBtn	setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeGender"]		forState:UIControlStateNormal];
	if([genderTypeBtn.titleLabel.text isEqualToString:@"B"])
	{
		[segGender setSelectedSegmentIndex:0];
	}
	else if([genderTypeBtn.titleLabel.text isEqualToString:@"G"])
	{
		[segGender setSelectedSegmentIndex:1];
	}
	[yearBtn		setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeBirthYear"]	forState:UIControlStateNormal];
	[monthBtn		setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeBirthMonth"]	forState:UIControlStateNormal];
	
	//키
    [heightBtn	setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeHeight"]		forState:UIControlStateNormal];
	if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeHeightUnit"] isEqualToString:@"ft"])
	{
		[segHeight setSelectedSegmentIndex:0];
	}
	else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeHeightUnit"] isEqualToString:@"cm"])
	{
		[segHeight setSelectedSegmentIndex:1];
	}
	
	//몸무게
	[weightBtn	setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeWegiht"]		forState:UIControlStateNormal];
	if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeWegihtUnit"] isEqualToString:@"lb"])
	{
		[segWeight setSelectedSegmentIndex:0];
	}
	else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeWegihtUnit"] isEqualToString:@"kg"])
	{
		[segWeight setSelectedSegmentIndex:1];
	}
	
	//머리둘레
	[lengthBtn	setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeLength"]		forState:UIControlStateNormal];
	if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeLengthUnit"] isEqualToString:@"in"])
	{
		[segLength setSelectedSegmentIndex:0];
	}
	else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"keyGrowAnalizeLengthUnit"] isEqualToString:@"cm"])
	{
		[segLength setSelectedSegmentIndex:1];
	}
	
	
}

//피커별 열 갯수 설정 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{	
	
	if (pickerView.tag == GENDER_TAG){
		pickerView.transform = CGAffineTransformMakeScale(0.50, 1);
		return 1;
	}
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
	if (pickerView.tag == WEIGHT_LB_TAG){
		return 5;
	}	
	if (pickerView.tag == LENGTH_IN_TAG){
		return 4;
	}	
	//미국단위 추가 (2012.10)	
	if (pickerView.tag == WEIGHT_TAG){
		return 5;
	}	
	if (pickerView.tag == LENGTH_TAG){
		return 3;
	}	
	return 1;
}

//피커내 로우수 결정
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (pickerView.tag == GENDER_TAG){
		//	if( component == 0 ){
		return [genderValues count];
		/*	}
		 if( component == 1 ){
		 return [genderValues count];
		 }*/
	}
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
	if (pickerView.tag == WEIGHT_LB_TAG){
		switch(component)
		{
			case 0:
				return [weightLbValues count];
				break;
			case 1:
				return [weightLbValues2 count];
				break;
			case 2:
				return [weightLbValues3 count];
				break;
			case 3:
				return [weightLbValues4 count];
				break;
			case 4:
				return [weightLbValues5 count];
				break;
		}	
	}	
	if (pickerView.tag == LENGTH_IN_TAG){
		switch(component)
		{
			case 0:
				return [lengthInValues count];
				break;
			case 1:
				return [lengthInValues2 count];
				break;
			case 2:
				return [lengthInValues3 count];
				break;
			case 3:
				return [lengthInValues4 count];
				break;
		}	
	}	
	//미국단위 추가 (2012.10)
	if (pickerView.tag == WEIGHT_TAG){
		switch(component)
		{
			case 0:
				return [weightValues count];
				break;
			case 1:
				return [weightValues2 count];
				break;
			case 2:
				return [weightValues3 count];
				break;
			case 3:
				return [weightValues4 count];
				break;
			case 4:
				return [weightValues5 count];
				break;
		}		
	}	
	if (pickerView.tag == LENGTH_TAG){
		switch(component)
		{
			case 0:
				return [lengthValues count];
				break;
			case 1:
				return [lengthValues2 count];
				break;
			case 2:
				return [lengthValues3 count];
				break;
		}	
	}	
	return 1;
}

//컬럼 별 피커 값 설정
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (pickerView.tag == GENDER_TAG){	
		/*if( component == 0 ){
		 return [genderValues objectAtIndex:row];
		 }*/
		//	if( component == 1 ){
		return [genderValues objectAtIndex:row];
		//	}
	}
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
	if (pickerView.tag == WEIGHT_LB_TAG)
	{
		switch(component)
		{
			case 0:
				return [weightLbValues objectAtIndex:row];
				break;
			case 1:
				return [weightLbValues2 objectAtIndex:row];
				break;
			case 2:
				return [weightLbValues3 objectAtIndex:row];
				break;
			case 3:
				return [weightLbValues4 objectAtIndex:row];
				break;
			case 4:
				return [weightLbValues5 objectAtIndex:row];
				break;
		}	
	}	
	if (pickerView.tag == LENGTH_IN_TAG)
	{
		switch(component)
		{
			case 0:
				return [lengthInValues objectAtIndex:row];
				break;
			case 1:
				return [lengthInValues2 objectAtIndex:row];
				break;
			case 2:
				return [lengthInValues3 objectAtIndex:row];
				break;
			case 3:
				return [lengthInValues4 objectAtIndex:row];
				break;
		}	
	}		
	//미국단위 추가 (2012.10)

	if (pickerView.tag == WEIGHT_TAG)
	{
		switch(component)
		{
			case 0:
				return [weightValues objectAtIndex:row];
				break;
			case 1:
				return [weightValues2 objectAtIndex:row];
				break;
			case 2:
				return [weightValues3 objectAtIndex:row];
				break;
			case 3:
				return [weightValues4 objectAtIndex:row];
				break;
			case 4:
				return [weightValues5 objectAtIndex:row];
				break;
		}				
	}
	if (pickerView.tag == LENGTH_TAG)
	{
		switch(component)
		{
			case 0:
				return [lengthValues objectAtIndex:row];
				break;
			case 1:
				return [lengthValues2 objectAtIndex:row];
				break;
			case 2:
				return [lengthValues3 objectAtIndex:row];
				break;
		}	
	}
	return [genderValues objectAtIndex:row];
}

//버튼에 피커 Value 셋 하는 부분
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (pickerView.tag == GENDER_TAG) {
		//	NSLog(@"categoryTypeBtn.titleLabel);
		//	NSLog(@" %@ ",genderTypeBtn.titleLabel.text);
		
		NSString *genderValue  = [genderValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[genderTypeBtn setTitle:genderValue forState:UIControlStateNormal];					
	}
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
		//NSLog(@" %@ ",heightValueTemp);
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
	if (pickerView.tag == WEIGHT_LB_TAG)
	{
		NSString *Value1  = [weightLbValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [weightLbValues2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [weightLbValues3 objectAtIndex:[pickerView selectedRowInComponent:2]];
		NSString *Value4  = [weightLbValues4 objectAtIndex:[pickerView selectedRowInComponent:3]];
		NSString *Value5  = [weightLbValues5 objectAtIndex:[pickerView selectedRowInComponent:4]];
		
		NSString *weightLbValueTemp=[Value1 stringByAppendingString:Value2];
		weightLbValueTemp=[weightLbValueTemp stringByAppendingString:Value3];
		weightLbValueTemp=[weightLbValueTemp stringByAppendingString:Value4];
		weightLbValueTemp=[weightLbValueTemp stringByAppendingString:Value5];		
		
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[weightBtn setTitle:weightLbValueTemp forState:UIControlStateNormal];		
		NSLog(@" %@ ",weightLbValueTemp);
	}	
	if (pickerView.tag == LENGTH_IN_TAG)
	{
		NSString *Value1  = [lengthInValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [lengthInValues2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [lengthInValues3 objectAtIndex:[pickerView selectedRowInComponent:2]];
		NSString *Value4  = [lengthInValues4 objectAtIndex:[pickerView selectedRowInComponent:3]];
		
		NSString *lengthInValueTemp=[Value1 stringByAppendingString:Value2];
		lengthInValueTemp=[lengthInValueTemp stringByAppendingString:Value3];
		lengthInValueTemp=[lengthInValueTemp stringByAppendingString:Value4];
		
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[lengthBtn setTitle:lengthInValueTemp forState:UIControlStateNormal];		
		//NSLog(@" %@ ",heightFtValueTemp);
	}			
	//미국단위 추가 (2012.10)
	if (pickerView.tag == WEIGHT_TAG)
	{
		
		NSString *Value1  = [weightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [weightValues2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [weightValues3 objectAtIndex:[pickerView selectedRowInComponent:2]];
		NSString *Value4  = [weightValues4 objectAtIndex:[pickerView selectedRowInComponent:3]];
		NSString *Value5  = [weightValues5 objectAtIndex:[pickerView selectedRowInComponent:4]];
		
		//		NSString *Value5  = [weightValues5 objectAtIndex:[pickerView selectedRowInComponent:4]];
		
		/*	NSString *weightValueTemp;
		 if(Value1==nil){
		 weightValueTemp=Value2;
		 }else {*/
		NSString *weightValueTemp=[Value1 stringByAppendingString:Value2];
		
		//}
		
		//	weightValueTemp=[weightValueTemp stringByAppendingString:@"."];
		
		weightValueTemp=[weightValueTemp stringByAppendingString:Value3];
		weightValueTemp=[weightValueTemp stringByAppendingString:Value4];
		weightValueTemp=[weightValueTemp stringByAppendingString:Value5];
		
		[weightBtn setTitle:weightValueTemp forState:UIControlStateNormal];		
		//NSLog(@" %@ ",weightValueTemp);
		
		
	}	
	if (pickerView.tag == LENGTH_TAG)
	{
		NSString *Value1  = [lengthValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		NSString *Value2  = [lengthValues2 objectAtIndex:[pickerView selectedRowInComponent:1]];
		NSString *Value3  = [lengthValues3 objectAtIndex:[pickerView selectedRowInComponent:2]];
		
		NSString *lengthValuesTemp=[Value1 stringByAppendingString:Value2];
		lengthValuesTemp=[lengthValuesTemp stringByAppendingString:Value3];

		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[lengthBtn setTitle:lengthValuesTemp forState:UIControlStateNormal];		
		NSLog(@" %@ ",lengthValuesTemp);		
	}	
	
}

//각 분리된 항목별 디스플레이면적
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 100.0;
	if (pickerView.tag == GENDER_TAG) {
		
		if (component == 0)
			componentWidth = 240.0;// first column size is wider to hold names
		else
			componentWidth = 40.0;// second column is narrower to show numbers
	}
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
	if (pickerView.tag == WEIGHT_LB_TAG) {
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
	if (pickerView.tag == LENGTH_IN_TAG) {
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

		}		
	}		
	//미국단위 추가 (2012.10)
	if (pickerView.tag == WEIGHT_TAG) {
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
				componentWidth = 50.0;// first column size is wider to hold names
				break;
			case 4:
				componentWidth = 40.0;// first column size is wider to hold names
				break;
		}		
	}	
	if (pickerView.tag == LENGTH_TAG) {
		switch(component)
		{
			case 0:
				componentWidth = 80.0;// first column size is wider to hold names
				break;
			case 1:
				componentWidth = 80.0;// first column size is wider to hold names
				break;
			case 2:
				componentWidth = 120.0;// first column size is wider to hold names
				break;
		}		
	}	
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
	if ( !genderValuePicker.hidden) 
	{
		genderValuePicker.hidden = YES;		
	}
	if ( !yearValuePicker.hidden) 
	{
		yearValuePicker.hidden = YES;
		NSString *yearValue  = [yearValues objectAtIndex:[yearValuePicker selectedRowInComponent:0]];
		[yearBtn setTitle:yearValue forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:yearValue forKey:@"keyGrowAnalizeBirthYear"]; //저장값기억(2012.03.04 by 서정범
	}
	if ( !monthValuePicker.hidden) 
	{
		monthValuePicker.hidden = YES;
		NSString *monthValue  = [monthValues objectAtIndex:[monthValuePicker selectedRowInComponent:0]];
		[monthBtn setTitle:monthValue forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:monthValue forKey:@"keyGrowAnalizeBirthMonth"]; //저장값기억(2012.03.04 by 서정범
	}
	if ( !heightValuePicker.hidden) 
	{
		heightValuePicker.hidden = YES;
		NSString *Value1  = [heightValues objectAtIndex:[heightValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [heightValues2 objectAtIndex:[heightValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [heightValues3 objectAtIndex:[heightValuePicker selectedRowInComponent:2]];
		NSString *Value4  = [heightValues4 objectAtIndex:[heightValuePicker selectedRowInComponent:3]];
		
		NSString *heightValueTemp=[Value1 stringByAppendingString:Value2];
		heightValueTemp=[heightValueTemp stringByAppendingString:Value3];
		heightValueTemp=[heightValueTemp stringByAppendingString:Value4];
		
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[heightBtn setTitle:heightValueTemp forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:heightValueTemp forKey:@"keyGrowAnalizeHeight"]; //저장값기억(2012.03.04 by 서정범
		//NSLog(@" %@ ",heightValueTemp);
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
		[[NSUserDefaults standardUserDefaults] setObject:heightFtValueTemp forKey:@"keyGrowAnalizeHeight"]; //저장값기억(2012.03.04 by 서정범
		//NSLog(@" %@ ",heightFtValueTemp);
	}	
	if ( !weightLbValuePicker.hidden) 
	{
		weightLbValuePicker.hidden = YES;
		NSString *Value1  = [weightLbValues objectAtIndex:[weightLbValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [weightLbValues2 objectAtIndex:[weightLbValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [weightLbValues3 objectAtIndex:[weightLbValuePicker selectedRowInComponent:2]];
		NSString *Value4  = [weightLbValues4 objectAtIndex:[weightLbValuePicker selectedRowInComponent:3]];
		NSString *Value5  = [weightLbValues5 objectAtIndex:[weightLbValuePicker selectedRowInComponent:4]];
		
		NSString *weightLbValueTemp=[Value1 stringByAppendingString:Value2];
		weightLbValueTemp=[weightLbValueTemp stringByAppendingString:Value3];
		weightLbValueTemp=[weightLbValueTemp stringByAppendingString:Value4];
		weightLbValueTemp=[weightLbValueTemp stringByAppendingString:Value5];		
		
		[weightBtn setTitle:weightLbValueTemp forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:weightLbValueTemp forKey:@"keyGrowAnalizeWegiht"]; //저장값기억(2012.03.04 by 서정범
		//NSLog(@" %@ ",heightFtValueTemp);
	}	
	if ( !lengthInValuePicker.hidden) 
	{
		lengthInValuePicker.hidden = YES;
		NSString *Value1  = [lengthInValues objectAtIndex:[lengthInValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [lengthInValues2 objectAtIndex:[lengthInValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [lengthInValues3 objectAtIndex:[lengthInValuePicker selectedRowInComponent:2]];
		NSString *Value4  = [lengthInValues4 objectAtIndex:[lengthInValuePicker selectedRowInComponent:3]];
		
		NSString *lengthInValueTemp=[Value1 stringByAppendingString:Value2];
		lengthInValueTemp=[lengthInValueTemp stringByAppendingString:Value3];
		lengthInValueTemp=[lengthInValueTemp stringByAppendingString:Value4];
		
		[lengthBtn setTitle:lengthInValueTemp forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:lengthInValueTemp forKey:@"keyGrowAnalizeLength"]; //저장값기억(2012.03.04 by 서정범
		//NSLog(@" %@ ",heightFtValueTemp);
	}		
	//미국단위 추가 (2012.10)
	if ( !weightValuePicker.hidden) 
	{
		weightValuePicker.hidden = YES;
		NSString *Value1  = [weightValues objectAtIndex:[weightValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [weightValues2 objectAtIndex:[weightValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [weightValues3 objectAtIndex:[weightValuePicker selectedRowInComponent:2]];
		NSString *Value4  = [weightValues4 objectAtIndex:[weightValuePicker selectedRowInComponent:3]];
		NSString *Value5  = [weightValues5 objectAtIndex:[weightValuePicker selectedRowInComponent:4]];
		
		//		NSString *Value5  = [weightValues5 objectAtIndex:[pickerView selectedRowInComponent:4]];
		
		/*	NSString *weightValueTemp;
		 if(Value1==nil){
		 weightValueTemp=Value2;
		 }else {*/
		NSString *weightValueTemp=[Value1 stringByAppendingString:Value2];
		
		//}
		
		//	weightValueTemp=[weightValueTemp stringByAppendingString:@"."];
		
		weightValueTemp=[weightValueTemp stringByAppendingString:Value3];
		weightValueTemp=[weightValueTemp stringByAppendingString:Value4];
		weightValueTemp=[weightValueTemp stringByAppendingString:Value5];
		
		[weightBtn setTitle:weightValueTemp forState:UIControlStateNormal];		
		[[NSUserDefaults standardUserDefaults] setObject:weightValueTemp forKey:@"keyGrowAnalizeWegiht"]; //저장값기억(2012.03.04 by 서정범
	//	NSLog(@" %@ ",weightValueTemp);
	}
	if ( !lengthValuePicker.hidden) 
	{
		lengthValuePicker.hidden = YES;
		NSString *Value1  = [lengthValues objectAtIndex:[lengthValuePicker selectedRowInComponent:0]];
		NSString *Value2  = [lengthValues2 objectAtIndex:[lengthValuePicker selectedRowInComponent:1]];
		NSString *Value3  = [lengthValues3 objectAtIndex:[lengthValuePicker selectedRowInComponent:2]];
		NSString *lengthValuesTemp=[Value1 stringByAppendingString:Value2];
		lengthValuesTemp=[lengthValuesTemp stringByAppendingString:Value3];
		//		NSString *heightValue  = [heightValues objectAtIndex:[pickerView selectedRowInComponent:0]];
		[lengthBtn setTitle:lengthValuesTemp forState:UIControlStateNormal];	
		[[NSUserDefaults standardUserDefaults] setObject:lengthValuesTemp forKey:@"keyGrowAnalizeLength"]; //저장값기억(2012.03.04 by 서정범
		NSLog(@" %@ ",lengthValuesTemp);
	}
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
-(IBAction) showGenderValuePicker{	
	if ( genderValuePicker.hidden) {
		genderValuePicker.hidden = NO;
		[self.view addSubview:genderValuePicker];	
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
	}
	else {
		genderValuePicker.hidden = YES;
		toolbar.hidden = YES;
		[genderValuePicker removeFromSuperview];
	}
}


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
		//[monthValuePicker selectRow:6 inComponent:0 animated:NO];

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
			//[heightValuePicker selectRow:5 inComponent:1 animated:NO];
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
-(IBAction) showWeightValuePicker
{	
	if ([segWeightValue isEqualToString:@"kg"]) {	
		if ( weightValuePicker.hidden) {
			weightValuePicker.hidden = NO;
			[self.view addSubview:weightValuePicker];
			toolbar.hidden = NO;
			[self.view addSubview:toolbar];
			[self createToolbarItems];
			//[weightValuePicker selectRow:5 inComponent:1 animated:NO];
		}
		else {
			weightValuePicker.hidden = YES;
			toolbar.hidden = YES;
			[weightValuePicker removeFromSuperview];
		}
		//미국단위 추가 (2012.10)
	}else if ([segWeightValue isEqualToString:@"lb"]) {
		if ( weightLbValuePicker.hidden) {
			weightLbValuePicker.hidden = NO;
			[self.view addSubview:weightLbValuePicker];
			toolbar.hidden = NO;
			[self.view addSubview:toolbar];
			[self createToolbarItems];
			//[heightValuePicker selectRow:5 inComponent:1 animated:NO];
		}
		else {
			weightLbValuePicker.hidden = YES;
			toolbar.hidden = YES;
			[weightLbValuePicker removeFromSuperview];
		}
	}//미국단위 추가 (2012.10)

}
-(IBAction) showLengthValuePicker{	
	if ([segLengthValue isEqualToString:@"cm"]) {		
		if ( lengthValuePicker.hidden) {
			lengthValuePicker.hidden = NO;
			[self.view addSubview:lengthValuePicker];
			toolbar.hidden = NO;
			[self.view addSubview:toolbar];
			[self createToolbarItems];
		}
		else {
			yearValuePicker.hidden = YES;
			toolbar.hidden = YES;
			[yearValuePicker removeFromSuperview];
		}
		//미국단위 추가 (2012.10)
	}else if ([segLengthValue isEqualToString:@"in"]) {
		if ( lengthInValuePicker.hidden) {
			lengthInValuePicker.hidden = NO;
			[self.view addSubview:lengthInValuePicker];
			toolbar.hidden = NO;
			[self.view addSubview:toolbar];
			[self createToolbarItems];
			//[heightValuePicker selectRow:5 inComponent:1 animated:NO];
		}
		else {
			lengthInValuePicker.hidden = YES;
			toolbar.hidden = YES;
			[lengthInValuePicker removeFromSuperview];
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
	[genderValues release];
	[yearValues release];
	[monthValues release];
	[heightValues release];
	[weightValues release];
	[weightValues2 release];
	[weightValues3 release];
	[weightValues4 release];
	[weightValues5 release];
	[lengthValues release];
	[genderValuePicker release];
	[yearValuePicker release];
	[monthValuePicker release];
	[heightValuePicker release];
	[weightValuePicker release];
	[lengthValuePicker release];
	//미국단위 추가 (2012.10)
	[heightFtValuePicker release];
	[heightFtValues release];
	[heightFtValues2 release];
	[heightFtValues3 release];
	[heightFtValues4 release];
	[heightFtValues5 release];
	[segHeightValue release];
	[segHeight release];
	
	[weightLbValuePicker release];
	[weightLbValues release];
	[weightLbValues2 release];
	[weightLbValues3 release];
	[weightLbValues4 release];
	[weightLbValues5 release];
	[segWeightValue release];
	[segWeight release];

	[lengthInValuePicker release];
	[lengthInValues release];
	[lengthInValues2 release];
	[lengthInValues3 release];
	[lengthInValues4 release];
	[segLengthValue release];
	[segLength release];
	//미국단위 추가 (2012.10)

	
	
    [super dealloc];
}


@end
