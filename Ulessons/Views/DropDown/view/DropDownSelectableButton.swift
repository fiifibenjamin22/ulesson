//
//  DropDownSelectableButton.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit

class DropDownSelectableButton: UIView {

    lazy var innerButton: LeftIconButton = {
        return LeftIconButton().manualLayoutable().apply {
            $0.tintColor = .appText
            $0.setTitleColor(.appTextMediumBright, for: .normal)
            $0.titleLabel?.font = UIFont.custom(ofSize: Constants.FontSize.hintSize, font: UIFont.Roboto.regular)
        }
    }()
    
    lazy var checkedIcon: UIImageView = {
        return UIImageView(image: Icons.Common.dropdown).manualLayoutable().apply {
            $0.contentMode = .scaleAspectFit
        }
    }()
    
    init() {
        super.init(frame: .zero)
        self.heightAnchor.equalTo(constant: 60)
        addSubviews([innerButton, checkedIcon])
        innerButton.edgesToParent(anchors: [.leading, .top, .bottom])
        checkedIcon.apply {
            $0.heightAnchor.equalTo(constant: 15)
            $0.widthAnchor.equalTo(constant: 15)
            $0.centerYAnchor.equal(to: self.centerYAnchor)
            $0.trailingAnchor.equal(to: self.trailingAnchor, constant: -21)
            $0.leadingAnchor.equal(to: innerButton.trailingAnchor)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with option: DropDownOption) {
        innerButton.setTitle(option.title, for: .normal)
        innerButton.setImage(option.icon, for: .normal)
    }
    
}
