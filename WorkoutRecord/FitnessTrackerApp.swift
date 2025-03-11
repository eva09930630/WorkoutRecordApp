//
//  FitnessTrackerApp.swift
//  WorkoutRecord
//
//  Created by 陳奕帆 on 2025/3/6.
//
import SwiftUI

@main
struct FitnessTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Equipment.self, WorkoutRecord.self])
        }
    }
}

