import SwiftUI

struct WorkoutCardView: View {
    let record: WorkoutRecord

    var body: some View {
        VStack(alignment: .leading) {
            Text("器材: \(record.equipmentName)")
                .font(.headline)
            Text("重量: \(record.weight, specifier: "%.1f") kg")
                .font(.subheadline)
            Text("次數: \(record.reps) 組數: \(record.sets)")
                .font(.subheadline)
        }
        .padding()
        .frame(width: 180)
        .background(Color(red: 0.85, green: 0.75, blue: 0.65))
        .cornerRadius(10)
    }
}

#Preview {
    WorkoutCardView(record: WorkoutRecord(
        equipmentName: "槓鈴",
        weight: 50,
        reps: 10,
        sets: 3,
        date: Date()
    ))
}
