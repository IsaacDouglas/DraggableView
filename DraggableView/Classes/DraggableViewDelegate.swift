//
//  DraggableViewDelegate.swift
//  DraggableView
//
//  Created by Isaac Douglas on 19/12/19.
//

import Foundation

public protocol DraggableViewDelegate {
    func draggableView(_ draggableView: DraggableViewController, draggableViewStateChange: DraggableViewState)
    func draggableView(_ draggableView: DraggableViewController, draggableViewDragState: DraggableViewState)
    func draggableView(_ draggableView: DraggableViewController, draggableViewPercentage: CGFloat)
    func draggableView(_ draggableView: DraggableViewController, draggableViewDragMax: Bool)
}

public extension DraggableViewDelegate {
    func draggableView(_ draggableView: DraggableViewController, draggableViewStateChange: DraggableViewState) {}
    func draggableView(_ draggableView: DraggableViewController, draggableViewDragState: DraggableViewState) {}
    func draggableView(_ draggableView: DraggableViewController, draggableViewPercentage: CGFloat) {}
    func draggableView(_ draggableView: DraggableViewController, draggableViewDragMax: Bool) {}
}
