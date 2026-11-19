# BVK Tracker — volgende versie: niet vergeten (pre-release-check 19 nov 2026)

Stand: 2.2.1 live (min iOS 15).

- [x] **Privacy-URL wijst naar de homepage `cafferata.info`** i.p.v. een privacybeleid (Guideline 5.1.1-risico).
      Via de API niet te wijzigen op een live versie (409). De juiste URL's staan nu in
      `fastlane/metadata/*/privacy_url.txt` (+ support/marketing) → gaan mee met de volgende `fastlane`-metadata-push.
      Zo niet: in ASC → App-informatie → Privacybeleid-URL handmatig zetten op
      `https://cafferata.info/bvk-tracker/privacy.html` (NL) / `.../en/privacy.html` (EN).
- [ ] **ASO:** zoekwoorden zijn maar 11 tekens en de ondertitel is leeg (EN+NL) — veel gemiste vindbaarheid.
- [ ] Screenshots alleen in NL; EN-listing toont NL-beelden.
- [ ] Pre-release-check (skill `pre-release-app-review`) vóór indienen.
