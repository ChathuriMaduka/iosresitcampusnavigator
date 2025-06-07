//
//  HomeScreenView.swift
//  CampusNavigator
//
//  Created by Malsha Bopage on 2025-06-07.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var searchText = ""
    @State private var selectedBottomTab = 0
    @State private var showHome = false
    @State private var showLocation = false
    @State private var showFacility = false
    @State private var showProfile = false
    @State private var showNotification = false
   // @StateObject private var campusData = CampusData()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                   
                    headerSection
                    
                    
                    searchSection
                    
                  
                    quickNavigationCard
                    
                    
                    frequentLocationsSection
                    
                   
                    quickAccessSection
                }
                .padding(.horizontal,20)
            }
            .background(Color.appBackgroundGray.ignoresSafeArea())
            .navigationBarHidden(true)
            
            
            .fullScreenCover(isPresented: $showHome) {
                HomeScreenView()
            }
            .fullScreenCover(isPresented: $showNotification) {
                NotificationUIView()
            }
            .fullScreenCover(isPresented: $showFacility) {
                FacilityUIView()
            }
            .fullScreenCover(isPresented: $showProfile) {
                ProfileDetailsView()
            }
            
            
        }
        
                        Spacer()
                        BotemNavigationBarUIView(selectedTab: $selectedBottomTab) { index in
                            handleBottomTabSelection(index)
                        }
                    
    }
    private func handleBottomTabSelection(_ index: Int) {
         print("Bottom tab selected: \(index)")
         
         switch index {
         case 0: // home
             print("Already on Home")
             showHome = false
             
         case 1: // notification
             print("Navigate to notification")
             showNotification = true
         case 2: // Location
             print("Navigate to Location")
             
         case 3: // facilities
             print("Navigate to facility")
             showFacility = true
             
         case 4: // Profile
             print("Navigate to Profile")
             showProfile = true
         default:
             break
         }
     }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Good Evening! Chathuri")
                        .font(.appTitle2Semibold)
                        .foregroundColor(.appPrimaryBlue)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .foregroundColor(.appPrimaryBlue)
                            .font(.appCaptionRegular)
                        
                        Text("My Location : Program Office")
                            .font(.appSubheadlineRegular)
                            .foregroundColor(.appPrimaryBlue)
                    }
                }
                
                Spacer()
               
                HStack(spacing: 14) {
                    Button(action: {}) {
                        
                        AsyncImage(url: URL(string: "profile_image")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .font(.appTitle2Regular)
                                .foregroundColor(.appPrimaryBlue)
                        }
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "bell")
                            .font(.appTitle3Regular)
                            .foregroundColor(.appPrimaryBlue)
                    }
                }
            }
        }
        .padding(.top, 10)
    }
    
    private var searchSection: some View {
        LocationSearchBar(searchText: $searchText) { query in
           
            
            print("Searching for: \(query)")
        }
    }
    
    private var quickNavigationCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
               
                
                Image(.image6) 
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 160)
                                    .clipped()
                                    .cornerRadius(16)
                
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black.opacity(0.3))
                    .frame(height: 160)
                
               
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "building.2.fill")
                            .font(.appLargeTitleRegular)
                            .foregroundColor(.appWhite.opacity(0.4))
                    }
                    
                    Spacer()
                    
                   
                    NavigationLink {
                     //   ContentView()
                    } label: {
                        HStack(spacing: 8) {
                            Image("")
                                .font(.appButtonTitle)
                            Text("Start Navigate")
                                .font(.appButtonTitle)
                        }
                        .foregroundColor(.appWhite)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.appPrimaryBlue)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                }
                .padding(20)
            }
        }
    }
    
    private var frequentLocationsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Frequently Finding Locations")
                .font(.appHeadlineBold)
                .foregroundColor(.appPrimaryBlue)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 58) {
                    FrequencyLocationCard(
                        title: "Halls",
                        icon: "person.3.fill",
                        color: .appPrimaryBlue,
                        imageName: "halls_image" // Added image parameter
                    )
                    
                    FrequencyLocationCard(
                        title: "Library",
                        icon: "book.fill",
                        color: .green,
                        imageName: "library_image"
                    )
                    
                    FrequencyLocationCard(
                        title: "Cafeteria",
                        icon: "fork.knife",
                        color: .orange,
                        imageName: "cafeteria_image"
                    )
                }
                .padding(.horizontal, 8)
            }
        }
    }
    
    private var quickAccessSection: some View {
        VStack(alignment: .leading, spacing: 16) {

            let hallsData = [
                (hall: "Hall No : 18", floor: "2nd Floor", image: "hall_18_image"),
                (hall: "Hall No : 08", floor: "3rd Floor", image: "hall_08_image")
            ]
            
            ForEach(hallsData, id: \.hall) { hallData in
                QuickAccessHallCard(
                    hallName: hallData.hall,
                    floorName: hallData.floor,
                    imageName: hallData.image,
                    onQuickTour: {
                       
                    }
                )
            }
        }
    }
}


struct FrequencyLocationCard: View {
    let title: String
    let icon: String
    let color: Color
    let imageName: String
    
    var body: some View {
        Button(action: {
           
        }) {
            VStack(spacing: 8) {
               
                AsyncImage(url: URL(string: imageName)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipped()
                } placeholder: {
                    Image(systemName: icon)
                        .font(.appTitle3Semibold)
                        .foregroundColor(color)
                        .frame(width: 40, height: 40)
                        .background(color.opacity(0.1))
                }
                .cornerRadius(12)
                
                Text(title)
                    .font(.appCaptionSemibold)
                    .foregroundColor(.appBlack)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appWhite)
            .cornerRadius(12)
            .shadow(color: Color.appBlack.opacity(0.08), radius: 3, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct QuickAccessHallCard: View {
    let hallName: String
    let floorName: String
    let imageName: String
    let onQuickTour: () -> Void
    
    @State private var selectedBottomTab = 0
    @State private var isNavigating = false
    @State private var showHome = false
    @State private var showLocation = false
    @State private var showFacilityDetail = false
    @State private var showProfile = false
    
    
    var body: some View {
        ZStack {
            // Background image covering the entire card
            Image(.image7)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 80)
                .clipped()
                .cornerRadius(16)
            
            // Dark overlay for better text readability
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.4))
                .frame(height: 80)
            
            // Content overlay
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(hallName)
                        .font(.appHeadlineSemibold)
                        .foregroundColor(.appWhite)
                    Text(floorName)
                        .font(.appSubheadlineRegular)
                        .foregroundColor(.appWhite.opacity(0.8)) 
                }
                
                Spacer()
                
                NavigationLink {
                    //MapScreenView()
                } label: {
                    Text("Quick Tour")
                        .font(.appCaptionBold)
                        .foregroundColor(.appWhite)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.appPrimaryBlue)
                        .cornerRadius(20)
                        .shadow(color: Color.appPrimaryBlue.opacity(0.3), radius: 2, x: 0, y: 1)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(16)
        }

        .shadow(color: Color.appBlack.opacity(0.08), radius: 4, x: 0, y: 2)
        


    }
    
    
 

}
#Preview {
    HomeScreenView()
}
