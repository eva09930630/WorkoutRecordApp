//
//  EquipmentDetailView.swift
//  WorkoutRecord
//
//  Created by 陳奕帆 on 2025/3/6.
//
import SwiftUI

struct EquipmentDetailView: View {
    var equipment: Equipment  // 接收選擇的設備

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(equipment.name)
                .font(.largeTitle)
                .bold()

            Text(equipment.details)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding()
        .navigationTitle(equipment.name)
    }
}

#Preview {
    let sampleEquipment = Equipment(name: "槓鈴", details: "健身房常見的自由重量訓練工具")
    return EquipmentDetailView(equipment: sampleEquipment)
}

