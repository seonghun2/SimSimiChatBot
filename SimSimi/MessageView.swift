//
//  UserTalkView.swift
//  SimSimi
//
//  Created by user on 2023/02/08.
//

import UIKit

class MessageView: UIView {
    
    var message: String?
    var isBotMessage: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        let messageView = UIView()
        addSubview(messageView)
        
        if isBotMessage! {
            backgroundColor = .systemGray5
            let botImage = UIImageView(image: UIImage(named: "botImage"))
            addSubview(botImage)
            botImage.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(10)
                make.top.bottom.equalToSuperview()
                make.height.equalTo(50)
            }
            messageView.snp.makeConstraints { make in
                make.left.equalTo(botImage.snp.right).offset(10)
                make.top.bottom.equalToSuperview()
            }
        } else {
            backgroundColor = .systemYellow
            messageView.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(10)
                make.top.bottom.equalToSuperview()
            }
        }
        
        let messageLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = message
            lbl.font = UIFont(name: "NanumGothicBold", size: 12)
            return lbl
        }()
        
        messageView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
