//
//  SeatBookingConfirmationView.swift
//  CampusNavigator
//
//  Created by Chathuri Maduka on 2025-06-06.
//

import SwiftUI

struct SeatBookingConfirmationView: View {
    @State private var showHome = false
    var body: some View {
        
        GeometryReader { geometry in
                   ZStack {
                       // Background with subtle pattern
                       Color.gray.opacity(0.05)
                           .ignoresSafeArea()
                       
                       
                       }
                       
                       VStack(spacing: 20) {
                           Spacer()
                           
                           Image(.success)
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(width: 300, height: 300)
                        .padding(.horizontal, 40)
                       
                           // Success Message
                           VStack(spacing: 16) {
                               Text("Your Seat Booking has\nbeen confirmed\nSuccessfully!")
                                   .font(.appTitle1Regular)
                                   .fontWeight(.semibold)
                                   .foregroundColor(.appPrimaryBlue)
                                   .multilineTextAlignment(.center)
                                   .lineSpacing(4)
                               
                               Text("Your seat will receive a confirmation\nshortly")
                                   .font(.appTitle3Regular)
                                   .foregroundColor(.black)
                                   .multilineTextAlignment(.center)
                                   .lineSpacing(2)
                           }
                           
                           Spacer()
                           
                           // Back to Home Button
                           Button(action: {
                               showHome = true
                               print("Back to Home tapped")
                           }) {
                               Text("Back to Home")
                                   .font(.headline)
                                   .fontWeight(.medium)
                                   .foregroundColor(.white)
                                   .frame(maxWidth: .infinity)
                                   .frame(height: 56)
                                   .background(
                                       LinearGradient(
                                           gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                           startPoint: .top,
                                           endPoint: .bottom
                                       )
                                   )
                                   .cornerRadius(28)
                                   .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                           }
                           .padding(.horizontal, 32)
                           .padding(.bottom, 50)
                       }
                   }
        .fullScreenCover(isPresented: $showHome) {
            HomeScreenView()
        }
        
        
               }
           }
           
           private func confettiColor(for index: Int) -> Color {
               let colors: [Color] = [.yellow, .orange, .red, .pink, .purple, .blue, .teal, .green]
               return colors[index % colors.count]
           }


    
       

       struct ConfettiShape: Shape {
           func path(in rect: CGRect) -> Path {
               var path = Path()
               
               // Create different confetti shapes
               let shapeType = Int.random(in: 0...2)
               
               switch shapeType {
               case 0:
                   // Rectangle
                   path.addRect(rect)
               case 1:
                   // Circle
                   path.addEllipse(in: rect)
               default:
                   // Triangle
                   path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                   path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                   path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                   path.closeSubpath()
               }
               
               return path
           }
       }

       // Preview
       struct SeatBookingConfirmationView_Previews: PreviewProvider {
           static var previews: some View {
               SeatBookingConfirmationView()
           }
       }
#Preview {
    SeatBookingConfirmationView()
}
