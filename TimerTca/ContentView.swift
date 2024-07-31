//
//  ContentView.swift
//  TimerTca
//
//  Created by Gaurav Bhambhani on 7/30/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    var store: StoreOf<TimerTcaFeature>
    
    var body: some View {
        VStack {
            
            Text("\(store.time)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            
            Button(store.isTimerRunning ? "Start" : "Stop") {
                store.send(.toggleTimerButtonTapped)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView(store: Store(initialState: TimerTcaFeature.State(), reducer: {
        TimerTcaFeature()
    }))
}
