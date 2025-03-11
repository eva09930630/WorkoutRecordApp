import SwiftUI
import Charts

struct DailyWorkoutChartView: View {
    var workoutRecords: [WorkoutRecord]

    private var groupedRecordsByDay: [(date: Date, records: [WorkoutRecord])] {
        Dictionary(grouping: workoutRecords.sorted { $0.date < $1.date }) { record in
            Calendar.current.startOfDay(for: record.date)
        }
        .map { (key, value) in (date: key, records: value) }
        .sorted { $0.date < $1.date }
    }

    var body: some View {
        Chart {
            ForEach(groupedRecordsByDay, id: \.date) { group in
                let date = group.date
                let records = group.records

                ForEach(records, id: \.id) { record in
                    LineMark(
                        x: .value("日期", date),
                        y: .value("重量", record.weight)
                    )
                    .foregroundStyle(by: .value("器材", record.equipmentName))
                    
                    PointMark(
                        x: .value("日期", date),
                        y: .value("重量", record.weight)
                    )
                    .foregroundStyle(by: .value("器材", record.equipmentName))
                    .annotation(position: .top) {
                        Text("\(record.weight, specifier: "%.1f") kg")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    DailyWorkoutChartView(workoutRecords: [])
}
