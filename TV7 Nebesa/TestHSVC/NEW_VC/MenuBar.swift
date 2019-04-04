//
//  MenuBar.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //3
    lazy var collectionView: UICollectionView = {
        //5
        let layout = UICollectionViewFlowLayout()
        //4
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 12, green: 100, blue: 194)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    //8
    let cellId = "cellId"
    let imageNames = ["subscriptions", "logoButton","trending"]
    let numberOfItemsInMenu = 3
    
    //1) init frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //9
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        //17
        
        
        //6 add subview/constraints
        addSubview(collectionView)
        addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(withVisualFormat: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
   
    }
    //7 quantity of buttons
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInMenu
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as! MenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        return cell
    }
    // size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3 , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

    //2) required init (err handler)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal Error Menu")
    }
}

class MenuCell: BaseCell {
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 23, green: 20, blue: 60)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 23, green: 20, blue: 60)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 23, green: 20, blue: 60)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat(withVisualFormat: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(withVisualFormat: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

}
