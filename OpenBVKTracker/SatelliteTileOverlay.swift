//
//  SatelliteTileOverlay.swift
//  OpenBVKTracker
//
//  Infrarood satelliet overlay via Rainviewer API (gratis, geen key).
//

import MapKit

/// Satelliet (infrarood) tile overlay via Rainviewer.
class SatelliteTileOverlay: MKTileOverlay {

    /// Maak overlay aan met vaste Rainviewer satellite URL (geen API pad nodig).
    static func make(path: String = "") -> SatelliteTileOverlay {
        let radarPart = path.isEmpty ? "/v2/satellite" : path
        let template = "https://tilecache.rainviewer.com\(radarPart)/256/{z}/{x}/{y}/0/0_0.png"
        let overlay = SatelliteTileOverlay(urlTemplate: template)
        overlay.canReplaceMapContent = false
        overlay.minimumZ = 0
        overlay.maximumZ = 16
        overlay.tileSize = CGSize(width: 256, height: 256)
        return overlay
    }
}
