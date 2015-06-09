//
//  D3ImageVIew.swift
//  D3View
//
//  Created by mozhenhau on 15/5/15.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation
import UIKit


public class D3ImageView:UIImageView{
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound{
                initStyle(ViewStyle.Round)
            }
        }
    }
    
    
    @IBInspectable var isCorner: Bool = false {
        didSet {
            if isRound{
                initStyle(ViewStyle.Conrer)
                if cornerRadius != 0{
                    self.layer.cornerRadius = cornerRadius
                }
            }
        }
    }
}