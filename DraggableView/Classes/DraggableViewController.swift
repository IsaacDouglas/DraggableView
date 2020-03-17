//
//  DraggableViewController.swift
//  DraggableView
//
//  Created by Isaac Douglas on 17/12/19.
//

import UIKit

open class DraggableViewController: UIViewController, DraggableViewDataSource {
    
    private var viewAlpha: UIView?
    private var originOffset: CGFloat = 0
    private var viewController: UIViewController?
    
    public var dataSource: DraggableViewDataSource?
    public var delegate: DraggableViewDelegate?
    
    var state: DraggableViewState = .down {
        didSet { self.stateDidChange() }
    }
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognizerAction(_:)))
        self.view.addGestureRecognizer(self.panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureRecognizerAction(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        self.view.backgroundColor = .cyan
        self.view.frame = UIScreen.main.bounds
        
        self.dataSource = self
    }
    
    @objc private func tapGestureRecognizerAction(_ gesture: UITapGestureRecognizer) {
        guard self.state == .down else { return }
        self.state = self.dataSource!.tapState()
    }
    
    @objc private func panGestureRecognizerAction(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        let position = self.originOffset + translation.y
        
        if let superView = self.view.superview {
            
            let frame = self.view.frame
            let height = frame.size.height
            let pointYmax = (1 - self.dataSource!.maxTopDragOffsetPercentage()) * height
            let update = position >= pointYmax
            self.delegate?.draggableView(self, draggableViewDragMax: !update)
            
            if update {
                self.view.frame.origin.y = position
                self.updateAlpha(position: position)
                self.delegate?.draggableView(self, draggableViewPercentage: (1 - (position / height)))
            }
            
            let point = superView.convert(frame, to: self.view.superview)
            let pointY = (1 - self.dataSource!.halfwayOffsetPercentage()) * height
            
            var changeState: DraggableViewState!
            if point.origin.y >= pointY + self.dataSource!.offsetMediumMagnetic() {
                changeState = .down
            } else if point.origin.y <= pointY - self.dataSource!.offsetMediumMagnetic() {
                changeState = .top
            } else {
                changeState = .halfway
            }
            
            if gesture.state == .ended {
                self.state = changeState
            }else if gesture.state == .changed {
                self.delegate?.draggableView(self, draggableViewDragState: changeState)
            }else if gesture.state == .cancelled || gesture.state == .failed {
                self.state = .down
            }
        }
    }
    
    private func stateDidChange() {
        
        var point: CGFloat
        let height: CGFloat = self.view.frame.size.height
        
        switch self.state {
        case .hide:
            point = height
        case .down:
            point = (1 - self.dataSource!.downOffsetPercentage()) * height
        case .halfway:
            point = (1 - self.dataSource!.halfwayOffsetPercentage()) * height
        case .top:
            point = (1 - self.dataSource!.topOffsetPercentage()) * height
        }
        
        self.originOffset = point
        self.panGestureRecognizer.isEnabled = false
        self.panGestureRecognizer.isEnabled = true
        self.delegate?.draggableView(self, draggableViewPercentage: self.percentage(point))
        self.delegate?.draggableView(self, draggableViewStateChange: self.state)
        
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = point
            self.updateAlpha(position: point)
        }
    }
    
    private func updateAlpha(position: CGFloat){
        if self.dataSource!.shadow() {
            self.viewAlpha?.alpha = self.percentage(position)
        }else{
            self.viewAlpha?.alpha = 0
        }
    }
    
    private func percentage(_ position: CGFloat) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        return 1 - (position / (screenSize.height))
    }
    
    public func addMasterViewController(_ viewController: UIViewController) {
        self.viewController = viewController
        viewController.addChildViewController(self)
        
        let viewAlpha = UIView(frame: self.view.frame)
        viewAlpha.backgroundColor = .darkGray
        viewAlpha.isUserInteractionEnabled = false
        viewAlpha.alpha = 0
        
        self.viewAlpha = viewAlpha
        
        let height = self.view.frame.size.height
        self.view.frame.origin.y = height
        self.state = .down
        
        self.viewController?.view.addSubview(viewAlpha)
        self.viewController?.view.addSubview(self.view)
    }

}
