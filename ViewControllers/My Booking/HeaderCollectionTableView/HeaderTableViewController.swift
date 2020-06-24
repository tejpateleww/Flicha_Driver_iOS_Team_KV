//
//  CollectionTabBar.swift
//  CabRideDriver
//
//  Created by EWW-iMac Old on 01/05/19.
//  Copyright © 2019 baps. All rights reserved.
//

import UIKit

class HeaderTableViewController: UIView {
    // //-------------------------------------
    // MARK:- Data to set
    //-------------------------------------
    
    var titles = [String]()
   
    var parentVC : (UIViewController & UITableViewDelegate & UITableViewDataSource)!
    
    var didSelectItemAt: ((( previousIndexPath : IndexPath, indexPath: IndexPath)) -> ())?
    
    var isHeaderShadowEnabled = true
    
    var textColor = UIColor.white
    
    var textFont = UIFont.boldSystemFont(ofSize: 15)
    
    var headerBgColor = UIColor.clear
    
    var pageBgColor  = UIColor.clear
    // To fit in full width
    var isSizeToFitCellNeeded: Bool = false
    
    var spacing = CGFloat(0)
    
    var SelectIndex:Int = 0 {
        didSet {
            let IndexPaths = IndexPath(item: self.SelectIndex, section: 0)
            self.indexPath = IndexPaths
            let selectedHeaderLine = indexPath
//            if let lang = userDefault.value(forKey: "language") as? String , lang != "en" {
//                if indexPath.row == 0 {
//                    let selectIndex = IndexPath(item: 2, section: 0)
//                    selectedHeaderLine = selectIndex
//                }
//                else if indexPath.row == 2 {
//                    let selectIndex = IndexPath(item: 0, section: 0)
//                    selectedHeaderLine = selectIndex
//                }
//            }
            scrollToIndexPath(indexPath: selectedHeaderLine)
            
            // scrollToIndexPath(indexPath: IndexPaths)
            if didSelectItemAt != nil { didSelectItemAt!((previousIndexPath, IndexPaths ))
            }
            self.headerCollectionView.reloadData()
        }
    }
    
 
    var isHeaderVisible = true {
        didSet {
            headerHeight = isHeaderVisible ? headerHeight : 0
            if subviews.contains(headerCollectionView){
                headerCollectionView.removeFromSuperview()
            }
            if subviews.contains(indicatorView){
                indicatorView.removeFromSuperview()
            }
            pageCollectionSetup()
        }
    }
    
    func reloadData() {
        headerCollectionView.reloadData()
        tableView.reloadData()
    }
    

    
    // //-------------------------------------
    // MARK:- Indicator/Line setup
    //-------------------------------------
    
    var indicatorHeight : CGFloat = 3
    var headerHeight : CGFloat = 50
    var isIndicatorLineVisible = true
    
    var indicatorColor =  UIColor.lightGray
    
    // //-------------------------------------
    // MARK:- Private Data
    //-------------------------------------
    private var cellWidth: CGFloat = 30
    private var indicatorView = UIView()
    
    var cellInset: UIEdgeInsets?{
        didSet{
            indicatorViewSetup()
        }
    }
    
    private var floatCount : CGFloat{
        return CGFloat(titles.count)
    }
    
 
   
    private lazy var headerCollectionView : UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = headerBgColor
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = pageBgColor
        return table
    }()
    
    var registerNibs : [String]!{
        didSet{
            for nib in registerNibs{
                tableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: nib)
            }
            tableView.delegate = parentVC
            tableView.dataSource = parentVC
        }
    }
    func scrollToIndexPath(indexPath: IndexPath){
        let cell = headerCollectionView.cellForItem(at: indexPath)
        
        cellWidth = widthOfString(usingFont: textFont, string: titles[indexPath.item]) + 10
        
        let realCenter = headerCollectionView.convert((cell?.center)!, to: self)
        
        scrollIndicatorView(offset: realCenter)
    }
    
    
    private var indexPath = IndexPath(item: 0, section: 0){
        willSet{
            previousIndexPath = indexPath
        }
    }
    private var previousIndexPath = IndexPath(item: 0, section: 0)
    
    override func draw(_ rect: CGRect) {
        customInitialiser()
       
    }
    // //-------------------------------------
    // MARK:- INdicator View/Line Methods
    //-------------------------------------
    var leadingConstraint : NSLayoutConstraint?
    var widthConstraint : NSLayoutConstraint?
  
    private func scrollIndicatorView(offset: CGPoint){
        widthConstraint?.isActive = false
        leadingConstraint?.isActive = false
       
        if isSizeToFitCellNeeded {
            cellWidth = frame.width / floatCount
        }
        let xOffset = offset.x - (cellWidth / 2)
        
        UIView.animate(withDuration: 0.4) {
            self.widthConstraint = NSLayoutConstraint(item: self.indicatorView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: self.cellWidth)
            self.widthConstraint!.isActive = true
            self.leadingConstraint = NSLayoutConstraint(item: self.indicatorView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: xOffset)
            self.leadingConstraint!.isActive = true
            self.layoutIfNeeded()
        }
        
    }
    private func indicatorViewSetup() {
        
       guard  isIndicatorLineVisible,isHeaderVisible, !headerCollectionView.contains(indicatorView) else { return }
        headerCollectionView.addSubview(indicatorView)
        indicatorView.backgroundColor = indicatorColor
        if isSizeToFitCellNeeded {
            cellWidth = frame.width / floatCount
        }

        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false
        leadingConstraint = NSLayoutConstraint(item: indicatorView, attribute: .leading, relatedBy: .equal, toItem: headerCollectionView, attribute: .leading, multiplier: 1, constant: cellInset?.left ?? 10)
        widthConstraint = NSLayoutConstraint(item: indicatorView, attribute: .width, relatedBy: .equal, toItem: headerCollectionView, attribute: .width, multiplier: 0, constant: self.cellWidth)
        let heightConstraint = NSLayoutConstraint(item: indicatorView, attribute: .height, relatedBy: .equal, toItem: headerCollectionView, attribute: .height, multiplier: 0, constant: indicatorHeight)
        let bottomConstraint = NSLayoutConstraint(item: indicatorView, attribute: .top, relatedBy: .equal, toItem: headerCollectionView, attribute: .top, multiplier: 1, constant: headerHeight - indicatorHeight)
        
        widthConstraint!.isActive = true
        heightConstraint.isActive = true
        leadingConstraint!.isActive = true
        bottomConstraint.isActive = true
    }
    private func headerCollectionSetup() {
        guard isHeaderVisible else { return }
        
        headerCollectionView.register(TitleHeaderCollectionViewCell.self, forCellWithReuseIdentifier: TitleHeaderCollectionViewCell.identifier)
        addSubview(headerCollectionView)
       
        self.headerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: headerCollectionView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: headerCollectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: headerCollectionView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: headerHeight)
        let topConstraint = NSLayoutConstraint(item: headerCollectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
       
        
        trailingConstraint.isActive = true
        topConstraint.isActive = true
        heightConstraint.isActive = true
        leadingConstraint.isActive = true
        
        
        
    }
    private func addHeaderShadow(){
        guard isHeaderShadowEnabled, isHeaderVisible else { return }
        headerCollectionView.layer.shadowColor = UIColor.gray.cgColor
        headerCollectionView.layer.shadowOpacity = 0.8
        headerCollectionView.layer.shadowRadius = 10
        headerCollectionView.layer.shadowOffset = CGSize(width: 0, height: 3)
        headerCollectionView.clipsToBounds = false
    }
    private func pageCollectionSetup() {
        if !isHeaderVisible { headerHeight = 0 }
        addSubview(tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: headerHeight)
        
        
        trailingConstraint.isActive = true
        topConstraint.isActive = true
        heightConstraint.isActive = true
        leadingConstraint.isActive = true
    }
    
}

// //-------------------------------------
// MARK:- Collection View Methods
//-------------------------------------

extension HeaderTableViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    private func customInitialiser(){
      backgroundColor = pageBgColor
        pageCollectionSetup()
        headerCollectionSetup()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isHeaderVisible ? titles.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleHeaderCollectionViewCell.identifier, for: indexPath) as! TitleHeaderCollectionViewCell
        if indexPath  == self.indexPath {
            cell.setTitle(title: titles[indexPath.item].localized,
                          textColor : ThemeYellowColor,
                          font: textFont)
        } else {
            cell.setTitle(title: titles[indexPath.item].localized,
                          textColor : UIColor.lightGray,
                          font: textFont)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            guard !isSizeToFitCellNeeded else {
                cellWidth = bounds.width / floatCount - spacing
                return CGSize(width: cellWidth, height: headerHeight)
                
            }
            cellWidth = widthOfString(usingFont: textFont, string: titles[indexPath.item]) + 10
            return CGSize(width: cellWidth, height: headerHeight)
      
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == headerCollectionView else{
            return
        }
        self.indexPath = indexPath
        scrollToIndexPath(indexPath: indexPath)
        if didSelectItemAt != nil {  didSelectItemAt!((previousIndexPath, indexPath ))
        }
        collectionView.reloadData()
     }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return UIEdgeInsets()}
        guard !isSizeToFitCellNeeded else {return flowLayout.sectionInset }
        return centerHorizontalCollection(collectionViewLayout: collectionViewLayout, insetForSectionAt: section)
    }
   
    
    private func centerHorizontalCollection(collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int)  -> UIEdgeInsets{
      
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
            let dataSourceCount = headerCollectionView.dataSource?.collectionView(headerCollectionView, numberOfItemsInSection: section),
            dataSourceCount > 0 else {
                return .zero
        }
        cellWidth = titles.first != nil ? widthOfString(usingFont: textFont, string: titles[0]) + 10 : 50
       
        var insets = flowLayout.sectionInset
        var totalCellWidth: CGFloat = 0
        for index in titles.indices{
            totalCellWidth += widthOfString(usingFont: textFont, string: titles[index]) + 10 + spacing
        }
        
        let contentWidth = headerCollectionView.frame.size.width - headerCollectionView.contentInset.left - headerCollectionView.contentInset.right
        
        cellWidth = widthOfString(usingFont: textFont, string: titles[indexPath.item]) + 10
        headerCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        guard totalCellWidth < contentWidth else {
            cellInset = UIEdgeInsets(top: insets.top, left: 10, bottom: insets.bottom, right: insets.right)
            return cellInset!
        }
        // Calculate the right amount of padding to center the cells.
        let padding = (contentWidth - totalCellWidth + (spacing / 2)) / 2.0
        insets.left = padding
        insets.right = padding
        cellInset = insets
        return insets
    }
   
    
    func widthOfString(usingFont font: UIFont, string: String) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = string.size(withAttributes: fontAttributes)
        return size.width
    }
}

