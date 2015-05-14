//
//  D3ExpandTableView.swift
//  Neighborhood
//
//  Created by mozhenhau on 14/12/23.
//  Copyright (c) 2014年 Ray. All rights reserved.
//  设置实现D3ExpandDelegate代理，初始化initCate，获取数据后reloadData就可以了
//

import UIKit

protocol D3ExpandDelegate:UITableViewDelegate,UITableViewDataSource{
     func titleForHeaderInSection(section: Int)->NSString
     func titleForRowInSection(indexPath: NSIndexPath)->NSString
     func didSelectSection(section: Int)
}



class D3ExpandTableView: UITableView ,UITableViewDelegate,UITableViewDataSource{
    var expandSection:Array<Bool> = []     //展开状态
    var isExpandSection:Array<Bool> = []    //是否有展开状态(箭头)
    var d3Delegate:D3ExpandDelegate?
    var HEIGHT:CGFloat = 40
    var num:Int = 0      //一级分类数量
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.delegate = self
        self.dataSource = self
        separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    /**
    //初始化分类,要
    
    :param: num 一级分类数量
    
    */
    func initCate(num:Int){
        self.num = num
        //初始化展开状态数组
        for i:Int in 0..<num{
            expandSection.append(false)
        }
        
        //初始化是否有箭头
        for i:Int in 0..<num{
            isExpandSection.append(true)
        }
    }
    
    
    //MARK:一级标题数量
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if (d3Delegate?.respondsToSelector("numberOfSectionsInTableView:") != nil){
            return d3Delegate!.numberOfSectionsInTableView!(tableView)
        }
        return 0
    }
    
    //MARK: 二级分类数量
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var num:Int = 0
        if (d3Delegate?.respondsToSelector("tableView:numberOfRowsInSection:") != nil){
            num = d3Delegate!.tableView(tableView, numberOfRowsInSection: section)
        }
        
        if num == 0 && !isExpandSection.isEmpty{ //初始化是否有箭头
            isExpandSection[section] = false
        }
        
        if !expandSection.isEmpty && !expandSection[section]{  //不是展开的，rows设为0不显示
            num = 0
        }
        return num
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return HEIGHT
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return HEIGHT
    }
    
    //MARK: 一级标题内容
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view:UIView = UIView(frame: CGRectMake(0, 0, frame.size.width, 40))
        //line
        var line:UILabel = UILabel(frame: CGRectMake(0, view.frame.height - 0.5, frame.size.width, 0.5))
        line.backgroundColor = self.separatorColor
        view.addSubview(line)
        
        
        //headBtn - left
        var headBtn:UIButton = UIButton(frame: CGRectMake(0, 0, frame.size.width - 50, 40))
        headBtn.tag = section
        headBtn.addTarget(self, action: "tapHeader:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(headBtn)
        
        
        if !isExpandSection.isEmpty && isExpandSection[section]{
            //arrow btn  - right
            var imgBtn:UIButton = UIButton(frame: CGRectMake(frame.size.width - 50, 0, 50, 40))
            if numberOfRowsInSection(section) == 0{
                imgBtn.setImage(UIImage(named: "open.png"), forState: nil)
            }
            else{
                imgBtn.setImage(UIImage(named: "close.png"), forState: nil)
            }
            imgBtn.tag = section
            imgBtn.addTarget(self, action: "tapImg:", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(imgBtn)
        }
        
        
        //title
        var label:UILabel = UILabel(frame: CGRectMake(8, 10, 200, 20))
        view.addSubview(label)
        
        if (d3Delegate?.respondsToSelector("titleForHeaderInSection:") != nil){
            label.text = d3Delegate?.titleForHeaderInSection(section) as? String
        }
        return view
    }
    
    //MARK:二级标题内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        if (d3Delegate?.respondsToSelector("titleForRowInSection:") != nil){
            cell.textLabel?.text = d3Delegate?.titleForRowInSection(indexPath) as? String
        }
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        //line
        var line:UILabel = UILabel(frame: CGRectMake(0, cell.frame.height - 0.5, cell.frame.width, 0.5))
        line.backgroundColor = self.separatorColor
        cell.addSubview(line)
        return cell
    }
    
    //MARK: 点中标题
    func tapHeader(sender:UIButton){
        if d3Delegate?.respondsToSelector("didSelectSection:") != nil{
            d3Delegate?.didSelectSection(sender.tag)
        }
    }
    
    //MARK: 点中箭头
    func tapImg(sender:UIButton){
        expandSection[sender.tag] = !expandSection[sender.tag]
        if expandSection[sender.tag]{
            
        }
        reloadSections(NSIndexSet(index: sender.tag), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    //MARK: 选中row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (d3Delegate?.respondsToSelector("tableView:didSelectRowAtIndexPath:") != nil){
            d3Delegate?.tableView!(tableView, didSelectRowAtIndexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}