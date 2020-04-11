//
//  PrimitiveViews.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

// MARK: - Polygon
struct Polygon: Shape {
    var vertices: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        if vertices.count > 1 {
            return Path { path in
                path.move(to: self.vertices[0])
                for i in 1..<self.vertices.count {
                    path.addLine(to: self.vertices[i])
                }
                path.closeSubpath()
            }
        }
        return Path { p in }
    }
}

struct PolygonView: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    var idStart: Int
    var vertices: [CGPoint]
    @State var offset: CGSize = .zero
    @State var dragState: CGSize = .zero
    func draw(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        var verts: [CGPoint] = []
        for i in idStart..<idStart+vertices.count {
            verts.append(proxy[centers[i]!.first!])
        }
        return Polygon(vertices: verts)
            .fill(Color.purple)
    }
    
    var body: some View {
        ZStack {
            ForEach(self.vertices.indices, id: \.self) { i in
                CircleView(radius: 12, id: self.idStart+i, offset: CGSize(width: self.vertices[i].x, height: self.vertices[i].y), dragState: .zero)
            }
        }.offset(offset + dragState)
            .backgroundPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
                GeometryReader { (proxy: GeometryProxy) in
                    self.draw(proxy, centers)
                }
        }.gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged({ (value) in
                    self.dragState = value.translation
                    print("Drag Detected")
                }).onEnded({ (value) in
                    self.dragState = .zero
                    self.offset.width += value.translation.width
                    self.offset.height += value.translation.height
                }))
    }
}

// MARK: - Rectangle
struct RectangleView: View {
    var size: CGSize
    var id: Int
    @State var offset: CGSize = .zero
    @State var dragState: CGSize = .zero
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .anchorPreference(key: Key.self, value: .center, transform: { [self.id : [$0]] })
            .frame(width: size.width, height: size.height)
            .offset(offset + dragState)
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        self.dragState = value.translation
                    }).onEnded({ (value) in
                        self.dragState = .zero
                        self.offset.width += value.translation.width
                        self.offset.height += value.translation.height
                    }))
    }
}

// MARK: - Circle
struct CircleView: View {
    var radius: CGFloat
    var id: Int
    @State var offset: CGSize = .zero
    @State var dragState: CGSize = .zero
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    
    var body: some View {
        Circle()
            .fill(Color.blue)
            .anchorPreference(key: Key.self, value: .center, transform: { [self.id : [$0]] })
            .frame(width: radius*2, height: radius*2)
            .offset(offset + dragState)
            .simultaneousGesture(
                DragGesture()
                    .onChanged({ (value) in
                        self.dragState = value.translation
                    }).onEnded({ (value) in
                        self.dragState = .zero
                        self.offset.width += value.translation.width
                        self.offset.height += value.translation.height
                    }))
    }
}

// MARK: - Line
struct LineView: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    var radius: CGFloat = 5
    var ids: (first: Int, second: Int)
    @State var offset1: CGSize = .zero
    @State var dragState1: CGSize = .zero
    @State var offset2: CGSize = .zero
    @State var dragState2: CGSize = .zero
    var p1: CGPoint {
        let current = offset1 + dragState1
        return CGPoint(x: current.width, y: current.height)
    }
    var p2: CGPoint {
        let current = offset2 + dragState2
        return CGPoint(x: current.width, y: current.height)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .anchorPreference(key: Key.self, value: .center, transform: { [self.ids.first : [$0]] })
                .frame(width: radius*2, height: radius*2)
                .offset(offset1 + dragState1)
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            self.dragState1 = value.translation
                        }).onEnded({ (value) in
                            self.dragState1 = .zero
                            self.offset1.width += value.translation.width
                            self.offset1.height += value.translation.height
                        }))
            Circle()
                .fill(Color.blue)
                .anchorPreference(key: Key.self, value: .center, transform: { [self.ids.second : [$0]] })
                .frame(width: radius*2, height: radius*2)
                .offset(offset2 + dragState2)
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            self.dragState2 = value.translation
                        }).onEnded({ (value) in
                            self.dragState2 = .zero
                            self.offset2.width += value.translation.width
                            self.offset2.height += value.translation.height
                        }))
        }
    }
}

