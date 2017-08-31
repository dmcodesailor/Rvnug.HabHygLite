//
//  StarData.swift
//  habhyglite
//
//  Created by Brian Lanham on 8/18/17.
//  Copyright © 2017 Brian Lanham. All rights reserved.
//

import Foundation

class StarData {
    var id: Int = -1
    var HipparcosCatalogId: Int = -1
    var CommonName: String = ""
    var BayerFlamsteedDesignation: String = ""
    var GlieseCatalogId: String = ""
    var HenryDraperCatalogId: String = ""
    var HarvardRevisedCatalogId: String = ""
    var ProperName: String = ""
    var SpectralType: String = ""
    var DistanceInParsecs: Float = 0.0
    var x: Float = 0.0
    var y: Float = 0.0
    var z: Float = 0.0
    var AbsoluteMagnitude: Float = 0.0
    
    init() {
    }
}
