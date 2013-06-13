//
//  PhotoAlbumLayout.m
//  PhotoAlbum
//
//  Created by Akinbiyi Lalude on 6/12/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "PhotoAlbumLayout.h"

static NSString * const PhotoAlbumLayoutPhotoCellKind = @"PhotoCell";


@interface PhotoAlbumLayout ()

@property (nonatomic, strong) NSDictionary *layoutInfo;

@end


@implementation PhotoAlbumLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(125.0f, 125.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}

- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath
{
    // The frame is computed based on the index path passed in
    
    // determine the correct row and column for the item
    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;
    
    // determine the combined total amount of horizontal spacing between items
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.itemSize.width);
    
    // if we have more than 1 column, we divide up the total spacing to arrive at the spacing for each item
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
    
    // calculate the horizontal offset of our frame
    // Notice that we floor this value so that our frame lands on whole pixels, ensuring it looks sharp
    // One subtle detail here is that we should floor the value at this point, not in the line before where we divided by the number of columns. This ensures that items are spaced correctly as we go across since we round the value after multiplying by the column
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
    
    // calculate our vertical offset and then return the frame based on the origins and item size
    CGFloat originY = floor(self.itemInsets.top +
                            (self.itemSize.height + self.interItemSpacingY) * row);
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

- (void)prepareLayout
{
    // create some mutable dictionaries
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    // for each section in the collection view we loop through each of it's items and create UICollectionViewLayoutAttributes based on the current index path
    for (NSInteger section = 0; section < sectionCount; section++)
    {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++)
        {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            // set the frame for this view's attributes
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForAlbumPhotoAtIndexPath:indexPath];
            
            // add these attributes to the sub-dictionary
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    // set our private dictionary property to the temporary dictionary we created
    newLayoutInfo[PhotoAlbumLayoutPhotoCellKind] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // creating a mutable array where we can store all the attributes that need to be returned
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    // take advantage of the nice block-based dictionary enumeration to cruise through our layoutInfo dictionary
    
    // The outer block iterates through each of the sub-dictionaries we've added (only the cells at the moment)
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop)
    {
        // then we iterate through each cell in the sub-dictionary
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop)
        {
            // CGRectIntersectsRect makes it simple to check if the cell we're looking at intersects with the rect that was passed in
            if (CGRectIntersectsRect(rect, attributes.frame))
            {
                // add it to the array we'll be passing back
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // looking up the sub-dictionary for cells and then returning the layout attributes for a cell at the passed in index path
    return self.layoutInfo[PhotoAlbumLayoutPhotoCellKind][indexPath];
}

- (CGSize)collectionViewContentSize
{
    // calculates and returns the total size needed to show everything in our collection view
    NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
    // make sure we count another row if one is only partially filled
    if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;
    
    // The height is based on the total number of rows and the width is simply the width of the collection view itself
    CGFloat height = self.itemInsets.top +
    rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
    self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

@end
