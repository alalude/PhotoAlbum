//
//  PhotoAlbumLayout.h
//  PhotoAlbum
//
//  Created by Akinbiyi Lalude on 6/12/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;

@end
