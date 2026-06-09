# BVK GPX Tracker — Claude instructies

## Projectoverzicht
iOS + WatchOS GPX tracker app voor BVK (de Blocq van Kuffeler).
Registreert GPS-sporen op het water, slaat op als GPX, deelt via e-mail/AirDrop.

## Eigenaar
- **Ed Cafferata** (edcafferata@icloud.com) — developer
- **Team ID:** `9J2S23WJH3`

## Locatie & build
- **Project:** `/Volumes/Backup-Ed/AI/BVK-GpxTracker/`
- **Xcode project:** `OpenBVKTracker.xcodeproj`
- **Bundle ID:** `info.cafferata.BvkGpxTracker`
- **GitHub:** https://github.com/EdCafferata/BVK-GpxTracker — branch: `main`
- **Versie:** `2.2.0` (in ontwikkeling, nog niet uitgebracht op App Store)
- **Live versie:** `2.1.2`
- **Simulator ID:** `F6112483-4A4A-457E-8710-B0CAC169B941` (iPhone 16, iOS 18.6)

### Build commando's
```bash
# Simulator
cd /Volumes/Backup-Ed/AI/BVK-GpxTracker
xcodebuild -project OpenBVKTracker.xcodeproj -scheme "OpenBVKTracker" \
  -destination "platform=iOS Simulator,id=F6112483-4A4A-457E-8710-B0CAC169B941" build

# TestFlight archive
xcodebuild -project OpenBVKTracker.xcodeproj -scheme "OpenBVKTracker" \
  -configuration Release -archivePath /tmp/BVK-GpxTracker.xcarchive archive
# → daarna Xcode Organizer → Distribute App → App Store Connect
```

### Xcode 26.5 workaround (watchOS simulator)
`EXCLUDED_ARCHS[sdk=watchsimulator*]` toegevoegd aan Watch + Watch Extension Release config.
Reden: Xcode 26.5 vereist watchOS 26.5 simulator die nog niet beschikbaar is.

## Sessie start (ALTIJD uitvoeren)
1. `git -C /Volumes/Backup-Ed/AI/BVK-GpxTracker fetch origin && git -C /Volumes/Backup-Ed/AI/BVK-GpxTracker pull origin main`
2. Lees dit bestand + `README.md`
3. Meld wat er nieuw is t.o.v. vorige sessie

## Sessie einde (ALTIJD uitvoeren)
1. `git add -A && git commit && git push`
2. Werk `CLAUDE.md` bij
3. Update memory: `/Users/edcafferata/.claude/projects/-Volumes-Backup-Ed-AI-Tattoe-tattoe/memory/project_bvk_tracker.md`

---

## Stack
- **iPhone app:** UIKit, `ViewController.swift` (1500+ regels)
- **Watch app:** WatchKit, `InterfaceController.swift`
- **Kaartservers:** Apple, OpenStreetMap, OpenSeaMap, CartoDB, OpenTopoMap
- **Tile caching:** MapCache package
- `NSAllowsArbitraryLoads = true` in Info.plist (vereist voor HTTP tile servers)

## Architectuur — ViewController.swift (iPhone)
- `speedReadings: [(date: Date, speedMs: Double)]` — sliding window 60s voor snelheidszoom
- `mapUpdateTimer: Timer?` — vuurt elke 10 seconden
- `startMapUpdateTimer()` / `stopMapUpdateTimer()` / `updateMapRegionForSpeed()`
- Snelheids-drempelwaarden kaart-zoom:
  - <0.5kn → 0.002°
  - 0.5-2kn → 0.005°
  - 2-5kn → 0.010°
  - 5-8kn → 0.018°
  - ≥8kn → 0.030°
  - Zoom past alleen aan als verschil >20% (geen springende kaart)

## Reset actieblad (iPhone + Watch)
Volgorde: **Doorgaan** → Opslaan & nieuw → Verwijderen (destructief) → Annuleren
- `CONTINUE_SESSION` sleutel aanwezig in alle 11 taalbestanden

## Talen (11 stuks)
`nl, en, de, es, fr, it, fi-FI, pt-BR, ru, uk, zh-Hans`
Strings in `OpenBVKTracker/<taal>.lproj/Localizable.strings`

## Bestanden
- `CLAUDE.md` — dit bestand, auto-geladen door Claude Code
- `README.md` — publieke beschrijving
- `BOUW_HANDLEIDING.md` — stap-voor-stap bouwhandleiding
- `AANPASSING_TEMPLATE.md` — template voor aanpassingen

## Feature status
- [x] GPX tracking (iPhone + Watch)
- [x] Kaartservers: Apple, OSM, OpenSeaMap, CartoDB, OpenTopoMap
- [x] **CartoDB Dark Matter** kaartlaag voor nachtelijk varen — issue #10 gesloten
- [x] Snelheidsgebaseerde kaart-zoom (losgekoppeld van opname-interval)
- [x] Snelheids-zoom stopt bij pauze/reset, herstart bij recording — issue #9 gesloten
- [x] "Doorgaan" optie in reset actieblad (iPhone + Watch)
- [x] 11 talen
- [x] Standaard activiteitstype `.otherNavigation` (was `.other`) — issue #5 gesloten
- [x] Scherm altijd aan standaard ingeschakeld — issue #6 gesloten
- [x] OpenSeaMap max zoom 16 → 18 — issue #8 gesloten
- [x] iOS min. versie gedocumenteerd als 12+ (was fout: 17+) — issue #4 gesloten
- [x] TestFlight build 1.10.1 (build 3) geüpload (2026-05-22)
- [x] Versie bump naar 2.0.0 (build 1) — 2026-05-25
- [x] EXCLUDED_ARCHS watchOS simulator workaround (Xcode 26.5) — 2026-05-25
- [x] Fysiek apparaat getest (Ed, 2026-05-29)
- [x] TestFlight 2.0.0 geüpload en testers uitgenodigd (Ed, 2026-05-29)
- [x] **Versie 2.0.0 live in de App Store** (Ed, 2026-05-29) 🎉

## Nieuw in v2.2.0 (in ontwikkeling, nog niet uitgebracht)
- [x] **OWM kleurlegenda** — kleine kleurschaal in kaarthoek bij actieve OWM overlay (`OWMLegendView.swift`)
- [x] **Windsnelheid kn op windpijl** — knotenwaarde onder Beaufort-cirkel (`WindAnnotation.swift`)
- [x] **Neerslag mm/uur** — live neerslag in infobalk rechtsonder via Open-Meteo (`precipitation`)
- [x] **Info-knop verplaatst** — zelfde rij als folder/prefs/share knoppen
- [x] Frank toegevoegd als tester in About-scherm

## Open issues (backlog)
- [ ] #11 ViewController.swift refactoren (1650+ regels)
- [ ] #13 App Store Connect: screenshots bijwerken
