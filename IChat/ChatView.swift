//
//  ChatView.swift
//  IChat
//
//  Created by Mac on 12/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import AVFoundation

class ChatView: UIView, UITextViewDelegate  {
    
    @IBOutlet var textView: UITextView! // chat text view
    @IBOutlet var roundedView: RoundedUIView! // rounded view
   

    var resetFlag : Bool = false // reset falg
    var mainVC : MainVC! // parent VC
    
    var offsetHeight : CGFloat = 0.0 // offset height
    var keyboardHeigh : CGFloat = 0.0 // keyboard height
    
    var btnSound : AVAudioPlayer?

    
    
    override func awakeFromNib() {
   
        // get root VC
        
        self.getRootViewController()
        
        // Keyboard show and hide notifications
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatView.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatView.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        self.textView.delegate = self
       
    }
    
    
// MARK: Tap end editing
    
    override func layoutSubviews() {
        
        // Tap endEditing
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        self.mainVC.scrollView.addGestureRecognizer(tapGesture)
 
    }
    
 
    
    
    func tapAction(_ sender: UITapGestureRecognizer) {
      
        self.textView.endEditing(true)
        mainVC.listScrollModel.updateScrollWithHiddenKeyboard(keyboardHeigh: keyboardHeigh)  // reset scroll view frame size
        endEditing()
        
    }
    
    

// MARK: Root View Controller
    
    func getRootViewController(){
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        mainVC = appDelegate.window?.rootViewController as! MainVC!
        
    }
    

// MARK: Keyboard shown and hidden methods
    
    
    
    func keyboardWillShow(notification: Notification) {
     
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            keyboardHeigh = keyboardSize.height
            
            UIView.animate(withDuration: 1.5 , delay: 0.0, options: [.curveEaseOut], animations: {
                
                self.frame.origin.y =  screenHeight - self.keyboardHeigh - self.frame.size.height // show textview upper keyboard
                
            }, completion: nil)
            
            
            mainVC.listScrollModel.updateScrollWithShownKeyboard(keyboardHeigh: keyboardHeigh) // update scroll view according to keyboard size
            
        }
        
    }
    
    
    func keyboardWillHide(notification: Notification) {
        
        mainVC.listScrollModel.updateScrollWithHiddenKeyboard(keyboardHeigh: keyboardHeigh)  // reset scroll view frame size
        endEditing()
        
    }
    
    
    
    
// MARK: handle text typing
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" { // return keytapped
            
            self.textView.endEditing(true)

            return false
        }
        
        updateTextViewFrame()
        return true
    }
    
    
// MARK: update TextView and frames size
    
    func updateTextViewFrame(){
        
        let contentSize = self.textView.sizeThatFits(self.textView.bounds.size) // fit textview size according to content
        
        if (contentSize.height != offsetHeight || resetFlag){ // update only if new line or in reset state
            
            offsetHeight = contentSize.height
            
            // update frames height values
            
            self.frame.size.height =  contentSize.height + roundedPadding * 2 + chatTextViewPadding * 2
            self.roundedView.frame.size.height =  contentSize.height + roundedPadding * 2 + chatTextViewPadding * 2
            
            self.textView.frame.size.height =  contentSize.height
            self.textView.contentSize.height =  contentSize.height
                        
            UIView.animate(withDuration: 0.5 , delay: 0.0, options: [.curveEaseOut], animations: {
                
                self.frame.origin.y =  screenHeight - self.keyboardHeigh - self.frame.size.height // animate TextView to top
                self.resetFlag = false

            }, completion: nil)
        }
    }
   
    

// MARK: send message button action

    
    @IBAction func sendMessage(_ sender: Any) {
        
        playSiriSound(fileName: "message")

        let messageView = Bundle.main.loadNibNamed("MessageView", owner: nil, options: nil)![0] as! MessageView
        messageView.postTextView.text = textView.text
        messageView.senderType = messageDirection()
        messageView.updateTextViewFrame()
        mainVC.listScrollModel.addMessage(view: messageView, keyboardHeigh: keyboardHeigh)
        
        postSendMessage() // post submit chat process
    }

    
    func postSendMessage(){
    
        textView.text = "" // clear textView
        updateTextViewFrame()
    }
    
    
    
// MARK: end edting process
    
    func endEditing(){

        self.keyboardHeigh  = 0.0
        self.textView.text = ""
        
        resetFlag = true
        updateTextViewFrame()
  
    }
    
// MARK: message number
    
    
    func messageDirection() -> MessageView.sendingType{
    
        let views = mainVC.scrollView.subviews.count
        
        
        if  (views - 2) % 2 == 1{
        
 
            return MessageView.sendingType.sender
        
        }
        
        return MessageView.sendingType.receiver
 
    }
    
    
    
//    MARK: SoundPlayer Functions
    
    func  playSiriSound( fileName : String){
        
        let soundClass = SoundPlayer.init(trackName: fileName)
        btnSound = soundClass.btnSound
        playSound()
     
    }
    
    func playSound(){
        
        if (btnSound!.isPlaying){
            
            btnSound!.stop()
            
        }else{
            
            btnSound!.play()
            
        }
        
    }
    
}
