//
//  TimerTcaFeature.swift
//  TimerTca
//
//  Created by Gaurav Bhambhani on 7/30/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TimerTcaFeature {
    
    
    @ObservableState
    struct State {
        var time = 0
        var isTimerRunning = false
    }
    
    enum Action {
        case timerTick
        case toggleTimerButtonTapped
    }
    
    enum CancelID {
        case timer
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .timerTick:
                state.time += 1
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                
                if state.isTimerRunning {
                    return .run { send in
                        
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTick)
                            
                        }
                    }
                    .cancellable(id: CancelID.timer)
                }
                
                else {
                    return .cancel(id: CancelID.timer)
                }
            }
        }
    }
}
