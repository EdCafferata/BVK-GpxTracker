# Bouwhandleiding: iOS GPX Tracker klonen en aanpassen

Dit document beschrijft **alle stappen** die zijn uitgevoerd om de BVK GPX Tracker te maken
op basis van [iOS-Open-GPX-Tracker](https://github.com/merlos/iOS-Open-GPX-Tracker) van Juan M. Merlos.
Volg deze handleiding op een nieuwe Mac om een volledig werkende aangepaste versie te bouwen.

---

## Vereisten

| Tool | Versie | Opmerking |
|------|--------|-----------|
| macOS | 13+ | |
| Xcode | 16+ | Download via App Store |
| Git | meegeleverd | `xcode-select --install` indien nodig |
| Apple ID | gratis | Nodig voor signing op fysiek apparaat |
| Python 3 + Pillow | `pip3 install Pillow` | Alleen voor het genereren van app-iconen |

---

## Stap 1 — Origineel project klonen

```bash
git clone https://github.com/merlos/iOS-Open-GPX-Tracker.git MijnApp-GpxTracker
cd MijnApp-GpxTracker
```

Open het project in Xcode om te controleren dat het compileert:

```bash
open OpenGpxTracker.xcodeproj
```

Selecteer een simulator en druk op ▶ (Cmd+R). De app moet starten zonder fouten.

---

## Stap 2 — Nieuwe Git-repository aanmaken

```bash
git remote remove origin
git remote add origin https://github.com/JOUWGEBRUIKER/JOUWREPO.git
git push -u origin main
```

---

## Stap 3 — Project hernoemen (bestanden en mappen)

Hernoem de volgende mappen in de projectroot:

| Oud | Nieuw |
|-----|-------|
| `OpenGpxTracker/` | `OpenMijnApp/` (of laat staan) |
| `OpenGpxTracker.xcodeproj` | `OpenMijnApp.xcodeproj` |

> **Tip:** Dit is optioneel. De app werkt ook zonder hernoeming.
> Doe het wel als je een volledig schone codebase wilt.

### Hernoeming in Xcode

1. Open het project in Xcode
2. Selecteer het project in de Project Navigator
3. Klik op de target naam en hernoem naar `OpenMijnApp`
4. Klik op `Rename` wanneer Xcode vraagt of gerelateerde bestanden ook hernoemd moeten worden

### CoreData model hernoeming (KRITIEK)

De `.xcdatamodeld` map bevat een inner map. **Beide** moeten overeenkomen:

```
OpenGpxTracker.xcdatamodeld/          ← outer folder
    OpenGpxTracker.xcdatamodel/       ← inner folder (MOET overeenkomen met .xccurrentversion)
        .xccurrentversion
        contents
```

In `.xccurrentversion`:
```xml
<key>_XCCurrentVersionName</key>
<string>OpenMijnApp.xcdatamodel</string>   ← moet exact de inner map naam zijn
```

**Hernoemstap:**
```bash
cd OpenMijnApp   # of de map van je app
mv OpenBVKTracker.xcdatamodeld/OpenGpxTracker.xcdatamodel \
   OpenBVKTracker.xcdatamodeld/OpenMijnApp.xcdatamodel
```

Doe daarna een **clean build** in Xcode: Product → Clean Build Folder (Shift+Cmd+K), dan opnieuw bouwen.

> ⚠️ Als deze namen niet overeenkomen crasht de app bij elke start met:
> `NSFetchRequest could not locate NSEntityDescription for entity name 'CDRoot'`

---

## Stap 4 — Bundle identifier wijzigen

### In `project.pbxproj`

Zoek en vervang alle voorkomens van het oude bundle ID:

| Oud | Nieuw |
|-----|-------|
| `org.merlos.OpenGpxTracker` | `com.mijnbedrijf.MijnApp` |
| `org.merlos.OpenGpxTracker.watchkitapp` | `com.mijnbedrijf.MijnApp.watchkitapp` |
| `org.merlos.OpenGpxTracker.watchkitapp.ext` | `com.mijnbedrijf.MijnApp.watchkitapp.ext` |

> ⚠️ Let op typfouten: de Watch Extension moet exact `[hoofdapp].watchkitapp.ext` zijn,
> anders verschijnt de fout: *"Embedded binary's bundle identifier is not prefixed..."*

### In `OpenMijnApp-Watch Extension/Info.plist`

```xml
<key>WKAppBundleIdentifier</key>
<string>com.mijnbedrijf.MijnApp.watchkitapp</string>
```

### In `OpenMijnApp-Watch/Info.plist`

```xml
<key>WKCompanionAppBundleIdentifier</key>
<string>com.mijnbedrijf.MijnApp</string>
```

---

## Stap 5 — App naam instellen

### Naam op het thuisscherm (`Info.plist`)

```xml
<key>CFBundleDisplayName</key>
<string>Mijn App Naam</string>

<key>CFBundleName</key>
<string>Mijn App Naam</string>
```

### Naam in de titelbalk van de app (`ViewController.swift`)

Zoek de constante `kAppTitle`:

```swift
let kAppTitle: String = "  MIJN APP NAAM"
```

Lettertype en grootte:

```swift
appTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
```

---

## Stap 6 — App-icoon instellen

Zorg voor een **PNG-afbeelding van minimaal 512×512 px** (bij voorkeur 1024×1024).

Genereer alle iOS-maten met Python:

```python
from PIL import Image

src = "pad/naar/jouw_logo.png"
out_dir = "OpenMijnApp/Images.xcassets/AppIcon.appiconset"

img = Image.open(src).convert("RGBA")
size = 1024

# Maak vierkant canvas met witte achtergrond
canvas = Image.new("RGBA", (size, size), (255, 255, 255, 255))
scale = int(size * 0.80)
w, h = img.size
ratio = min(scale / w, scale / h)
logo = img.resize((int(w * ratio), int(h * ratio)), Image.LANCZOS)
canvas.paste(logo, ((size - logo.width) // 2, (size - logo.height) // 2), logo)

# Alle benodigde maten
sizes = {
    "Icon.png": 1024, "icon_20pt@2x.png": 40, "icon_20pt@3x.png": 60,
    "icon_29pt@2x.png": 58, "icon_29pt@3x.png": 87,
    "icon_40pt@2x.png": 80, "icon_40pt@3x.png": 120,
    "icon_60pt@2x.png": 120, "icon_60pt@3x.png": 180,
    "icon_20pt.png": 20, "icon_20pt@2x-1.png": 40,
    "icon_29pt.png": 29, "icon_29pt@2x-1.png": 58,
    "icon_40pt.png": 40, "icon_40pt@2x-1.png": 80,
    "icon_76pt.png": 76, "icon_76pt@2x.png": 152, "icon_83.5@2x.png": 167,
}
for filename, px in sizes.items():
    canvas.resize((px, px), Image.LANCZOS).convert("RGB").save(f"{out_dir}/{filename}", "PNG")
```

---

## Stap 7 — Standaard kaartserver instellen

In `Preferences.swift`:

```swift
// Verander van .apple naar gewenste server
private var _tileServer: GPXTileServer = .openSeaMap   // of .openStreetMap, .cartoDB, etc.
```

En de fallback op dezelfde regel eronder:

```swift
tileServerInt = tileServerInt >= GPXTileServer.count ? GPXTileServer.openSeaMap.rawValue : tileServerInt
```

Beschikbare servers (zie `GPXTileServer.swift`):
- `.apple` — Apple Maps
- `.openStreetMap` — OpenStreetMap
- `.openSeaMap` — OpenSeaMap (zeekaart)
- `.cartoDB` — CartoDB
- `.openTopoMap` — Topografische kaart

---

## Stap 8 — Coördinaten-balk aanpassen

In `ViewController.swift`, methode `setupView()`:

```swift
coordsLabel.font = UIFont(name: "DinAlternate-Bold", size: 16.0)
coordsLabel.numberOfLines = 2
coordsLabel.textColor = UIColor.white
coordsLabel.backgroundColor = UIColor(red: 58/255, green: 57/255, blue: 54/255, alpha: 0.80)
```

Constraints (volle breedte, geen marge):

```swift
NSLayoutConstraint(item: coordsLabel, attribute: .leading,
    relatedBy: .equal, toItem: self.view, attribute: .leading,
    multiplier: 1, constant: 0).isActive = true
NSLayoutConstraint(item: coordsLabel, attribute: .trailing,
    relatedBy: .equal, toItem: self.view, attribute: .trailing,
    multiplier: 1, constant: 0).isActive = true
```

Tekst update in `locationManager(_:didUpdateLocations:)`:

```swift
let latFormat = String(format: "%.6f", newLocation.coordinate.latitude)
let lonFormat = String(format: "%.6f", newLocation.coordinate.longitude)
let altitude  = newLocation.altitude.toAltitude(useImperial: useImperial)
let knots     = newLocation.speed >= 0
    ? String(format: "%.1f kn", newLocation.speed * 1.94384) : "·.· kn"
coordsLabel.text = "  Lat  \(latFormat)   Lon  \(lonFormat)\n  Alt  \(altitude)   \(knots)"
```

---

## Stap 9 — Instelbaar opname-interval toevoegen

### `Preferences.swift`

Voeg toe bij de UserDefaults keys:
```swift
let kDefaultsKeyTrackInterval: String = "TrackIntervalSeconds"
```

Voeg toe bij de private variabelen:
```swift
private var _trackIntervalSeconds: Double = 1.0
```

Laad in `init()`:
```swift
if let v = defaults.object(forKey: kDefaultsKeyTrackInterval) as? Double {
    _trackIntervalSeconds = max(1.0, v)
}
```

Voeg property toe:
```swift
var trackIntervalSeconds: Double {
    get { return _trackIntervalSeconds }
    set { _trackIntervalSeconds = max(1.0, newValue)
          defaults.set(_trackIntervalSeconds, forKey: kDefaultsKeyTrackInterval) }
}
```

### `ViewController.swift`

Voeg toe als property:
```swift
var lastTrackedDate: Date?
```

Reset bij statuswisseling naar `.tracking`:
```swift
lastTrackedDate = nil
```

Vervang in `didUpdateLocations`, de `if gpxTrackingStatus == .tracking` block:
```swift
if gpxTrackingStatus == .tracking {
    let now = Date()
    if lastTrackedDate == nil || now.timeIntervalSince(lastTrackedDate!) >= Preferences.shared.trackIntervalSeconds {
        lastTrackedDate = now
        map.addPointToCurrentTrackSegmentAtLocation(newLocation)
        totalTrackedDistanceLabel.distance = map.session.totalTrackedDistance
        currentSegmentDistanceLabel.distance = map.session.currentSegmentDistance
    }
}
```

### `PreferencesTableViewController.swift`

Voeg sectie toe (zie volledige implementatie in de broncode van dit project).
Zie `kTrackingSection = 7`, `showTrackIntervalPicker()` en `formatTrackInterval()`.

---

## Stap 10 — Over-pagina aanpassen (`about.html`)

```html
<h1>JOUW APP NAAM</h1>
<h4>Aangepast door <a href="https://github.com/JOUWGITHUB">JOUW NAAM</a></h4>
<h4>Gebaseerd op iOS Open GPX Tracker door<br>
    Juan M. Merlos <a href="http://www.twitter.com/merlos">@merlos</a><br>
    &amp; Vincent Neo <a href="https://www.twitter.com/iVincentNeo">@vincentneo</a></h4>
<p>JOUW BESCHRIJVING VAN DE APP</p>
<p>Broncode beschikbaar op <a href="https://github.com/JOUWGITHUB/JOUWREPO">GitHub</a> onder GPL-licentie.</p>
```

---

## Stap 11 — Taal instellen op simulator

```bash
# Permanent Nederlands instellen op de booted simulator
xcrun simctl spawn booted defaults write -g AppleLanguages -array nl
xcrun simctl spawn booted defaults write -g AppleLocale -string nl_NL
# Herstart de simulator daarna
```

---

## Stap 12 — Bouwen en testen

```bash
# Build voor simulator
xcodebuild -scheme OpenMijnApp \
  -destination 'platform=iOS Simulator,name=iPhone 17,OS=latest' \
  build

# Installeer op booted simulator
xcrun simctl install booted \
  ~/Library/Developer/Xcode/DerivedData/*/Build/Products/Debug-iphonesimulator/OpenMijnApp.app

# Start de app
xcrun simctl launch booted com.mijnbedrijf.MijnApp
```

---

## Stap 13 — Installeren op fysiek apparaat

1. Open het project in Xcode: `open OpenMijnApp.xcodeproj`
2. Sluit je iPhone aan via USB
3. Selecteer je iPhone als doelwit bovenin Xcode
4. Druk op ▶ (Cmd+R)
5. Op je iPhone: **Instellingen → Algemeen → VPN en apparaatbeheer** → vertrouw het certificaat

> Werkt met een gratis Apple ID — geen betaald developer account vereist voor eigen apparaat.

---

## Bekende valkuilen

| Probleem | Oorzaak | Oplossing |
|----------|---------|-----------|
| App crasht bij start | CoreData model naamfout | Inner `.xcdatamodel` map naam moet overeenkomen met `.xccurrentversion` |
| "Embedded binary not prefixed" | Watch Extension bundle ID fout | Controleer exact: `[app].watchkitapp.ext` |
| Crash recovery werkt niet | `retrieveFromCoreData()` gebruikt child context | Gebruik `appDelegate.managedObjectContext.execute()` direct |
| Lege taalstrings | Swapped `.lproj` bestanden | Controleer `nl.lproj` vs `en.lproj` inhoud |
| "not stripping binary" warning | watchOS signing voor strip | Harmloze waarschuwing, geen actie nodig |

---

## Bronvermelding

Gebaseerd op [iOS-Open-GPX-Tracker](https://github.com/merlos/iOS-Open-GPX-Tracker)  
door Juan M. Merlos ([@merlos](https://github.com/merlos)) en Vincent Neo ([@vincentneo](https://github.com/vincentneo))  
Licentie: GPL
