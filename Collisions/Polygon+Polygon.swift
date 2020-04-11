//
//  Polygon+Polygon.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

struct Polygon_Polygon: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    var vertices: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 100, y: 0), CGPoint(x: 120, y: 50), CGPoint(x: 65, y: 25)]
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        var verts1: [CGPoint] = []
        for i in 0..<vertices.count {
            verts1.append(proxy[centers[i]!.first!])
        }
        var verts2: [CGPoint] = []
        for i in 0..<vertices.count {
            verts2.append(proxy[centers[self.vertices.count + i]!.first!])
        }
        
        return Group {
            if  polyPoly(verts1, verts2) {
                Polygon(vertices: verts1)
                    .fill(Color.orange)
                    .allowsHitTesting(false)
                Polygon(vertices: verts2)
                .fill(Color.green)
                .allowsHitTesting(false)
            }
        }
    }

    var body: some View {
        ZStack {
            PolygonView(idStart: 0, vertices: vertices)
            PolygonView(idStart: vertices.count, vertices: vertices.map({$0 - CGPoint(x: 100, y: 0)}))
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Polygon_Polygon_Previews: PreviewProvider {
    static var previews: some View {
        Polygon_Polygon()
    }
}
