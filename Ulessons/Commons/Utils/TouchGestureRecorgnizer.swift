//
//  TouchGestureRecorgnizer.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit.UIGestureRecognizerSubclass

final class TouchGestureRecognizer: UIPanGestureRecognizer {
    private var beginAction: ((UITouch?) -> Void)?
    private var endAction: (() -> Void)?
    private var shouldEndActionOccurWhenMoved: Bool = true
    private var handler = TouchGestureHandler()
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        setup()
    }
    
    private func setup() {
        delegate = handler
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        beginAction?(touches.first)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if shouldEndActionOccurWhenMoved, touches.filter({ self.view?.bounds.contains($0.location(in: self.view)) == false }).first != nil {
            endAction?()
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        endAction?()
        super.touchesEnded(touches, with: event)
    }
    
    func addAction(beginAction: @escaping(UITouch?) -> Void, endAction: @escaping() -> Void, shouldEndActionOccurWhenMoved: Bool = true) {
        self.shouldEndActionOccurWhenMoved = shouldEndActionOccurWhenMoved
        self.beginAction = beginAction
        self.endAction = endAction
        self.cancelsTouchesInView = false
    }
    
}

class TouchGestureHandler: NSObject, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
