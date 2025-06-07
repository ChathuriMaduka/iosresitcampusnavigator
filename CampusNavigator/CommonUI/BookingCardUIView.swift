//
//  BookingCardUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI
struct BookingItem {
    let id = UUID()
    let title: String
    let name: String
    let batch: String
    let index: String
    let seatNo: String

}

struct BookingCardUIView: View {
    let booking: BookingItem
    let showBookButton: Bool
    let onBooking: () -> Void
    
    var body: some View {
        HStack {
                    VStack(alignment: .leading, spacing: 22) {
                        Text(booking.title)
                            .font(.appTitle1Bold)
                            .foregroundColor(.appBlack)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Name:")
                                    .font(.appBodySemibold)
                                    .foregroundColor(.secondary)
                                Text(booking.name)
                                    .font(.appBodySemibold)
                                    .foregroundColor(.primary)
                            }
                            
                            HStack {
                                Text("Batch:")
                                    .font(.appBodySemibold)
                                    .foregroundColor(.secondary)
                                Text(booking.batch)
                                    .font(.appBodySemibold)
                                    .foregroundColor(.primary)
                            }
                            
                            HStack {
                                Text("Index:")
                                    .font(.appBodySemibold)
                                    .foregroundColor(.secondary)
                                Text(booking.index)
                                    .font(.appBodySemibold)
                                    .foregroundColor(.primary)
                            }
                            
                            HStack {
                                Text("Selected Seat No:")
                                    .font(.appBodySemibold)
                                    .foregroundColor(.secondary)
                                Text(booking.seatNo)
                                    .font(.appBodySemibold)
                                    .foregroundColor(.primary)
                            }
                        }
                        if showBookButton {
                            Button(action: onBooking) {
                                Text("Book")
                                    .font(.appTitle3Bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 80)
                                    .padding(.vertical, 8)
                                    .background(Color.appPrimaryBlue)
                                    .cornerRadius(12)
                            }

                        }
                       
                    }
                    
                    Spacer()
                    
                }
                .padding(16)
                .background(Color.appLightBlue.opacity(0.3))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appPrimaryBlue, lineWidth: 1)
                )
                .cornerRadius(12)

    }
}


