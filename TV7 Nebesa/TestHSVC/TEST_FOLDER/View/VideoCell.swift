//
//  VideoCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    //computed property for UIImageView in the cell
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        //            imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "WebPlayer.png")
//        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Title label for cell
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Video Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Date label
    let dateLabel: UILabel = {
        let label = UILabel()
        //            label.backgroundColor = UIColor.darkGray
        label.text = "22/12/2018"
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Description/subtitle label
    let captionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.darkGray
        label.text = "Caption to the video"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //separator line computed
    let separatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    //setup views with constraints
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(captionLabel)
        

        addConstraintsWithFormat(withVisualFormat: "H:|-8-[v0]-4-[v1]-8-|", views: thumbnailImageView, titleLabel)
        addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: separatorView)
        
        addConstraintsWithFormat(withVisualFormat: "V:|-8-[v0(30)]-2-[v1(8)]-2-[v2]-8-|", views: titleLabel, dateLabel, captionLabel)
        addConstraintsWithFormat(withVisualFormat: "V:|-8-[v0]-8-[v1(1)]|", views: thumbnailImageView, separatorView)
        
        
        addConstraints([NSLayoutConstraint(
            item: thumbnailImageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 1.7778 ,
            constant: 0)])
        ////title label
        addConstraints([NSLayoutConstraint(
            item: titleLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: thumbnailImageView,
            attribute: .right,
            multiplier: 1,
            constant: 4)])
        
        addConstraints([NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: thumbnailImageView,
            attribute: .top,
            multiplier: 1,
            constant: 2)])
        //dateLabel
        addConstraints([NSLayoutConstraint(
            item: dateLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .left,
            multiplier: 1,
            constant: 0)])
        
        addConstraints([NSLayoutConstraint(
            item: dateLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 2)])
        
        addConstraints([NSLayoutConstraint(
            item: dateLabel,
            attribute: .right,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .right,
            multiplier: 1,
            constant: 0)])
        //caption Label
        addConstraints([NSLayoutConstraint(
            item: captionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: dateLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 2)])
        
        addConstraints([NSLayoutConstraint(
            item: captionLabel,
            attribute: .right,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .right,
            multiplier: 1,
            constant: 0)])
        
        addConstraints([NSLayoutConstraint(
            item: captionLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .left,
            multiplier: 1,
            constant: 0)])
        
        addConstraints([NSLayoutConstraint(
            item: captionLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: thumbnailImageView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0)])
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init coder has not be implemented")
        
    }
}
