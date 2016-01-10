//
//  YIBabyInfoViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/13.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBabyInfoViewController.h"
#import "LCFamilyEntity.h"
#import "CTAssetsPickerController.h"
#import "YICompleteInfoViewController.h"
#import <QBImagePickerController/QBImagePickerController.h>

@interface YIBabyInfoViewController () <UITextFieldDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CTAssetsPickerControllerDelegate, QBImagePickerControllerDelegate> {
    UIDatePicker *datePicker;
	UIActionSheet *actionSheet;
    int familyType;
    NSString *familyTypeText;
	UIImagePickerController *imagePicker;
}

@property(weak, nonatomic) IBOutlet UITextField *nickNameTf;
@property(weak, nonatomic) IBOutlet UITextField *birthdayTf;
@property(weak, nonatomic) IBOutlet UIView *babyAvatarView;
@property(weak, nonatomic) IBOutlet UIImageView *avatarIv;

@property(strong, nonatomic) LCBabyEntity *aBaby;

@end

@implementation YIBabyInfoViewController

- (instancetype)init {
	self = [super init];
	if (self) {
		self.aBaby = [LCBabyEntity object];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _nickNameTf.delegate = self;
    _birthdayTf.delegate = self;

    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(nextItemAction)];
    self.navigationItem.rightBarButtonItem = nextItem;

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBabyAvatar:)];
    [_babyAvatarView addGestureRecognizer:tap];
	
	_avatarIv.image = kAppPlaceHolderImage;
}

- (void)selectBabyAvatar:(UIGestureRecognizer *)gestureRecognizer {
	if (actionSheet == nil) {
		actionSheet = [[UIActionSheet alloc] initWithTitle:NULL
												  delegate:self
										 cancelButtonTitle:@"取消"
									destructiveButtonTitle:NULL
										 otherButtonTitles:@"拍照", @"从手机相册选择", nil];
	}
	[actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex; {
    if (buttonIndex == 0) {			// 拍照
		[self loadPickerVc:UIImagePickerControllerSourceTypeCamera];
    } else if (buttonIndex == 1) {  // 从手机相册选择
		[self loadPickerVc:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
}

- (void)loadPickerVc:(UIImagePickerControllerSourceType)type{
	
//	YICompleteInfoViewController *vc = [[YICompleteInfoViewController alloc] init];
//	YIBaseNavigationController *navi = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
//	[self presentViewController:navi animated:YES completion:NULL];
//	
//	return;
	
    // 用系统的.
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = type;
	imagePicker.delegate = self;
	//设置选择后的图片可被编辑
	imagePicker.allowsEditing = YES;
	[self presentViewController:imagePicker animated:YES completion:nil];
	
//	QBImagePickerController *imagePickerController = [QBImagePickerController new];
//	imagePickerController.delegate = self;
//	imagePickerController.allowsMultipleSelection = NO;
////	imagePickerController.maximumNumberOfSelection = 1;
////	imagePickerController.showsNumberOfSelectedAssets = YES;
//	
//	[self presentViewController:imagePickerController animated:YES completion:NULL];
	
	
	
	
//	CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
//	// set delegate
//	picker.delegate = self;
//	// Optionally present picker as a form sheet on iPad
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//		picker.modalPresentationStyle = UIModalPresentationFormSheet;
//	}
//	// present picker
//	[self presentViewController:picker animated:YES completion:nil];
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets; {
	[imagePickerController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	// 获取图片
	PHAsset *asset = [assets firstObject];
	
	
	PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
	requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
	requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
	// this one is key
	requestOptions.synchronous = true;
	
	[[PHImageManager defaultManager] requestImageForAsset:asset
											   targetSize:CGSizeMake(100, 100)
											  contentMode:PHImageContentModeDefault
												  options:requestOptions
											resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
												_avatarIv.image = result;
												// 保存头像
												NSData *imageData = UIImagePNGRepresentation(_avatarIv.image);
												AVFile *imageFile = [AVFile fileWithName:@"baby_avatar.png" data:imageData];
												[imageFile saveInBackground];
												
												_aBaby.avatar = imageFile;

											}];
}


- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UIImagePickerControllerDelegate

//当选择一张图片后进入这里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	// 获取图片
	UIImage *image = info[UIImagePickerControllerEditedImage];
	_avatarIv.image = image;
	
	// 保存头像
	NSData *imageData = UIImagePNGRepresentation(image);
	AVFile *imageFile = [AVFile fileWithName:@"baby_avatar.png" data:imageData];
	[imageFile saveInBackground];
	
	_aBaby.avatar = imageFile;
	
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//	[picker dismissViewControllerAnimated:YES completion:NULL];
//	[picker.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
	[picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - CTAssetsPickerControllerDelegate

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group {
	return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
	[picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	// 获取图片
	ALAsset *asset = [assets firstObject];
	_avatarIv.image = [UIImage imageWithCGImage:asset.thumbnail];
	
	// 保存头像
	NSData *imageData = UIImagePNGRepresentation(_avatarIv.image);
	AVFile *imageFile = [AVFile fileWithName:@"baby_avatar.png" data:imageData];
	[imageFile saveInBackground];
	
	_aBaby.avatar = imageFile;
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset {
	// Enable video clips if they are at least 5s
	if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
		NSTimeInterval duration = [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
		return lround(duration) >= 5;
	} else {
		return YES;
	}
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset {
	return true;
}

#pragma mark -

- (void)nextItemAction {
	// 保存宝宝的信息
//	[mGlobalData.baby saveInBackground];

    LCFamilyEntity *familyEntity = [LCFamilyEntity object];
    familyEntity.type = familyType;
    familyEntity.typeText = familyTypeText;
    familyEntity.user = mGlobalData.user;
	familyEntity.baby = _aBaby; // 会自动保存?
    [familyEntity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (succeeded) {
			[mNotificationCenter postNotificationName:RELOAD_USER_DATA_NOTIFICATION object:nil];
		}
	}];

    // 进入主界面
    [mAppDelegate loadMainViewController];
	
//	[mAppDelegate loadMainViewController2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideDatePicker];
    [self hideKeyboard:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField; {
    if (textField == _birthdayTf) {
		textField.inputView = [UIView new];
        [self showDatePicker];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField; {
    _aBaby.nickName = _nickNameTf.text;
    _aBaby.birthday = datePicker.date;
    return YES;
}

#pragma mark -

- (void)showDatePicker {
    if (datePicker == nil) {
        datePicker = [[UIDatePicker alloc] init];
        [datePicker setDate:[NSDate date] animated:YES];
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        [datePicker addTarget:self action:@selector(selectedDateChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:datePicker];
        [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view);
            make.left.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.height.equalTo(@216);
        }];
    }
    if (datePicker) {
        datePicker.hidden = NO;
    }
}

- (void)hideDatePicker {
    if (datePicker) {
        datePicker.hidden = YES;
    }
}

- (void)selectedDateChanged:(id)sender {
    _birthdayTf.text = [datePicker.date convertDateToStringWithFormat:@"yyyy年MM月dd日"];
}

- (IBAction)selectedSexBtnAction:(DLRadioButton *)radiobutton {
    int sex = 0;
    switch (radiobutton.tag) {
        case 3001:
            sex = 1;
            break;
        case 3002:
            sex = 2;
            break;
        case 3003:
            sex = 0;
            break;
        default:
            break;
    }
    _aBaby.sex = sex;
}

- (IBAction)selectedRelationBtnAction:(DLRadioButton *)radiobutton {
    switch (radiobutton.tag) {
        case 4001:
            familyType = 1;
            familyTypeText = @"爸爸";
            break;
        case 4002:
            familyType = 2;
            familyTypeText = @"妈妈";
            break;
        case 4003:
            familyType = 0;
            familyTypeText = @"未知"; // todo 其他再处理
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
	actionSheet.delegate = nil;
	actionSheet = nil;
	imagePicker.delegate = nil;
	imagePicker = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
