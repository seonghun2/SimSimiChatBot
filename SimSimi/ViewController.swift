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
    
    @IBOutlet weak var userInputBottomConstraint: NSLayoutConstraint!
    
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
        
        //키보드 내려가기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        //키보드 올라오고 내려갈때 메세지뷰 제약조건 변경해주기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowEvent(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideEvent(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
        if message == "" {
            makeMessageBox(isBotMessage: false, message: "test")
            return
        }
        self.messageSendBtn.setImage(UIImage(systemName: "timelapse"), for: .normal)
        messageSendBtn.isEnabled = false
        
        chatManager.sendMessage(message: message!)
        makeMessageBox(isBotMessage: false, message: message!)
    }
    
    @objc func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillHideEvent(_ noti: Notification) {
        let animationOptionRawValue = noti.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt

        let animationDuration = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let animationOption = UIView.AnimationOptions(rawValue: animationOptionRawValue << 16)
        
        UIView.animate(withDuration: animationDuration, delay: 0,
                       options:  [animationOption],
                       animations: {
            self.userInputBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
        
    }
    
    @objc func keyboardWillShowEvent(_ noti: Notification) {
        let keyboardFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.height
        
        let animationOptionRawValue = noti.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
        let animationDuration = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let animationOption = UIView.AnimationOptions(rawValue: animationOptionRawValue << 16)
        
        UIView.animate(withDuration: animationDuration, delay: 0,
                       options:  [animationOption],
                       animations: {
            self.userInputBottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        })
    }
}

