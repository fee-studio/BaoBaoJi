//
//  YIBbjCell.m
//  BaoBaoJi
//
//  Created by efeng on 15/11/9.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBbjCell.h"
#import "YITimelineModel.h"
#import "NSDate+Additional.h"
#import "YIModuleItemView.h"
#import "UIImageView+AFNetworking.h"

#import "YIConfigAttributedString.h"
#import "NSString+YIAttributed.h"
#import "NSDate+Additional.h"
#import "IDMPhoto.h"

static const float MARGIN_LEFT = 55.f;


@interface YIBbjCell () {
	CGFloat separate;
	CGFloat widthImage;
	CGFloat heightImage;
}

@property (nonatomic, strong) LCTimelineEntity *timeline;
@property (nonatomic, strong) NSMutableArray *photoMa;

@end

@implementation YIBbjCell

@synthesize numbersOfLine;

- (void)awakeFromNib {
    // Initialization code
    
}

- (instancetype)init {
	self = [super init];
	if (self) {
		[self loadImagePosConfig];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self loadImagePosConfig];
	}
	return self;
}

- (void)loadImagePosConfig {
	numbersOfLine = 3;
	separate = 1.f;
}

- (void)setupCell:(LCTimelineEntity *)timeline; {
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
	
	widthImage = (mScreenWidth - MARGIN_LEFT - 20.f - (numbersOfLine - 1) * separate) / numbersOfLine;
	heightImage = widthImage;
	
	self.timeline = timeline;
	
	UIView *miv = [self setupUI];
    [self.contentView addSubview:miv];
	
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [miv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}

- (UIView *)setupUI {
	UIView *moduleItemView = [[UIView alloc] init];
	
	UIView *lastView = nil;
	
	if (_timeline.happenTime) {
		NSString *timeString = [_timeline.happenTime convertDateToStringWithFormat:@"ddMM月"];
		NSInteger weekday = _timeline.happenTime.weekday;
		NSString *weekdayString = [NSString stringWithFormat:@"星期%ld",(long)weekday-1];
		NSArray *array = @[
						   // 全局设置
						   [YIConfigAttributedString font:kAppSmlFont range:[timeString range]],
						   [YIConfigAttributedString foregroundColor:kAppTextMidColor range:[timeString range]],
						   // 局部设置
						   [YIConfigAttributedString foregroundColor:kAppTextDeepColor range:NSMakeRange(0, 2)],
						   [YIConfigAttributedString font:kAppBigFont range:NSMakeRange(0, 2)]
						   ];
		UILabel *timeLbl = [[UILabel alloc] init];
		timeLbl.numberOfLines = 1;
		timeLbl.attributedText = [timeString createAttributedStringAndConfig:array];
		[moduleItemView addSubview:timeLbl];
		
		[timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(moduleItemView);
			make.left.equalTo(moduleItemView);
			make.right.mas_lessThanOrEqualTo(moduleItemView);
			make.width.mas_equalTo(50);
		}];
		
		UIButton *dayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[dayBtn setTitle:weekdayString forState:UIControlStateNormal];
		[dayBtn setBackgroundImage:[UIImage imageNamed:@"ic_tl_day_sepatate"] forState:UIControlStateNormal];
		dayBtn.titleLabel.font = kAppMiniFont;
		[moduleItemView addSubview:dayBtn];
		[dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(timeLbl.mas_bottom).with.offset(10);
			make.left.equalTo(moduleItemView);
			make.width.mas_equalTo(50);
			make.height.equalTo(@16);
		}];
	}
	
	if (_timeline.firstDo) {
		UIImageView *imageView = [[UIImageView alloc] init];
		imageView.image = [UIImage imageNamed:_timeline.firstDo[@"icon"]];
		[moduleItemView addSubview:imageView];
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(lastView ? lastView.mas_bottom : @0);
			make.left.mas_equalTo(moduleItemView).with.offset(MARGIN_LEFT);
			make.width.equalTo(@30);
			make.height.equalTo(@30);
		}];
		
		UILabel *contentLbl = [[UILabel alloc] init];
		contentLbl.numberOfLines = 0;
		contentLbl.font = kAppMidFont;
		contentLbl.textColor = kAppTextDeepColor;
		NSString *string = [NSString stringWithFormat:@"第一次%@",_timeline.firstDo[@"present"]];
		[contentLbl setText:string];
		[moduleItemView addSubview:contentLbl];
		[contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(imageView.mas_right).with.offset(3);
			make.centerY.equalTo(imageView);
		}];
		
		lastView = contentLbl;
	}
	
	if (_timeline.sharedText) {
		UILabel *titleLbl = [[UILabel alloc] init];
		titleLbl.numberOfLines = 0;
		titleLbl.font = kAppMidFont;
		titleLbl.textColor = kAppTextDeepColor;
		[titleLbl setText:_timeline.sharedText];
		[moduleItemView addSubview:titleLbl];
		
		[titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(lastView ? lastView.mas_bottom : @0).with.offset(5);
			make.left.equalTo(moduleItemView).with.offset(MARGIN_LEFT);
			make.right.mas_lessThanOrEqualTo(moduleItemView);
		}];
		
		lastView = titleLbl;
	}
	
	if (_timeline.author) {
		UILabel *subTitleLbl = [[UILabel alloc] init];
		subTitleLbl.numberOfLines = 0;
		subTitleLbl.font = kAppMidFont;
		subTitleLbl.textColor = [UIColor dangerColor];
		[subTitleLbl setText:_timeline.author.nickName];
		subTitleLbl.font = [UIFont systemFontOfSize:10];
		[moduleItemView addSubview:subTitleLbl];
		
		[subTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(lastView ? lastView.mas_right : @0).with.offset(MARGIN_LEFT);
			make.right.mas_lessThanOrEqualTo(moduleItemView); // 这个会导致主title过长的话，会使subTitle看不到啦。
			make.bottom.equalTo(lastView ? lastView : @0);
		}];
		
		lastView = subTitleLbl;
	}
	
	if (_timeline.sharedItem && _timeline.sharedItem.type == 1 && _timeline.sharedItem.data.count) {
		self.photoMa = [NSMutableArray arrayWithCapacity:_timeline.sharedItem.data.count];
		
		int curLine = 0;
		UIView *lastImageView;
		UIView *mostRightView;
		
		for (int i = 0; i < _timeline.sharedItem.data.count; i++) {
			AVFile *imageFile = _timeline.sharedItem.data[i];
			if (imageFile == nil || [imageFile isEqual:[NSNull null]]) {
				break;
			}
			
			UIImageView *imageView = [[UIImageView alloc] init];
			imageView.tag = i;
			[imageView setContentMode:UIViewContentModeScaleAspectFill];
			[imageView setClipsToBounds:YES];
			[moduleItemView addSubview:imageView];
			
			NSString *thumbnail = [imageFile getThumbnailURLWithScaleToFit:YES width:widthImage*2 height:heightImage*2];
			NSURL *thumbnailUrl = [NSURL URLWithString:thumbnail];
			[imageView sd_setImageWithURL:thumbnailUrl
						 placeholderImage:kAppPlaceHolderImage];
			
			NSURL *photoUrl = [NSURL URLWithString:imageFile.url];
			IDMPhoto *photo = [IDMPhoto photoWithURL:photoUrl];
			[_photoMa addObject:photo];
			
			UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction:)];
			[imageView addGestureRecognizer:tap];
			imageView.userInteractionEnabled = YES;
			
			if (i / numbersOfLine == curLine) {
				[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
					if (lastImageView) {
						make.top.equalTo(lastImageView.mas_top);
						make.left.equalTo(lastImageView.mas_right).offset(separate);
					} else {
						make.top.equalTo(lastView.mas_bottom).with.offset(5);
						make.left.equalTo(moduleItemView).with.offset(MARGIN_LEFT);
					}
					make.width.mas_equalTo(lastImageView ? lastImageView.mas_width : @(widthImage));
					make.height.mas_equalTo(lastImageView ? lastImageView.mas_width : @(heightImage));
				}];
				if (i == (numbersOfLine - 1)) {
					mostRightView = imageView;
				}
			} else {
				curLine = i / numbersOfLine;
				[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
					make.top.equalTo(lastImageView ? lastImageView.mas_bottom : lastView.mas_bottom).offset(separate);
					make.left.equalTo(moduleItemView).with.offset(MARGIN_LEFT);
					make.width.equalTo(lastImageView ? lastImageView.mas_width : @(widthImage));
					make.height.equalTo(lastImageView ? lastImageView.mas_width : @(heightImage));
				}];
			}
			lastImageView = imageView;
		}
		
		if (lastImageView) {
			lastView = lastImageView;
		}
	}
	
	if (_timeline.location && _timeline.location.name.isOK) {
		UIImageView *imageView = [[UIImageView alloc] init];
		imageView.image = [UIImage imageNamed:@"ic_newactivity_local_tag"];
		[moduleItemView addSubview:imageView];
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(lastView ? lastView.mas_bottom : @0).with.offset(5);
			make.left.mas_equalTo(moduleItemView).with.offset(MARGIN_LEFT);
		}];
		
		UILabel *label = [[UILabel alloc] init];
		label.numberOfLines = 0;
		label.font = kAppMidFont;
		label.textColor = kAppTextDeepColor;
		[label setText:_timeline.location.name];
		[moduleItemView addSubview:label];
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(imageView.mas_right).with.offset(3);
			make.centerY.equalTo(imageView);
		}];
		
		lastView = label;
	}
	
	// 布局收尾
	[moduleItemView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(lastView ? lastView : @0);
	}];
	
	return moduleItemView;
}

#pragma mark - 

- (void)tapImageViewAction:(UITapGestureRecognizer *)tapGr {
	UIImageView *tappedView = (UIImageView *)tapGr.view;
	NSUInteger index = tappedView.tag;
	if ([_delegate respondsToSelector:@selector(tapPhotoAtIndex:allPhotos:tappedView:)]) {
		[_delegate tapPhotoAtIndex:index allPhotos:_photoMa tappedView:tappedView];
	}
}

@end
