import SwiftUI
import Charts

struct MonthlyWorkoutChartView: View {
    var workoutRecords: [WorkoutRecord]

    private var groupedRecordsByMonth: [(month: String, equipmentName: String, averageWeight: Double)] {
        struct MonthEquipmentKey: Hashable {
            let month: String
            let equipmentName: String
        }

        let groupedByMonthAndEquipment = Dictionary(grouping: workoutRecords) { record in
            let yearMonth = Calendar.current.dateComponents([.year, .month], from: record.date)
            let monthString = String(format: "%04d-%02d", yearMonth.year ?? 0, yearMonth.month ?? 0)
            return MonthEquipmentKey(month: monthString, equipmentName: record.equipmentName)
        }

        return groupedByMonthAndEquipment.map { (key, records) in
            let totalWeight = records.reduce(0) { $0 + $1.weight }
            let averageWeight = totalWeight / Double(records.count)
            return (month: key.month, equipmentName: key.equipmentName, averageWeight: averageWeight)
        }
        .sorted { $0.month < $1.month }
    }

    var body: some View {
        Chart {
            ForEach(groupedRecordsByMonth, id: \.month) { group in
                LineMark(
                    x: .value("月份", group.month),
                    y: .value("平均重量", group.averageWeight)
                )
                .foregroundStyle(by: .value("器材", group.equipmentName))
                
                PointMark(
                    x: .value("月份", group.month),
                    y: .value("平均重量", group.averageWeight)
                )
                .foregroundStyle(by: .value("器材", group.equipmentName))
                .annotation(position: .top) {
                    Text("\(group.averageWeight, specifier: "%.1f") kg")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    MonthlyWorkoutChartView(workoutRecords: [])
}

