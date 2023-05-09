import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Spacer(minLength: 100)
                VStack(alignment: .leading) {
                    
                    Text("University of San Diego")
                        .font(.system(size: 32, weight: .bold))
                        .frame(width: 450, height: 00)
                        .foregroundColor(Color(red: 0/255, green: 55/255, blue: 112/255))
                        .padding(.vertical, 0)
                    Text(" Geocaching")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.green)
                        .frame(width: 450, height: 00)
                        .padding(.vertical, 40)
                        .cornerRadius(40)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                VStack{
                    HStack{
                        NavigationLink(destination: PastQuestView()){
                            HStack{
                                Image(systemName: "checkmark.circle")
                                Text("Past Quests")
                            }
                            .frame(width: 150, height: 50)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(.infinity)
                        }
                        
                        NavigationLink(destination: NavigationScreenView()){
                            HStack{
                                Image(systemName: "mappin.circle")
                                Text("Navigation Screen")
                            }
                            .frame(width: 150, height: 50)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(.infinity)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        HStack{
                            NavigationLink(destination: CreateQuestView()){
                                HStack{
                                    Image(systemName: "checklist.unchecked")
                                    Text("Create a Quest")
                                }
                                .frame(width: 150, height: 50)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(.infinity)
                            }
                            
                            NavigationLink(destination: UserSettingsView()){
                                HStack{
                                    Image(systemName: "person.2.badge.gearshape")
                                    Text("User Settings")
                                }
                                .frame(width: 150, height: 50)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(.infinity)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 200) // Add padding to the bottom of the screen
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

