//
//  DropDownPopupViewController.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import Foundation
import UIKit
//import RxSwift

final class DropDownPopupViewController: AppViewController {
    
    // MARK: - Views
    private(set) var mainContentView: UIView!
    private(set) var topContainer: UIView!
    private(set) var iconImage: UIImageView!
    private(set) var titleLabel: LessonsLabel!
    private(set) var titleStack: UIStackView!
    private(set) var scrollView: UIScrollView!
    private(set) var contentView: UIView!
    private(set) var contentStackView: UIStackView!
    
    private(set) var scrollHeightConstraint: NSLayoutConstraint!
    
    private var data: DropDownData
    private var selectedOption: DropDownOption
    private var contentSizeObserver: NSKeyValueObservation?
    
    var menuTopConstant: CGFloat!

    // MARK: - Initialization
    init(with data: DropDownData, selectedOption: DropDownOption, menuTopConstant: CGFloat) {
        self.data = data
        self.selectedOption = selectedOption
        self.menuTopConstant = menuTopConstant
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var buttons: [DropDownSelectableButton] {
        return contentStackView.arrangedSubviews.compactMap { $0 as? DropDownSelectableButton }
    }
    
    var selectionCallback: (Int) -> Void = { _ in }
    var addBottomButtonCallback: () -> Void = {}

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresentationLogic()
        titleLabel.text = data.popupTitle.uppercased()
        iconImage.image = data.icon
        add(options: data.options, to: contentStackView, withAddButtonTitle: data.popupAddBottomButtonTitle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainContentView.alpha = 0
        statusBar?.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainContentView.animateEntrance()
    }
}

// MARK: - Private methods
extension DropDownPopupViewController {

    private func setupViews() {
        let builder = DropDownPopupViewBuilder(controller: self, menuTopConstant: menuTopConstant)

        mainContentView = builder.buildContentView()
        topContainer = builder.buildTopContainer()
        titleStack = builder.buildTitleStack()
        iconImage = builder.buildIconImage()
        titleLabel = builder.buildTitleLabel()
        scrollView = builder.buildScrollView()
        contentStackView = builder.buildContentStackView()
        contentView = builder.buildView()
        
        builder.setupViews()
        scrollHeightConstraint = builder.setupScrollHeightConstraint()
    }

    private func setupPresentationLogic() {
        contentSizeObserver = scrollView.observe(\.contentSize) { [unowned self] (_, _) in
            self.scrollHeightConstraint.constant = self.scrollView.contentSize.height
        }
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseArea)))
    }

    private func add(options: [DropDownOption], to view: UIStackView, withAddButtonTitle: String?) {
        view.addDefaultSeperator()
        let builder = DropDownPopupViewBuilder(controller: self, menuTopConstant: menuTopConstant)
        options.forEach { option in
            let button = builder.buildSingleButton()
            button.configure(with: option)
            button.checkedIcon.isHidden = !(selectedOption.id == option.id)
            button.innerButton.addTarget(self, action: #selector(didTapOptionButton(_:)), for: .touchUpInside)
            view.addArrangedSubview(button)
            view.addDefaultSeperator()
        }
        guard let addButtonTitle = withAddButtonTitle else { return }
        let addButton = builder.buildAddBottomButton(title: addButtonTitle)
        addButton.addTarget(self, action: #selector(didTabAddBottomButton), for: .touchUpInside)
        view.addArrangedSubview(addButton)
        view.addDefaultSeperator()
    }
    
    private func animateDismiss(withCallback callback: @escaping () -> Void = {}) {
        view.isUserInteractionEnabled = false
        mainContentView.animateDismiss { [weak self] in
            callback()
            self?.dismiss(animated: true)
        }
    }
    
    @objc private func didTapOptionButton(_ button: LeftIconButton) {
        if let selectedIndex = buttons.firstIndex(where: { $0.innerButton == button }) {
            animateDismiss(withCallback: { [unowned self] in self.selectionCallback(selectedIndex) })
        }
    }
    
    @objc private func didTapCloseArea() {
        animateDismiss()
    }
    
    @objc private func didTabAddBottomButton() {
        animateDismiss(withCallback: { [unowned self] in self.addBottomButtonCallback() })
    }
}
