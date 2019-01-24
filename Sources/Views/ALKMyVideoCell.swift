//
//  ALKMyVideoCell.swift
//  ApplozicSwift
//
//  Created by Mukesh Thawani on 10/07/17.
//  Copyright © 2017 Applozic. All rights reserved.
//

import UIKit

class ALKMyVideoCell: ALKVideoCell {

    fileprivate var stateView: UIImageView = {
        let sv = UIImageView()
        sv.isUserInteractionEnabled = false
        sv.contentMode = .center
        return sv
    }()

    override func setupViews() {
        super.setupViews()

        let width = UIScreen.main.bounds.width

        contentView.addViewsForAutolayout(views: [stateView])

        photoView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 48).isActive = true
        photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14).isActive = true

        photoView.widthAnchor.constraint(equalToConstant: width*0.60).isActive = true

        if(ALKMessageStyle.receivedBubble.style == ALKMessageStyle.BubbleStyle.edge){
            photoViewBottom.constant = -6
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        }else{
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        }

        photoViewBottom.isActive = true
        
        bubbleView.backgroundColor = UIColor.hex8(Color.Background.grayF2.rawValue).withAlphaComponent(0.26)

        fileSizeLabel.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: 0).isActive = true

        stateView.widthAnchor.constraint(equalToConstant: 17.0).isActive = true
        stateView.heightAnchor.constraint(equalToConstant: 9.0).isActive = true
        stateView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -1.0).isActive = true
        stateView.trailingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: -2.0).isActive = true

        timeLabel.trailingAnchor.constraint(equalTo: stateView.leadingAnchor, constant: -2.0).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 2).isActive = true
    }

    override func update(viewModel: ALKMessageViewModel) {
        super.update(viewModel: viewModel)

        if(ALKMessageStyle.receivedBubble.style == ALKMessageStyle.BubbleStyle.round){
            if(!isHideProfilePicOrTimeLabel){
                photoViewBottom.constant = Padding.PhotoView.bottomUnClubedPadding
            }else{
                photoViewBottom.constant = Padding.PhotoView.bottomClubedPadding
            }
        }
        
        timeLabel.isHidden = isHideProfilePicOrTimeLabel
        if viewModel.isAllRead {
            stateView.image = UIImage(named: "read_state_3", in: Bundle.applozic, compatibleWith: nil)
            stateView.tintColor = UIColor(netHex: 0x0578FF)
        } else if viewModel.isAllReceived {
            stateView.image = UIImage(named: "read_state_2", in: Bundle.applozic, compatibleWith: nil)
            stateView.tintColor = nil
        } else if viewModel.isSent {
            stateView.image = UIImage(named: "read_state_1", in: Bundle.applozic, compatibleWith: nil)
            stateView.tintColor = nil
        } else {
            stateView.image = UIImage(named: "seen_state_0", in: Bundle.applozic, compatibleWith: nil)
            stateView.tintColor = UIColor.red
        }
    }

    override class func bottomPadding() -> CGFloat {
        return 6
    }
}
