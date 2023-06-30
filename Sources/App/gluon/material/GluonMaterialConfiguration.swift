//
//  MaterialConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterialConfiguration : MaterialConfiguration {
    let id:String
    let item:(any MaterialItemConfiguration)?
    let block:(any MaterialBlockConfiguration)?
}
