//
//  GrowthAnalizeResultComment.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GrowthAnalizeResultComment : UIViewController 
{
	IBOutlet UIButton		*btnCancel;
	IBOutlet UITextView		*infoComment;		//정보
	IBOutlet UIWebView		*infoWebComment;	//정보 2012.3.4 추가 by 서정범
	IBOutlet UIImageView	*ivGraphCellHeight; //그래프셀(키)
	IBOutlet UIImageView	*ivGraphCellWeight; //그래프셀(몸무게)
	IBOutlet UIImageView	*ivGraphCellHead;	//그래프셀(머리둘레)
	NSTimer *timer;	//타이머
	int second;//초
	
}
@property(nonatomic,retain) IBOutlet UIButton *btnCancel;

@property (nonatomic,retain) IBOutlet UITextView	*infoComment;
@property (nonatomic,retain) IBOutlet UIWebView		*infoWebComment;	//정보 2012.3.4 추가 by 서정범
@property (nonatomic,retain) IBOutlet UIImageView	*ivGraphCellHeight; //그래프셀(키)
@property (nonatomic,retain) IBOutlet UIImageView	*ivGraphCellWeight; //그래프셀(몸무게)
@property (nonatomic,retain) IBOutlet UIImageView	*ivGraphCellHead;	//그래프셀(머리둘레)

@property(retain,nonatomic) NSTimer *timer; //타이머
@property (nonatomic, assign) int second;

-(IBAction)btnCancelTouched;
-(void)seeGrowthAnalizeComment:(NSString *)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)resultHeight Weight:(NSString*)resultWeight Length:(NSString*)resultLength;
@end
