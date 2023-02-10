//
//  ViewController.swift
//  SimSimi
//
//  Created by user on 2023/02/08.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var messageScrollView: UIScrollView!
    
    @IBOutlet weak var messageStackView: UIStackView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var messageSendBtn: UIButton!
    
    let chatManager = ChatManager.shared
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatManager.responseMessage
            .compactMap { $0 }
            .subscribe { message in
                self.makeMessageBox(isBotMessage: true, message: message)
                self.messageSendBtn.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
                self.messageSendBtn.isEnabled = true
            }
            .disposed(by: disposeBag)
    }
    
    func makeMessageBox(isBotMessage: Bool, message: String) {
        if message == "" { return }
        
        let newMessage = MessageView()
        
        newMessage.message = message
        newMessage.isBotMessage = isBotMessage
        newMessage.setUI()
        
        messageStackView.addArrangedSubview(newMessage)
        newMessage.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let bottomOffset = CGPoint(x: 0, y: messageScrollView.contentSize.height - messageScrollView.bounds.height + messageScrollView.contentInset.bottom + 70)
        
        messageScrollView.setContentOffset(bottomOffset, animated: false)
        
        messageTextField.text = nil
    }

    @IBAction func addMessageBtnTapped(_ sender: Any) {
        let message = messageTextField.text
        if message == "" { return }
        self.messageSendBtn.setImage(UIImage(systemName: "timelapse"), for: .normal)
        messageSendBtn.isEnabled = false
        
        chatManager.sendMessage(message: message!)
        makeMessageBox(isBotMessage: false, message: message!)
    }
}

