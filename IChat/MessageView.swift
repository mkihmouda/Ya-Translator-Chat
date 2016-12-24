//
//  SpeachPostView.swift
//  YaTranslator
//
//  Created by Mac on 12/1/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class MessageView: UIView {

    // enum Sender or Receiver
    
    enum sendingType {
        
        case sender
        case receiver
    }
    
    
    @IBOutlet var postTextView: UITextView!
    @IBOutlet var ballonImageView: UIImageView!
    
    var senderType : sendingType?
 

// MARK: updateMessgeView according to text content
    
    
        func updateTextViewFrame(){
     
            let contentSize = self.postTextView.sizeThatFits(self.postTextView.bounds.size)
            
            if (senderType == sendingType.sender){
                
                // right alignment

                self.frame =  CGRect(x: 0, y: 10 , width: screenWidth - 10 , height: contentSize.height + 20)
                self.postTextView.frame =  CGRect(x: 50, y: 10 , width: self.frame.size.width - 60 , height: contentSize.height)
                self.ballonImageView.frame = CGRect(x: 40, y: 0 , width: self.frame.size.width - 50, height: contentSize.height + 20)
            
                
            }else{
            
                // left alignment

                self.frame =  CGRect(x: 0 , y: 100 , width: screenWidth - 10 , height: contentSize.height + 20)
                self.postTextView.frame =  CGRect(x: 20, y: 10 , width: self.frame.size.width - 60 , height: contentSize.height)
                self.ballonImageView.frame = CGRect(x: 10, y: 0 , width: self.frame.size.width - 40 , height: contentSize.height + 20)

 
            }

            
             self.addMessageBallon() // add message image ballon
             self.addAvatar()
        }
    
  
    func addMessageBallon(){
        
        if let senderOrReceiver = senderType {
        
            let ballonImage = UIImage.init(named: "\(senderOrReceiver).png")?.stretchableImage(withLeftCapWidth: 24, topCapHeight: 15)
            self.ballonImageView.image = ballonImage
        
        }
    }
    
    
    
    func addAvatar(){
        
        if let senderOrReceiver = senderType {
            
            let image =  UIImage.init(named: "\(senderOrReceiver)_profile")
            let imageView = UIImageView.init(image: image)
            
        
        if (senderType == sendingType.sender){
            
            imageView.frame = CGRect(x: 10, y: self.frame.size.height - 30 , width: 30 , height: 30)
            
        }else{
            
            imageView.frame = CGRect(x: self.frame.size.width - 30 , y: self.frame.size.height - 30 , width: 30 , height: 30)
            
        }
        
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        self.clipsToBounds = true
        self.addSubview(imageView)
            
        }
    }
    
}
