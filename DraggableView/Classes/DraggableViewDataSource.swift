//
//  DraggableViewDataSource.swift
//  DraggableView
//
//  Created by Isaac Douglas on 19/12/19.
//

import Foundation

public protocol DraggableViewDataSource {
    func downOffsetPercentage() -> CGFloat
    func halfwayOffsetPercentage() -> CGFloat
    func topOffsetPercentage() -> CGFloat
    func maxTopDragOffsetPercentage() -> CGFloat
    func offsetMediumMagnetic() -> CGFloat
    func tapState() -> DraggableViewState
    func shadow() -> Bool
}

public extension DraggableViewDataSource {
    func downOffsetPercentage() -> CGFloat {
        return 0.08
    }
    func halfwayOffsetPercentage() -> CGFloat {
        return 0.4
    }
    func topOffsetPercentage() -> CGFloat {
        return 0.9
    }
    func maxTopDragOffsetPercentage() -> CGFloat {
        return 0.95
    }
    func offsetMediumMagnetic() -> CGFloat {
        return 100
    }
    func tapState() -> DraggableViewState {
        return .halfway
    }
    func shadow() -> Bool {
        return true
    }
}
