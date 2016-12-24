//
//  MainView.swift
//  IChat
//
//  Created by Mac on 12/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class MainView: UIView {

    var chatView : ChatView!

   
    func loadViews(){
       
        
        chatView = Bundle.main.loadNibNamed("ChatView", owner: nil, options: nil)![0] as! ChatView
        chatView.frame.origin =  CGPoint(x: 25,y : screenHeight - 70)
        chatView.frame.size = CGSize(width: screenWidth - 50 , height: 70)
        self.addSubview(chatView)

    }
}
