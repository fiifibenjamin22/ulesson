//
//  TableIndicatorView.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

final class TableIndicatorView: UITableViewHeaderFooterView {
    
    private(set) var activityIndicator: UIActivityIndicatorView!
    private(set) var indicatorContainer: UIView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let startPoint = self.frame.origin
        let contentSize = indicatorContainer.frame.size
        self.frame = .init(origin: startPoint, size: contentSize)
    }
}

// MARK: - Public methods
extension TableIndicatorView {

}

// MARK: - Private methods
extension TableIndicatorView {

    private func initialize() {
        autoresizingMask = .flexibleHeight
        setupViews()
    }

    private func setupViews() {
        let builder = TableIndicatorViewBuilder(view: self)

        activityIndicator = builder.buildIndicator()
        indicatorContainer = builder.buildView()
        
        builder.setupViews()
    }
}
