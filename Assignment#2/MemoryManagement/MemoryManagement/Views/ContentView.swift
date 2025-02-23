import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink, Color.orange.opacity(0.5)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.top)
                
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 8)
                    .offset(y: 100)
            }

            VStack(spacing: 5) {
                Text("Samantha Jones")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("New York, United States")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Web Producer - Web Specialist\nColumbia University - New York")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            .padding(.top, 40)

            HStack(spacing: 40) {
                ProfileStat(count: 101, label: "Friends")
                ProfileStat(count: 1, label: "Photos")
                ProfileStat(count: 1001, label: "Comments")
            }
            .padding(.top, 10)

            // Action Buttons
            HStack {
                ActionButton(icon: "person.fill.badge.plus", title: "Connect", color: .pink)
                Spacer()
                ActionButton(icon: "message.fill", title: "Message", color: .orange)
            }
            .padding(.top, 20)
            .padding(.horizontal, 50)

            Spacer()
        }
        .padding()
    }
}

struct ProfileStat: View {
    var count: Int
    var label: String

    var body: some View {
        VStack {
            Text("\(count)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)

            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct ActionButton: View {
    var icon: String
    var title: String
    var color: Color

    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 140, height: 40)
            .background(color)
            .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

