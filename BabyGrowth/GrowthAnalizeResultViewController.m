//
//  GrowthAnalizeResultViewController.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "GrowthAnalizeResultViewController.h"
#import "GrowthAnalizeResultComment.h"
#import "InfantData.h"
#import <QuartzCore/QuartzCore.h>

@implementation GrowthAnalizeResultViewController

@synthesize btnCancel;
@synthesize btnGoToGrowthAnalizeResultComment;
@synthesize btnFacebookShare;
@synthesize result_Height;
@synthesize result_Weight;
@synthesize result_Length;
@synthesize pGender;
@synthesize pYear;
@synthesize pMonth;
@synthesize pLength;
@synthesize pHeight;
@synthesize pWeight;
@synthesize btnSaveHistory;
@synthesize inputName;


//============================================================================================================
// 페이스북 공유 버튼 누를시.
//============================================================================================================
-(IBAction)btnFacebookShareTouched
{
	
	BABYGROWTHAppDelegate *appDelegate=(BABYGROWTHAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	
	//버튼을 숨긴후...
	btnSaveHistory.hidden=YES;
	btnCancel.hidden=YES;
	btnGoToGrowthAnalizeResultComment.hidden=YES;
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
	btnSaveHistory.hidden=NO;
	btnCancel.hidden=NO;
	btnGoToGrowthAnalizeResultComment.hidden=NO;
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
//============================================================================================================
// 취소버튼 누를시
//============================================================================================================
-(IBAction) btnCancelTouched
{
	[self.navigationController popViewControllerAnimated:YES];
}
//============================================================================================================
// 다음 버튼 누를시
//============================================================================================================
-(IBAction)btnGoToGrowthAnalizeResultCommentTouched
{
	GrowthAnalizeResultComment *growthAnalizeResultComment=[[GrowthAnalizeResultComment alloc] initWithNibName:@"GrowthAnalizeResultComment" bundle:nil];
	[self.navigationController pushViewController:growthAnalizeResultComment animated:YES];
	[growthAnalizeResultComment seeGrowthAnalizeComment:pGender.text Year:pYear.text Month:pMonth.text Height:result_Height.text Weight:result_Weight.text Length:result_Length.text];
	//[growthAnalizeResultComment seeGrowthAnalizeComment:pYear.text Year:pYear.text Month:pMonth.text Height:result_Height.text Weight:result_Weight.text Length:result_Length.text];	
	[growthAnalizeResultComment release];
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
						   cancelButtonTitle:@"OK"
						   otherButtonTitles:nil];
	
	[warn show];		
	[warn release];
	
}


/*===================================================================================================
 //성장저장하기
 ===================================================================================================*/ 
-(IBAction) btnSaveHistoryTouched
{
	
	inputName.text=[inputName.text stringByReplacingOccurrencesOfString:@" " withString:@""];//공백제거(Trim)
	if([inputName.text isEqualToString:@""])
	{
		[self ShowMessageBox:@"Input child's name."];
	}
	else 
	{
		NSDate* today = [NSDate date];
		NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateFormat:@"yyyyMMdd"];
		NSString *str1 =[dateFormatter stringFromDate:today];	
		//NSLog(@" %@ ",inputName.text);
		
		BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
		[appDelegate saveHistoryToDatabase:inputName.text Gender:pGender.text Date:str1 Year:pYear.text Month:pMonth.text Height:pHeight.text HeightPercent:result_Height.text Weight:pWeight.text WeightPercent:result_Weight.text Length:pLength.text LengthPercent:result_Length.text];
		[self ShowMessageBox:@"Saved."];
		
	}

}
//============================================================================================================
// 아가 이름 입력하려고 누르면 기존의 이름을 지워준다.
//============================================================================================================
-(IBAction) inputNameBeginEdit
{
	inputName.text=@"";
}


//배경 클릭 시 키보드 제거 혹은 피커 뷰 제거 기능
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[inputName resignFirstResponder];
	[[NSUserDefaults standardUserDefaults] setObject:inputName.text forKey:@"keyBabyName"]; //저장값기억(2012.03.26 by 서정범
//	[super touchesBegan:touches withEvent:event];
	//[self disappearAll];
	
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)rootViewControllerDidEnd:(NSString *)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)inputHeight Weight:(NSString*)inputWeight Length:(NSString*)inputLength
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

	int birthYear=[inputYear intValue];
	int birthMonth=[inputMonth intValue];
	
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
	NSString *heightResult;
	NSString *weightResult;
	NSString *lengthResult;	
	//문자열 포함 검색을 통한 ft및 cm체크
	if ([inputHeight rangeOfString:@"ft"].location != NSNotFound) {
		NSString *height1 =[inputHeight substringToIndex:1];//ft가져오기
		NSString *height2 =[inputHeight substringFromIndex:4];//in가져오기
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
		heightResult = [inputHeight stringByReplacingOccurrencesOfString:@"cm" withString:@""];//계산을 위한 in값 잘라내기 
		//NSLog(@"단위 변환 결과 (키:cm) : %@ ",inputHeight);

	}
	//몸무게 계산
	if ([inputWeight rangeOfString:@"lb"].location != NSNotFound) {
		NSString *weight1 = [inputWeight stringByReplacingOccurrencesOfString:@"lbs" withString:@""];//계산을 위한 in값 잘라내기
		//위 방식도 가능 --> urlString = [urlString substringFromIndex:[urlString length]-1];
		float weight2=[weight1 floatValue];
		weight2=weight2*0.453f;
		weightResult=[[NSString alloc] initWithFormat:@"%.2f", weight2];//반올림하여 소수점 한자리만 출력
		NSLog(@"단위 변환 결과 (몸무게) : %@ ",weightResult);
	}
	//kg인경우
	else {
		weightResult = [inputWeight stringByReplacingOccurrencesOfString:@"kg" withString:@""];//계산을 위한 in값 잘라내기 		
	}
	//머리둘레 계산
	if ([inputLength rangeOfString:@"in"].location != NSNotFound) {
		NSString *length1 = [inputLength stringByReplacingOccurrencesOfString:@"in" withString:@""];//계산을 위한 in값 잘라내기
		//위 방식도 가능 --> urlString = [urlString substringFromIndex:[urlString length]-1];
		float length2=[length1 floatValue];
		length2=length2*2.54f;
		lengthResult=[[NSString alloc] initWithFormat:@"%.1f", length2];//반올림하여 소수점 한자리만 출력
		NSLog(@"단위 변환 결과 (머리둘레) : %@ ",lengthResult);
	}
	//cm인경우
	else {
		lengthResult = [inputLength stringByReplacingOccurrencesOfString:@"cm" withString:@""];//계산을 위한 in값 잘라내기 		
	}	//미국단위 추가 (2012.10)

	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate readDataFromDatabase:inputGender Year: [[NSString alloc] initWithFormat:@"%i", liveYear] Month: [[NSString alloc] initWithFormat:@"%i", liveMonth] Height:heightResult Weight:weightResult Length:lengthResult];

	InfantData *mData = [[appDelegate DBData] objectAtIndex:0];
	InfantData *mData2 = [[appDelegate DBData] objectAtIndex:1];
	InfantData *mData3 = [[appDelegate DBData] objectAtIndex:2];
	
	//표준번위초과여부 확인하고 초과하면 "초과" 라는 글자를 보여준다.(신장)
	if([mData.mPercent isEqualToString:@"표준범위초과"])
	{
		self.result_Height.textColor=[UIColor yellowColor];
		self.result_Height.text=@"Over";
	}
	else
	{
		//self.result_Height.textColor=[UIColor blueColor];
		self.result_Height.text=mData.mPercent;
	}
	
	
	
	//표준번위초과여부 확인하고 초과하면 "초과" 라는 글자를 보여준다.(몸무게)
	if([mData2.mPercent isEqualToString:@"표준범위초과"])
	{
		self.result_Weight.textColor=[UIColor yellowColor];
		self.result_Weight.text=@"Over";
	}
	else
	{
		//self.result_Weight.textColor=[UIColor blueColor];
		self.result_Weight.text=mData2.mPercent;
	}
	
	
	
	//표준번위초과여부 확인하고 초과하면 "초과" 라는 글자를 보여준다.(머리둘레)
	if([mData3.mPercent isEqualToString:@"표준범위초과"])
	{
		self.result_Length.textColor=[UIColor yellowColor];
		self.result_Length.text=@"Over";
	}
	else
	{
		//self.result_Length.textColor=[UIColor blueColor];
		self.result_Length.text=mData3.mPercent;
	}
	
	
	//남여 구분 표시
	if([inputGender isEqualToString:@"B"])
	{
		self.pGender.text=@"Boy";
	}
	else 
	{
		self.pGender.text=@"Girl";
	}
	self.pYear.text=[[NSString alloc] initWithFormat:@"%i", liveYear] ;
	self.pMonth.text=[[NSString alloc] initWithFormat:@"%i", liveMonth] ;
	self.pLength.text=inputLength;
	self.pHeight.text=inputHeight;
	self.pWeight.text=inputWeight;

	//저장값 기억 표시(아기이름) by 서정범 2012.3.25
	inputName.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"keyBabyName"];
	
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
    [super dealloc];
}


@end
