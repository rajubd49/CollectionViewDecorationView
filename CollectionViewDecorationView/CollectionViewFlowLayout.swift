//
//  CollectionViewFlowLayout.swift
//  CollectionViewDecorationView
//
//  Created by Harish-Uz-Jaman Mridha Raju on 1/31/17.
//  Copyright © 2017 Raju. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {

    // MARK: prepareLayout
    let numberOfItemsPerRow:CGFloat = 2
    
    var collectionWidth: CGFloat {
        return collectionView?.bounds.size.width ?? 0
    }
    
    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = 15.0
        minimumInteritemSpacing = 10.0
        sectionInset = UIEdgeInsetsMake(15, 15, 15, 15)
        
        let totalSpace = sectionInset.left
            + sectionInset.right
            + (minimumInteritemSpacing * (numberOfItemsPerRow - 1))
        let width = (collectionWidth - totalSpace) / numberOfItemsPerRow
        itemSize = CGSize(width: width, height: width * 1.20)
        
        register(BDCollectionReusableView.self, forDecorationViewOfKind: BDCollectionReusableView.KIND)
    }
    
    // MARK: layoutAttributesForElementsInRect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var allAttributes: [UICollectionViewLayoutAttributes] = []
        if let attributes = attributes {
            for attr in attributes {
                if attr.indexPath.item == 0 {
                    let decorator = BDCollectionViewLayoutAttributes(forDecorationViewOfKind: BDCollectionReusableView.KIND, with: attr.indexPath)
                    var rect = CGRect.zero
                    rect.size = collectionViewContentSize
                    decorator.frame = rect
                    decorator.zIndex = -1
                    allAttributes.append(decorator)
                }
                
                allAttributes.append(attr)
            }
        }
        
        return allAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        let width = collectionWidth
        let rows = CGFloat(((collectionView?.numberOfItems(inSection: 0) ?? 0) + 1) / 2)
        let height = (itemSize.height * rows) + minimumLineSpacing * (rows - 1) + sectionInset.top + sectionInset.bottom
        return CGSize(width: width, height: height)
    }
}

class BDCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes {
    var color: UIColor = UIColor.white
    
    override func copy(with zone: NSZone?) -> Any {
        let newAttributes: BDCollectionViewLayoutAttributes = super.copy(with: zone) as! BDCollectionViewLayoutAttributes
        newAttributes.color = self.color.copy(with: zone) as! UIColor
        return newAttributes
    }
}

class BDCollectionReusableView : UICollectionReusableView {
    
    static var KIND = "BDCollectionReusableView"
    static var REUSE_ID = "BDCollectionReusableView"
    
    override var reuseIdentifier: String? {
        return BDCollectionReusableView.REUSE_ID
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.customInit()
    }
    
    func customInit() {
        self.backgroundColor = UIColor.white
        
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 1.0
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    }
}
