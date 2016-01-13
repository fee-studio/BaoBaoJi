//
//  LCUserEntity.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "LCUserEntity.h"
#import "LCFamilyEntity.h"


@implementation LCUserEntity

@dynamic area;
@dynamic babyRelation;
@dynamic birthday;
@dynamic nickName;
@dynamic avatar;
@dynamic isOnline;
@dynamic sex;
@dynamic babies;
@dynamic curBaby;
@dynamic babyIndex;


+ (NSString *)parseClassName {
	return @"_User";
}

+ (void)reloadCurrentUserData; {
	[self reloadCurrentUserData:nil];
	
//	mGlobalData.user = [LCUserEntity currentUser];
	
//	AVQuery *query = [LCUserEntity query];
//	query.cachePolicy = kAVCachePolicyCacheThenNetwork;
//	[query whereKey:@"objectId" equalTo:mGlobalData.user.objectId];
//	[query includeKey:@"curBaby"];
//	[query includeKey:@"babies"];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//		if (objects) {
//			mGlobalData.user = [objects lastObject];
//		}
//	}];
	
	
//	AVQuery *familyQuery = [LCFamilyEntity query];
//	[familyQuery whereKey:@"user" equalTo:mGlobalData.user];
//	[familyQuery includeKey:@"baby"]; // vip 想查出baby 必须includeKey baby
//	[familyQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//		NSMutableArray *babies = [NSMutableArray array];
//		for(LCFamilyEntity *family in objects) {
//			LCBabyEntity *baby = family.baby;
//			if (baby) {
//				[babies addObject:baby];
//			}
//		}
//		mGlobalData.user.babies = babies;
//		mGlobalData.user.curBaby = [babies lastObject];
//		[mGlobalData.user saveInBackground];
//	}];
}

+ (void)reloadCurrentUserData:(LoadUserDataCompleteBlock)completeBlock; {
	mGlobalData.user = [LCUserEntity currentUser];
	
	if (mGlobalData.user) {
		AVQuery *familyQuery = [LCFamilyEntity query];
		[familyQuery whereKey:@"user" equalTo:mGlobalData.user];
		[familyQuery includeKey:@"baby"]; // vip 想查出baby 必须includeKey baby
		[familyQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
			NSMutableArray *babies = [NSMutableArray array];
			for(LCFamilyEntity *family in objects) {
				LCBabyEntity *baby = family.baby;
				if (baby) {
					[babies addObject:baby];
				}
			}
			mGlobalData.user.babies = babies;
			mGlobalData.user.curBaby = [babies lastObject];
			[mGlobalData.user saveInBackground];
			
			// 回调
			if (completeBlock) {
				completeBlock(error);
			}
		}];
	}
}


+ (void)loadUserData {
	mGlobalData.user = [LCUserEntity currentUser];
	if (mGlobalData.user) {
		AVQuery *query = [LCUserEntity query];
		query.cachePolicy = kAVCachePolicyCacheThenNetwork;
		[query whereKey:@"objectId" equalTo:mGlobalData.user.objectId];
		[query includeKey:@"curBaby"];
		[query includeKey:@"babies"];
		[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
			if (objects) {
				LCUserEntity *user = [objects lastObject];
				mGlobalData.user.babies = user.babies;
				mGlobalData.user.curBaby = user.curBaby;
			}
		}];
	}
	
	NSLog(@"token = %@",mGlobalData.user.sessionToken);
	
	// todo ... https://forum.leancloud.cn/t/ios-avuser-206/5375/10
	
	NSLog(@"token1 = %@",mGlobalData.user.sessionToken);
}

+ (void)loadUserAndBabyData {
	mGlobalData.user = [LCUserEntity currentUser];
	
	AVQuery *familyQuery = [LCFamilyEntity query];
	[familyQuery whereKey:@"user" equalTo:mGlobalData.user];
	[familyQuery includeKey:@"baby"]; // vip 想查出baby 必须includeKey baby
	[familyQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		NSMutableArray *babies = [NSMutableArray array];
		for(LCFamilyEntity *family in objects) {
			LCBabyEntity *baby = family.baby;
			if (baby) {
				[babies addObject:baby];
			}
		}
		mGlobalData.user.babies = babies;
		mGlobalData.user.curBaby = [babies lastObject];
		[mGlobalData.user saveInBackground];
	}];
}


@end
