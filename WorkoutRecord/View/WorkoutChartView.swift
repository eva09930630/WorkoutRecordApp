import SwiftUI
import SwiftData
import Foundation

@MainActor
struct WorkoutChartView: View {
    @Query private var workoutRecords: [WorkoutRecord]
    @State private var timeGrouping: TimeGrouping = .day // 預設為每日

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundColorView() // 使用統一背景色
                VStack {
                    // **🔹 Segmented Picker 切換「每日 / 每月」**
                    Picker("時間區間", selection: $timeGrouping) {
                        Text("每日").tag(TimeGrouping.day)
                        Text("每月").tag(TimeGrouping.month)
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    if timeGrouping == .day {
                        DailyWorkoutChartView(workoutRecords: workoutRecords)
                    } else {
                        MonthlyWorkoutChartView(workoutRecords: workoutRecords)
                    }
                }
            }
            .navigationTitle("訓練趨勢")
        }
    }
}

#Preview {
    WorkoutChartView()
}
