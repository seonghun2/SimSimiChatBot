//
//  ViewController.swift
//  SimSimi
//
//  Created by user on 2023/02/08.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var messageScrollView: UIScrollView!
    
    @IBOutlet weak var messageStackView: UIStackView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    let chatManager = ChatManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageStackView.backgroundColor = .yellow
        
        //chatManager.sendMessage(message: "몇살이냐?")
    }

    @IBAction func addMessageBtnTapped(_ sender: Any) {
        let message = messageTextField.text
        if message == "" { return }
        
        let newMessage = UserTalkView()
        newMessage.message = message
        newMessage.setUI()
        
        newMessage.backgroundColor = .blue
        
        messageStackView.addArrangedSubview(newMessage)
        //messageStackView.insertArrangedSubview(<#T##view: UIView##UIView#>, at: <#T##Int#>)
        newMessage.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        let bottomOffset = CGPoint(x: 0, y: messageScrollView.contentSize.height - messageScrollView.bounds.height + messageScrollView.contentInset.bottom + 70)
        messageScrollView.setContentOffset(bottomOffset, animated: false)
        
        messageTextField.text = nil
    }
}

