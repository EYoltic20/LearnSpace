//
//  PlanetInfoView.swift
//  LearnSpace
//
//  Created by Emilio Y Martinez on 15/04/23.
//

import SwiftUI

struct PlanetInfoView: View {
    var planeta : String
    var image: String
    var texto : String
    var dificultad: Int
    var color : UIColor
    @Binding var nivel : String
    var body: some View {
        GeometryReader{geo in
            VStack{
                ScrollView{
                    Image(image)
                        .resizable()
                        .frame(width:200,height:200)
                        .scaledToFit()
                    Rectangle().fill(.white).frame(height:3).padding()
                    Text(planeta)
                        .font(.title)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .bold()
                    Rectangle().fill(.white).frame(height:3).padding()
                    Text(texto)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                    Rectangle().fill(.white).frame(height:3).padding()
                    HStack{
                        Text("Dificultad: ")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        ForEach(dificultad..<dificultad+dificultad){_ in
                            Image(image)
                                .resizable()
                                .frame(width:30,height:30)
                        }
                    }
                    Button{
                        nivel = planeta
                    }label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(color))
                            .frame(width: geo.size.width-100,height:geo.size.height/10)
                            .overlay{
                                Text("Explorar")
                                    .font(.title)
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                            
                    }
                }
            }
            .frame(width:geo.size.width,height: geo.size.height)
            .background{
                Color.black.ignoresSafeArea()
            }
            }
    }
}

//struct PlanetInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanetInfoView()
//    }
//}
