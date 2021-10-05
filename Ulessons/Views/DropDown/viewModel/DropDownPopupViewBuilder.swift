//
//  DropDownPopupViewBuilder.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit

final class DropDownPopupViewBuilder {

    private unowned let controller: DropDownPopupViewController
    private var view: UIView! { return controller.view }
    private var menuTopConstant: CGFloat!

    init(controller: DropDownPopupViewController, menuTopConstant: CGFloat) {
        self.controller = controller
        self.menuTopConstant = menuTopConstant
    }

    func setupViews() {
        setupProperties()
        setupHierarchy()
        setupAutoLayout()
    }
}

// MARK: - Private methods
extension DropDownPopupViewBuilder {

    private func setupProperties() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.manualLayoutable()
        controller.scrollView.clipsToBounds = true
    }

    private func setupHierarchy() {
        controller.apply {
            view.addSubview($0.mainContentView)
            $0.mainContentView.addSubviews([$0.topContainer, $0.scrollView])
            $0.topContainer.addSubview($0.titleStack)
            $0.titleStack.addArrangedSubviews([$0.iconImage, $0.titleLabel])
            $0.scrollView.addSubview($0.contentView)
            $0.contentView.addSubview($0.contentStackView)
        }
    }

    private func setupAutoLayout() {
        controller.apply {
            
            $0.contentStackView.edgesToParent()
            $0.contentView.edgesToParent()
            $0.contentView.widthAnchor.equal(to: $0.scrollView.widthAnchor)

            $0.topContainer.widthAnchor.equal(to: $0.scrollView.widthAnchor)
            $0.topContainer.heightAnchor.equalTo(constant: 70)

            $0.titleStack.centerXAnchor.equal(to: $0.topContainer.centerXAnchor)
            $0.titleStack.centerYAnchor.equal(to: $0.topContainer.centerYAnchor)
            
            $0.scrollView.edgesToParent(anchors: [.leading, .trailing, .bottom])
            $0.topContainer.edgesToParent(anchors: [.leading, .trailing, .top])

            $0.scrollView.topAnchor.equal(to: $0.topContainer.bottomAnchor)
            
            let margin: CGFloat = 40
            $0.mainContentView.leadingAnchor.greaterThanOrEqual(to: view.leadingAnchor, constant: 8)
            $0.mainContentView.trailingAnchor.lessThanOrEqual(to: view.trailingAnchor, constant: margin)
            $0.mainContentView.topAnchor.greaterThanOrEqual(to: view.safeAreaLayoutGuide.topAnchor, constant: menuTopConstant)
            $0.mainContentView.bottomAnchor.lessThanOrEqual(to: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin)
            $0.mainContentView.centerXAnchor.equal(to: view.centerXAnchor)
            $0.mainContentView.centerYAnchor.equal(to: view.centerYAnchor)

            $0.mainContentView.widthAnchor.equalTo(constant: 260, withPriority: .defaultHigh)
        }

    }

    func setupScrollHeightConstraint() -> NSLayoutConstraint {
        return controller.scrollView.heightAnchor.equalTo(constant: 5, withPriority: .defaultLow)
    }

}

// MARK: - Public build methods
extension DropDownPopupViewBuilder {

    func buildView() -> UIView {
        return UIView().manualLayoutable()
    }

    func buildScrollView() -> UIScrollView {
        return UIScrollView().manualLayoutable().apply {
            $0.backgroundColor = .white
            $0.addShadow()
        }
    }

    func buildSingleButton() -> DropDownSelectableButton {
        return DropDownSelectableButton()
    }
    
    func buildContentView() -> UIView {
        return UIView().manualLayoutable().apply {
            $0.backgroundColor = .white
        }
    }
    
    func buildTopContainer() -> UIView {
        return UIView().manualLayoutable()
    }
    
    func buildTitleStack() -> UIStackView {
        return UIStackView().manualLayoutable().apply {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = Constants.Margin.tiny
        }
    }
    
    func buildIconImage() -> UIImageView {
        return UIImageView().manualLayoutable().apply {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .appTextBright
            $0.clipsToBounds = true
        }
    }
    
    func buildTitleLabel() -> LessonsLabel {
        return LessonsLabel.styled(withTextColor: .appTextMediumBright, withFont: UIFont.custom(ofSize: Constants.FontSize.subbody, font: UIFont.Roboto.medium), alignment: .center, numberOfLines: 1)
    }

    func buildContentStackView() -> UIStackView {
        let stackView = UIStackView(
            axis: .vertical,
            with: [],
            spacing: 0
        )

        return stackView
    }
    
    func buildAddBottomButton(title: String) -> UIButton {
        return UIButton().manualLayoutable().apply {
            $0.applyTouchAnimation()
            $0.setTitleColor(.appTextMediumBright, for: .normal)
            $0.titleLabel?.font = UIFont.custom(ofSize: Constants.FontSize.tiny, font: UIFont.Roboto.regular)
            $0.contentHorizontalAlignment = .center
            $0.contentVerticalAlignment = .center
            $0.setTitle(title, for: .normal)
            $0.heightAnchor.equalTo(constant: 60)
        }
    }
}
