//
//  GrowthAnalizeResultComment.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "GrowthAnalizeResultComment.h"
#import "RootViewController.h"
#import "BABYGROWTHAppDelegate.h"


@implementation GrowthAnalizeResultComment
@synthesize btnCancel;
@synthesize infoComment;
@synthesize	infoWebComment;		//정보 2012.3.4 추가 by 서정범
@synthesize ivGraphCellHeight;  //그래프셀(키)
@synthesize ivGraphCellWeight;  //그래프셀(몸무게)
@synthesize ivGraphCellHead;	//그래프셀(머리둘레)
@synthesize timer;
@synthesize second;

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

/*===================================================================================================
//메인메뉴로 돌아감
===================================================================================================*/ 
-(IBAction) btnCancelTouched
{
	//[self.navigationController popViewControllerAnimated:YES];
	[self.navigationController popToRootViewControllerAnimated:YES];
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
-(void)seeGrowthAnalizeComment:(NSString *)inputGender 
						  Year:(NSString*)inputYear 
						 Month:(NSString*)inputMonth 
						Height:(NSString*)resultHeight 
						Weight:(NSString*)resultWeight 
						Length:(NSString*)resultLength
{
	
	
	/*
	NSString *babyInfo ;
	
	babyInfo=@"태어난지 ";
	babyInfo=[babyInfo stringByAppendingString:inputYear];
	babyInfo=[babyInfo stringByAppendingString:@"년 "];
	babyInfo=[babyInfo stringByAppendingString:inputMonth];
	babyInfo=[babyInfo stringByAppendingString:@"개월 된 "];
	babyInfo=[babyInfo stringByAppendingString:inputGender];
	
	if(![resultHeight isEqualToString:@"Over"])
	{
		babyInfo=[babyInfo stringByAppendingString:@"자아이입니다.\n\n<키>\n키의 경우 하위"];
		babyInfo=[babyInfo stringByAppendingString:resultHeight];
		babyInfo=[babyInfo stringByAppendingString:@"% 범위에 속합니다.\n하위 "];
		babyInfo=[babyInfo stringByAppendingString:resultHeight];
		babyInfo=[babyInfo stringByAppendingString:@"% 란 같은 또래 아이의 100명을 기준으로 작은순을 1번으로하였을때 "];
		babyInfo=[babyInfo stringByAppendingString:resultHeight];
		babyInfo=[babyInfo stringByAppendingString:@"번째를 의미합니다."];
	}
	else
	{
		babyInfo=[babyInfo stringByAppendingString:@"자아이입니다.\n\n<키>\n키의 경우 동일 또래와 비교할 때 표준범위를 Over한다고 판단됩니다."];
	}
	
	
	if(![resultWeight isEqualToString:@"Over"])
	{
		babyInfo=[babyInfo stringByAppendingString:@"\n\n<몸무게>\n몸무게의 경우 하위"];
		babyInfo=[babyInfo stringByAppendingString:resultWeight];
		babyInfo=[babyInfo stringByAppendingString:@"% 범위에 속합니다.\n하위 "];
		babyInfo=[babyInfo stringByAppendingString:resultWeight];
		babyInfo=[babyInfo stringByAppendingString:@"% 란 같은 또래 아이의 100명을 기준으로 작은순을 1번으로하였을때 "];
		babyInfo=[babyInfo stringByAppendingString:resultWeight];
		babyInfo=[babyInfo stringByAppendingString:@"번째를 의미합니다."];	
	}
	else
	{
		babyInfo=[babyInfo stringByAppendingString:@"\n\n<몸무게>\n몸무게의 경우 동일 또래와 비교할 때 표준범위를 Over한다고 판단됩니다."];
	}
	
	
	int intYear=[inputYear intValue];
	if(intYear > 5)
	{
		babyInfo=[babyInfo stringByAppendingString:@"\n\n<머리둘레>\n머리둘레의 경우 6세를 넘어서는 아이에 대해서는 측정 불가합니다."];	
	}
	else if(![resultLength isEqualToString:@"Over"])
	{
		babyInfo=[babyInfo stringByAppendingString:@"\n\n<머리둘레>\n머리둘레의 경우 하위"];
		babyInfo=[babyInfo stringByAppendingString:resultLength];
		babyInfo=[babyInfo stringByAppendingString:@"% 범위에 속합니다.\n하위 "];
		babyInfo=[babyInfo stringByAppendingString:resultLength];
		babyInfo=[babyInfo stringByAppendingString:@"% 란 같은 또래 아이의 100명을 기준으로 작은순을 1번으로하였을때 "];
		babyInfo=[babyInfo stringByAppendingString:resultLength];
		babyInfo=[babyInfo stringByAppendingString:@"번째를 의미합니다."];	
	}
	else
	{
		babyInfo=[babyInfo stringByAppendingString:@"\n\n<머리둘레>\n머리둘레의 경우 동일 또래와 비교할 때 표준범위를 Over한다고 판단됩니다."];
	}
	
	[infoComment setFont:[UIFont boldSystemFontOfSize:13.5]]; //폰트사이즈
	infoComment.text=babyInfo;
	infoComment.backgroundColor = [UIColor clearColor];
	*/

	
	//아래코드는 커맨트를 HTML 로 처리하기 위한 방법... 2012.3.4 by 서정범
	NSString *babyWebInfo ;
	babyWebInfo=@"";
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<HTML>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<BODY STYLE='background-color: transparent'>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<FONT SIZE='2' COLOR='#666666'>"];
	
	babyWebInfo=[babyWebInfo stringByAppendingString:@"A baby "];
	babyWebInfo=[babyWebInfo stringByAppendingString:inputGender];
	babyWebInfo=[babyWebInfo stringByAppendingString:@" was "];	
	
	babyWebInfo=[babyWebInfo stringByAppendingString:inputYear];
	babyWebInfo=[babyWebInfo stringByAppendingString:@" year(s) and "];
	babyWebInfo=[babyWebInfo stringByAppendingString:inputMonth];
	babyWebInfo=[babyWebInfo stringByAppendingString:@" month(s) old."];

	
	
	//키
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<BR><BR><font size='3' color='#0000FF'><b>Height<b></font><BR>"];
	if(![resultHeight isEqualToString:@"Over"])
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"Height is in the bottom of <font color='#FF0000'><b>"];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultHeight];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% </b></font>.<BR> In the bottom of "];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultHeight];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% means  rank of "];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultHeight];
		babyWebInfo=[babyWebInfo stringByAppendingString:@" among a similar cohort of 100 childrens in the order of shortness."];
	}
	else
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"<font color='FFFF99'><b>Height exceed standards by comparing it to the growth data of children of similar age.</b></font>"];
	}
	
	
	//몸무게
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<BR><BR><font size='3' color='#0000FF'><b>Weight<b></font><BR>"];
	if(![resultWeight isEqualToString:@"Over"])
	{
		
		babyWebInfo=[babyWebInfo stringByAppendingString:@"Weight is in the bottom of <font color='#FF0000'><b>"];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultWeight];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% </b></font>.<BR>In the bottom of "];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultWeight];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% means  rank of "];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultWeight];
		babyWebInfo=[babyWebInfo stringByAppendingString:@" among a similar cohort of 100 childrens in the order of thinness."];	
	}
	else
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"<font color='FFFF99'><b>Weight exceed standards by comparing it to the growth data of children of similar age.</b></font>"];
	}
	
	
	//머리둘레
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<BR><BR><font size='3' color='#0000FF'><b>Head circumference<b></font><BR>"];
	int intYear=[inputYear intValue];
	if(intYear > 5)
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"<font color='FFFF99'><b>Head circumference is only evaluated til age 5.</b></font>"];	
	}
	else if(![resultLength isEqualToString:@"Over"])
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"Head circumference is in the bottom of <font color='#FF0000'><b>"];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultLength];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% </b></font>.<BR>In the bottom of "];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultLength];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% means  rank of "];
		babyWebInfo=[babyWebInfo stringByAppendingString:resultLength];
		babyWebInfo=[babyWebInfo stringByAppendingString:@" among a similar cohort of 100 childrens in the order of smallness."];	
	}
	else
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"<font color='FFFF99'><b>Head circumference exceed standards by comparing it to the growth data of children of similar age.</b></font>"];
	}
	babyWebInfo=[babyWebInfo stringByAppendingString:@"</FONT>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"</BODY>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"</HTML>"];
	
	//HTML 로드 
	[infoWebComment setBackgroundColor:[UIColor clearColor]]; 
	[infoWebComment setOpaque:NO]; //배경을 투명하게
	id scrollView = [infoWebComment.subviews objectAtIndex:0];
	for (UIView *subview in [scrollView subviews]) {
		if ([subview isKindOfClass:[UIImageView class]]) {
			subview.hidden = YES;
		}
	}	
	
	[infoWebComment loadHTMLString:babyWebInfo baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
	
	
	
	//급간에 따라 보여줄 이미지를 다르게 적용
	UIImageView *ivTemp;
	
	//키그래프 
	if([resultHeight isEqualToString:@"Over"])
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_abnormal.png"]];
	}
	else if([resultHeight intValue]<=30)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_height_L1.png"]];
	}
	else if([resultHeight intValue]<=70)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_height_L2.png"]];
	}
	else if([resultHeight intValue]<=100)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_height_L3.png"]];
	}
	[ivGraphCellHeight addSubview:ivTemp];
	[ivTemp release];
	
	
	//몸무게 그래프
	if([resultWeight isEqualToString:@"Over"])
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_abnormal.png"]];
	}
	else if([resultWeight intValue]<=30)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_weight_L1.png"]];
	}
	else if([resultWeight intValue]<=70)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_weight_L2.png"]];
	}
	else if([resultWeight intValue]<=100)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_weight_L3.png"]];
	}
	[ivGraphCellWeight addSubview:ivTemp];
	[ivTemp release];
	
	
	//머리둘레 그래프 
	if([resultLength isEqualToString:@"Over"])
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_abnormal.png"]];
	}
	else if([resultLength intValue]<=30)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_head_L1.png"]];
	}
	else if([resultLength intValue]<=70)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_head_L2.png"]];
	}
	else if([resultLength intValue]<=100)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph_cell_head_L3.png"]];
	}
	[ivGraphCellHead addSubview:ivTemp];
	[ivTemp release];
	
	//최소한번은 실행했음.
	[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keyAtLeastOneUse"];
	
}
- (void)didReceiveMemoryWarning 
{
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
