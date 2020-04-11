//
//  ContentView.swift
//  CollisionDetectionExamples
//
//  Created by Kieran Brown on 4/11/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Point")) {
                    NavigationLink("Point-Line", destination: Point_Line())
                    NavigationLink("Point-Circle", destination: Point_Circle())
                    NavigationLink("Point-Rectangle", destination: Point_Rectangle())
                    NavigationLink("Point-Polygon", destination: Point_Polygon())
                }
                
                Section(header: Text("Line")) {
                    NavigationLink("Line-Line", destination: Line_Line())
                    NavigationLink("Line-Circle", destination: Line_Circle())
                    NavigationLink("Line-Rectangle", destination: Line_Rect())
                }
                Section(header: Text("Circle")) {
                    NavigationLink("Circle-Circle", destination: Circle_Circle())
                    NavigationLink("Circle-Rectangle", destination: Circle_Rectangle())
                    NavigationLink("Polygon-Circle", destination: Polygon_Circle())
                }
                Section(header: Text("Rectangle")) {
                    NavigationLink("Rectangle-Rectangle", destination: Rectangle_Rectangle())
                }
                Section(header: Text("Polygon")) {
                    NavigationLink("Polygon-Polygon", destination: Polygon_Polygon())
                }
            }.navigationBarTitle("Collisions")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
