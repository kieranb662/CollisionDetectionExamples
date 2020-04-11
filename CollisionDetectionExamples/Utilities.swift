//
//  Utilities.swift
//  CollisionDetectionExamples
//
//  Created by Kieran Brown on 4/11/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI

public struct Line: Shape {
    public var from: CGPoint
    public var to: CGPoint
    public init(from: CGPoint, to: CGPoint) {
        self.from = from
        self.to = to
    }
    public var animatableData: AnimatablePair<CGPoint, CGPoint> {
        get { AnimatablePair(from, to) }
        set {
            from = newValue.first
            to = newValue.second
        }
    }

    public func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)

        }
    }
}

/// Preference Key for merging values of sibling views into an array
struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:[Value]] { [:] }
    static func reduce(value: inout [Key:[Value]], nextValue: () -> [Key:[Value]]) {
        // if the next value shares Keys with the current value append the elements
        // of the next values array onto the the current value array.
        value.merge(nextValue()) { (current, new) in
            var temp = current
            temp.append(contentsOf: new)
            return temp
        }
    }
}

