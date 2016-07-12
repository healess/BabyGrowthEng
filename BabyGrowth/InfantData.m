//
//  InfantData.m
//  Infant
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "InfantData.h"


@implementation InfantData

@synthesize  mIndex;
@synthesize  mPercent;
//이력관련 추가
@synthesize mIndex2;
@synthesize mName;
@synthesize mGender;
@synthesize mDate;
@synthesize mYear;
@synthesize mMonth;
@synthesize mHeight;
@synthesize mHeightPercent;
@synthesize mWeight;
@synthesize mWeightPercent;
@synthesize mLength;
@synthesize mLengthPercent;

-(id)initWithData:(NSInteger)pIndex Percent:(NSString*)pPercent;
{
	self.mIndex = pIndex;
	self.mPercent = pPercent;
	return self;
}

//이력관련 추가
-(id)initHistoryWithData:(NSInteger)pIndex Name:(NSString*)pName Gender:(NSString*)pGender Date:(NSString*)pDate Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight HeightPercent:(NSString*)pHeightPercent Weight:(NSString*)pWeight WeightPercent:(NSString*)pWeightPercent Length:(NSString*)pLength LengthPercent:(NSString*)pLengthPercent;
{
	self.mIndex2 = pIndex;
	self.mName = pName;
	self.mGender = pGender;
	self.mDate = pDate;
	self.mYear = pYear;
	self.mMonth = pMonth;
	self.mHeight = pHeight;
	self.mHeightPercent = pHeightPercent;
	self.mWeight = pWeight;
	self.mWeightPercent = pWeightPercent;
	self.mLength = pLength;
	self.mLengthPercent = pLengthPercent;
	return self;
}
//이력관련 추가
-(id)initHistoryWithData:(NSString*)pName;
{
	self.mName = pName;
	return self;
}

- (void)dealloc {
    [super dealloc];
}
@end
