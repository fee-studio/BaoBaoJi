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

@interface YIBbjCell () {
    YIModuleItemView *miv;
}
//@property (nonatomic, strong) YIModuleItemView *miv;
@end

@implementation YIBbjCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setupCell:(YITimelineModel *)timeline; {
    
//    self.timeLbl.text = timeline.happenTime.shortString;
//    self.titleLbl.text = timeline.shareMsg;
    
//    NSURL *url = [NSURL URLWithString:@"http://ac-DKsBW5t5.clouddn.com/XyVnmcGCro17FJXvVOZ6OmA.jpeg"];
//    NSURL *url = [NSURL URLWithString:@"http://img5.duitang.com/uploads/item/201510/11/20151011153554_vKSTB.png"];
//    [self.imageView sd_setImageWithURL:url placeholderImage:kAppPlaceHolderImage];
//    [self.imageView sd_setImageWithURL:url];
//    [self.imageView sd_setImageWithURL:url placeholderImage:kAppPlaceHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"completed");
//    }];
//    [self.imageView sd_setImageWithURL:url placeholderImage:kAppPlaceHolderImage options:SDWebImageTransformAnimatedImage];
    
//    [self.imageView setImageWithURL:url];
    /*
    if (timeline.shareImages.count) {
        AVFile *file = [timeline.shareImages firstObject];
        if (file && ![file isKindOfClass:[NSNull class]]) {
//            NSURL *url = [NSURL URLWithString:file.url];
//            [self.imageView sd_setImageWithURL:url placeholderImage:kAppPlaceHolderImage];
            

//            NSURL *url = [NSURL URLWithString:@"http://ac-DKsBW5t5.clouddn.com/XyVnmcGCro17FJXvVOZ6OmA.jpeg"];
//            [self.imageView sd_setImageWithURL:url placeholderImage:kAppPlaceHolderImage];

            
//            [file getThumbnail:YES width:200 height:200 withBlock:^(UIImage *image, NSError *error) {
//                if (image) {
//                    self.imageView.image = image;
//                }
//            }];
            
//            [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                self.imageView.image = [UIImage imageWithData:data];
//            }];
        }
    }
     */
	
	
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    miv = [YIModuleItemView viewWithTitle:timeline.shareMsg
                                 subTitle:nil
                                  content:@"content content content contentcontent content content contentcontent content content contentcontent content content contentcontent content content contentcontent content content contentcontent content content contentcontent content content contentcontent content content contentcontent content content contentcontent content content contentcontent content content content"
                                   images:timeline.shareImages];
    [self.contentView addSubview:miv];
	
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [miv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(mScreenWidth);
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
    

//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(miv).with.insets(padding);
//    }];
//    
}

//- (void)layoutSubviews; {
//    CGFloat hhh= miv.height;
//    NSLog(@" %@ hhh = %f",self.description,hhh);
//}
//
//- (UICollectionViewLayoutAttributes *) preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
//{
//    [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    
//    UICollectionViewLayoutAttributes *attributes = [layoutAttributes copy];
//    
//    attributes.size = CGSizeMake(80, 80);
//    
//    return attributes;
//}


- (CGFloat)heightOfCell {
    if (miv) {
        return miv.height;
    } else {
        return 150.f;
    }
}

@end
