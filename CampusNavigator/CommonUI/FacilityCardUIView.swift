//
//  FacilityCardUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI
struct FacilityItem {
    let id = UUID()
    let title: String
    let message: String
    let updatedTime: String

}
struct FacilityCardUIView: View {
    let facility: FacilityItem
    let onViewMore: () -> Void
    
    var body: some View {
        HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(facility.title)
                            .font(.appBodySemibold)
                            .foregroundColor(.appBlack)
                        
                        Text(facility.message)
                            .font(.appFootnoteRegular)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        Text("Updated \(facility.updatedTime)")
                            .font(.appCaptionRegular)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 12) {
                        
                       
                      
                        Button(action: onViewMore) {
                            Text("More Info")
                                .font(.appFootnoteSemibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.appPrimaryBlue)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(16)
                .background(Color.appLightBlue)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appPrimaryBlue, lineWidth: 1)
                )
                .cornerRadius(12)
    }
}


