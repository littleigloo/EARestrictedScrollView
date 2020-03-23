//
//  EARestrictedScrollView.swift
//
//  Copyright (c) 2015-2019 Evgeny Aleksandrov. License: MIT.

import UIKit

// ...........

open class EARestrictedScrollView: UIScrollView {
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    /// Container to hold all subviews of scrollview.
    lazy private var containerView: UIView = self.createContainerView()
    
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    /// Affects `restrictionArea.size` and `containerView.frame.size` when set.
    override open var contentSize: CGSize {
        get {
            return super.contentSize
        }
        set(newContentSize) {
            containerView.frame = CGRect(origin: containerView.frame.origin, size: newContentSize)
            restrictionArea = CGRect(origin: restrictionArea.origin, size: newContentSize)
        }
    }
    
    /// Recalculated `contentOffset` in coordinate space of `containerView`.
    open var alignedOffset: CGPoint {
        get {
            let originalOffset = super.contentOffset
            let newOffset = CGPoint(x: originalOffset.x + restrictionArea.origin.x, y: originalOffset.y + restrictionArea.origin.y)
            
            return newOffset
        }
        set(newContentOffset) {
            let newOffset = CGPoint(x: newContentOffset.x - restrictionArea.origin.x, y: newContentOffset.y - restrictionArea.origin.y)
            
            super.contentOffset = newOffset
        }
    }
    
    /// Defines restriction area in coordinate space of `containerView`. Use CGRectZero to reset restriction.
    open var restrictionArea: CGRect = CGRect.zero {
        didSet {
            if restrictionArea == CGRect.zero {
                super.contentOffset = CGPoint(x: super.contentOffset.x - containerView.frame.origin.x, y: super.contentOffset.y - containerView.frame.origin.y)
                containerView.frame = CGRect(origin: CGPoint.zero, size: containerView.frame.size)
                super.contentSize = containerView.frame.size
            } else {
                containerView.frame = CGRect(origin: CGPoint(x: -restrictionArea.origin.x, y: -restrictionArea.origin.y), size: containerView.frame.size)
                super.contentOffset = CGPoint(x: super.contentOffset.x - restrictionArea.origin.x, y: super.contentOffset.y - restrictionArea.origin.y)
                super.contentSize = restrictionArea.size
            }
        }
    }
    
    /// Leads to `containerView.subviews` - all subviews except scroll indicators are stored there.
    open var containedSubviews: [UIView] {
        return containerView.subviews
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    // MARK: - Subviews functions override
    
    override open func addSubview(_ view: UIView) {
        if subviews.count < 3 && isItScrollIndicator(view) {
            super.addSubview(view)
        } else {
            containerView.addSubview(view)
        }
    }
    
    // ...........
    
    override open func insertSubview(_ view: UIView, aboveSubview siblingSubview: UIView) {
        containerView.insertSubview(view, aboveSubview: siblingSubview)
    }
    
    // ...........
    
    override open func insertSubview(_ view: UIView, at index: Int) {
        containerView.insertSubview(view, at: index)
    }
    
    // ...........
    
    override open func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView) {
        containerView.insertSubview(view, belowSubview: siblingSubview)
    }
    
    // ...........
    
    override open func bringSubviewToFront(_ view: UIView) {
        if view.superview == self {
            super.bringSubviewToFront(view)
        } else {
            containerView.bringSubviewToFront(view)
        }
    }
    
    // ...........
    
    override open func sendSubviewToBack(_ view: UIView) {
        if view.superview == self {
            super.sendSubviewToBack(view)
        } else {
            containerView.sendSubviewToBack(view)
        }
    }
    
    //  MARK: - METHODS 🔰 PRIVATE
    // ///////////////////////////////////////////
    /// Helper func, since direct use of `super` call in `lazy` causes compile error.
    private func createContainerView() -> UIView {
        let view = UIView()
        super.addSubview(view)
        return view
    }
    
    /// Checks if a view is a scroll indicator of `UIScrollView`.
    private func isItScrollIndicator(_ view: UIView) -> Bool {
        return ((showsHorizontalScrollIndicator && view.frame.height == 2.5) || (showsVerticalScrollIndicator && view.frame.width == 2.5)) && view is UIImageView
    }
}
