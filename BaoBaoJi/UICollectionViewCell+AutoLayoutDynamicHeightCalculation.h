#import <UIKit/UIKit.h>

typedef void (^UICollectionViewCellAutoLayoutRenderBlock)(void);

/**
 *  A category on UICollectionViewCell to aid calculating dynamic heights based on AutoLayout contraints.
 *
 *  Many thanks to @smileyborg and @wildmonkey
 *
 *  @see stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
 */
@interface UICollectionViewCell (AutoLayoutDynamicHeightCalculation)

/**
 *  Grab an instance of the receiving type to use in order to calculate AutoLayout contraint driven dynamic height. The method pulls the cell from a nib file and moves any Interface Builder defined contrainsts to the content view.
 *
 *  @param name Name of the nib file.
 *
 *  @return collection view cell for using to calculate content based height
 */
+ (instancetype)heightCalculationCellFromNibWithName:(NSString *)name;

/**
 *  Returns the height of the receiver after rendering with your model data and applying an AutoLayout pass
 *
 *  @param block Render the model data to your UI elements in this block
 *
 *  @return Calculated constraint derived height
 */
- (CGFloat)heightAfterAutoLayoutPassAndRenderingWithBlock:(UICollectionViewCellAutoLayoutRenderBlock)block collectionViewWidth:(CGFloat)width;

/**
 *  Directly calls `heightAfterAutoLayoutPassAndRenderingWithBlock:collectionViewWidth` assuming a collection view width spanning the [UIScreen mainScreen] bounds
 */
- (CGFloat)heightAfterAutoLayoutPassAndRenderingWithBlock:(UICollectionViewCellAutoLayoutRenderBlock)block;

@end