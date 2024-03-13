//
//  ContentView.swift
//  MusicByLocation
//
//  Created by William Eze on 12/03/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var locationHandler = LocationHandler()

    var body: some View {
        VStack{
            Text(locationHandler.lastKnowLocation)
            Spacer()
            Button("Get current location"){
                locationHandler.requestLocation()
            }
        }
        .onAppear(perform: {
            locationHandler.requestAuthorisation()
        })
    }}

#Preview {
    ContentView()
}
