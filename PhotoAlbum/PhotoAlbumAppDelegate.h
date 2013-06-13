//
//  PhotoAlbumAppDelegate.h
//  PhotoAlbum
//
//  Created by Akinbiyi Lalude on 6/10/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoAlbumCollectionViewController;

@interface PhotoAlbumAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PhotoAlbumCollectionViewController *viewController;

@end
