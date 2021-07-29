//
//  RocketLaunchList.swift
//  iosApp
//
//  Created by Danil Lomaev on 29.07.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI
import shared

extension RocketLaunch: Identifiable { }

struct RocketLaunchList: View {
    let rocketLaunches: [RocketLaunch]
    var body: some View {
        List(rocketLaunches) { rocketLaunch in
            RocketLaunchRow(rocketLaunch: rocketLaunch)
        }
    }
}

//struct RocketLaunchList_Previews: PreviewProvider {
//    static var previews: some View {
//        RocketLaunchList()
//    }
//}
