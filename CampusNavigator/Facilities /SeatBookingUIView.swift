//
//  SeatBookingUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI

struct SeatBookingUIView: View {
    @State private var selectedTab = 0
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showConfirmation = false
    @State private var showFacilityDetail = false
    
    let bookings = [
        BookingItem(
  
            title: "iOS Lab",
            name: "Chathuri Maduka",
            batch: "22.2P",
            index: "cobsccomp4y222p-068",
            seatNo: "12",
        ),
        BookingItem(
  
            title: "iOS Lab",
            name: "Chathuri Maduka",
            batch: "22.2P",
            index: "cobsccomp4y222p-068",
            seatNo: "5",
        ),
        BookingItem(
  
            title: "IOT Lab",
            name: "Chathuri Maduka",
            batch: "22.2P",
            index: "cobsccomp4y222p-068",
            seatNo: "7",
        ),
        BookingItem(
  
            title: "Network Lab",
            name: "Chathuri Maduka",
            batch: "22.2P",
            index: "cobsccomp4y222p-068",
            seatNo: "15",
        ),
        BookingItem(
  
            title: "iOS Lab",
            name: "Chathuri Maduka",
            batch: "22.2P",
            index: "cobsccomp4y222p-068",
            seatNo: "1",
        ),
    ]
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    ForEach(Array(["Today", "Yesterday", "Earlier"].enumerated()), id: \.offset) { index, title in
                        Button(action: {
                            selectedTab = index
                        }) {
                            Text(title)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(selectedTab == index ? .appWhite : .appPrimaryBlue)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 10)
                                .background(
                                    selectedTab == index ? Color.appPrimaryBlue : Color.clear
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.appPrimaryBlue, lineWidth: 1)
                                )
                                .cornerRadius(20)
                            
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(getFilteredBooking(), id: \.id) { booking in
                            BookingCardUIView(booking:booking,showBookButton: selectedTab == 0 
                            ) {
                                handleBookingTapped(for: booking)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 30)
                    
                }
                
                
                Spacer()
                
            }
            
            .navigationTitle("Seat Booking")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showFacilityDetail = true
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.appPrimaryBlue)
                                .font(.appBodySemibold)
                        }
                    }
                }
            }
            .toolbarColorScheme(.light)
            .toolbarBackground(Color.clear, for: .navigationBar)
            
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.titleTextAttributes = [
                    .foregroundColor: UIColor.red,
                    .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                ]
                
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
            
            .fullScreenCover(isPresented: $showConfirmation) {
                SeatBookingConfirmationView()
            }
            .fullScreenCover(isPresented: $showFacilityDetail) {
                FacilityDetailView()
            }
            
            
            
        }
    }
    private func getFilteredBooking() -> [BookingItem] {
        switch selectedTab {
        case 0: // today
            return Array(bookings.prefix(1))
        case 1: // yesterday
            return Array(bookings.dropFirst(1).prefix(2))
        case 2: // earlier
            return Array(bookings.dropFirst(1).prefix(4))
        default:
            return bookings
        }
    }
    private func handleBookingTapped(for booking: BookingItem ){
        showConfirmation = true
    }
}


#Preview {
    SeatBookingUIView()
}
