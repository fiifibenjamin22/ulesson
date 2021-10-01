//
//  TableIndicatorViewBuilder.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

final class TableIndicatorViewBuilder {

    private unowned let view: TableIndicatorView

    init(view: TableIndicatorView) {
        self.view = view
    }

    func setupViews() {
        setupProperties()
        setupHierarchy()
        setupAutoLayout()
    }
    
}

// MARK: - Private methods
extension TableIndicatorViewBuilder {

    private func setupProperties() {
        view.activityIndicator.tintColor = .appPrimary
    }

    private func setupHierarchy() {
        view.addSubview(view.indicatorContainer)
        view.indicatorContainer.addSubview(view.activityIndicator)
    }

    private func setupAutoLayout() {
        view.apply {
            $0.activityIndicator.centerXAnchor.equal(to: $0.indicatorContainer.centerXAnchor)
            $0.activityIndicator.leadingAnchor.greaterThanOrEqual(to: $0.indicatorContainer.leadingAnchor)
            $0.activityIndicator.trailingAnchor.lessThanOrEqual(to: $0.indicatorContainer.trailingAnchor)
            $0.activityIndicator.edgesToParent(anchors: [.top, .bottom], insets: UIEdgeInsets(padding: Constants.Margin.standard))
            
            $0.indicatorContainer.edgesToParent(anchors: [.leading, .trailing, .top])
        }
    }

}

// MARK: - Public build methods
extension TableIndicatorViewBuilder {

    func buildView() -> UIView {
        return UIView().manualLayoutable()
    }
    
    func buildIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.manualLayoutable()
        indicator.tintColor = .appGrey
        indicator.startAnimating()
        
        return indicator
    }

}
