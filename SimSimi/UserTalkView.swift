//
//  UserTalkView.swift
//  SimSimi
//
//  Created by user on 2023/02/08.
//

import UIKit

class UserTalkView: UIView {
    
    var message: String?

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
        messageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
        let messageLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = message
            return lbl
        }()
        
        messageView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
