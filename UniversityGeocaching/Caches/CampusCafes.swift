//
//  CampusCafes.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/14/23.
//

import Foundation
import SwiftUI

struct CampusCafes : View{
    var body : some View{
        Text("Campus Cafes")
            .font(.largeTitle)
        .navigationBarBackButtonHidden()
    }
}

struct CampusCafesView_Previews: PreviewProvider {
    static var previews: some View {
        CampusCafes()
    }
}
