//
//  PhotoManager.m
//  mo9Library
//
//  Created by ChenJian on 2017/8/2.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "PhotoManager.h"
#import "CTAssetsPickerController.h"
#import "PhotoModel.h"
#import "UIImage+Kit.h"

@interface PhotoManager()<UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CTAssetsPickerControllerDelegate>
{
    BOOL isPortraitT;
}
@property (nonatomic, copy) PhotoBlock photoBlock;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, assign) UIViewController *viewcontroller;
@end

@implementation PhotoManager

+ (BaseManager *)manager {
    static PhotoManager *__manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[PhotoManager alloc] init];
    });
    return __manager;
}

#pragma mark ---- take photo ----

- (void)takePhotoMaxCount:(NSUInteger)count withPresentVC:(UIViewController *)vc completion:(PhotoBlock)completion {
    __weak typeof(self) weakSelf = self;
    [RMUniversalAlert showActionSheetInViewController:vc
                                            withTitle:nil
                                              message:nil
                                    cancelButtonTitle:@"取消"
                               destructiveButtonTitle:nil
                                    otherButtonTitles:@[@"拍照",@"从手机相册选择"]
                                             tapBlock:^(NSInteger buttonIndex) {
                                                 switch (buttonIndex) {
                                                         case 0:
                                                         // 取消
                                                         break;
                                                         case 2:
                                                         // 相机
                                                         [weakSelf privateTakePhotoMaxCount:count
                                                                                 isPortrait:NO
                                                                                   isCamera:YES
                                                                              withPresentVC:vc
                                                                                 completion:completion];
                                                         break;
                                                         
                                                         case 3:
                                                         // 相册
                                                         [weakSelf privateTakePhotoMaxCount:count
                                                                                 isPortrait:NO
                                                                                   isCamera:NO
                                                                              withPresentVC:vc
                                                                                 completion:completion];
                                                         break;
                                                 }
                                             }];
}

- (void)takePhotoOnlyMaxCount:(NSUInteger)count withPresentVC:(UIViewController *)vc completion:(PhotoBlock)completion {
    [self privateTakePhotoMaxCount:count
                        isPortrait:NO
                          isCamera:NO
                     withPresentVC:vc
                        completion:completion];
}

- (void)takeCameraOnlyWithPresentVC:(UIViewController *)vc completion:(PhotoBlock)completion {
    [self privateTakePhotoMaxCount:1
                        isPortrait:NO
                          isCamera:YES
                     withPresentVC:vc
                        completion:completion];
}

- (void)takepPortraitWithPresentVC:(UIViewController *)vc completion:(PhotoBlock)completion {
    __weak typeof(self) weakSelf = self;
    [RMUniversalAlert showActionSheetInViewController:vc
                                            withTitle:nil
                                              message:nil
                                    cancelButtonTitle:@"取消"
                               destructiveButtonTitle:nil
                                    otherButtonTitles:@[@"拍照",@"从手机相册选择"]
                                             tapBlock:^(NSInteger buttonIndex) {
                                                 switch (buttonIndex) {
                                                         case 0:
                                                         // 取消
                                                         break;
                                                         case 2:
                                                         // 相机
                                                         [weakSelf privateTakePhotoMaxCount:1
                                                                                 isPortrait:YES
                                                                                   isCamera:YES
                                                                              withPresentVC:vc
                                                                                 completion:completion];
                                                         break;
                                                         case 3:
                                                         // 相册
                                                         [weakSelf privateTakePhotoMaxCount:1
                                                                                 isPortrait:YES
                                                                                   isCamera:NO
                                                                              withPresentVC:vc
                                                                                 completion:completion];
                                                         break;
                                                     default:
                                                         break;
                                                 }
                                             }];

   
}

- (void)privateTakePhotoMaxCount:(NSUInteger)count
                      isPortrait:(BOOL)isPortrait
                        isCamera:(BOOL)isCamera
                   withPresentVC:(UIViewController *)vc
                      completion:(PhotoBlock)completion
{
    isPortraitT = isPortrait;
    self.photoBlock = completion;
    self.maxCount = count;
    self.viewcontroller = vc;
    if (isCamera) {
        [self showCamera];
    }else {
        [self showPhotoLibrary];
    }
}

- (void)showCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePickerController.allowsEditing = isPortraitT;
        
        self.viewcontroller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self.viewcontroller presentViewController:imagePickerController animated:YES completion:^{}];
    }else {
        [SVProgressHUD showErrorWithStatus:Error_Mo9_CameraNotSupported];
    }
}

- (void)showPhotoLibrary {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if (isPortraitT) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.allowsEditing = YES;
            [self.viewcontroller presentViewController:imagePickerController animated:YES completion:^{}];
            return;
        }
        CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
        picker.delegate = self;
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        [self.viewcontroller presentViewController:picker animated:YES completion:nil];
    }else {
        [SVProgressHUD showErrorWithStatus:Error_Mo9_CameraNotSupported];
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:isPortraitT?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    PhotoModel *m = [[PhotoModel alloc] init];
    m.image = [image compressedImage];
    self.photoBlock(@[m]);
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self destory];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self destory];
}

#pragma mark - Assets Picker Delegate
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group
{
    return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    if (picker.selectedAssets.count < self.maxCount) {
        return YES;
    }else {
        [RMUniversalAlert showAlertInViewController:picker
                                          withTitle:nil
                                            message:[NSString stringWithFormat:@"你最多只能选择%zd张照片",self.maxCount] cancelButtonTitle:@"我知道了"
                             destructiveButtonTitle:nil
                                  otherButtonTitles:nil
                                           tapBlock:^(NSInteger buttonIndex) {
                                               
                                           }];
        return NO;
    }
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:assets.count];
    for (ALAsset *asset in assets) {
        @autoreleasepool {
            PhotoModel *m = [[PhotoModel alloc] init];
            m.asset = asset;
            m.image = [[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage] compressedImage];
            [arr addObject:m];
        }
    }
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.photoBlock) {
        self.photoBlock(arr);
    }
    [self destory];
}

- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker
{
    [self destory];
}

- (void)destory {
    self.photoBlock = nil;
    self.viewcontroller = nil;
    self.maxCount = 0;
}

@end
