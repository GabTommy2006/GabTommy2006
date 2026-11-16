# Profile banner

A personal GitHub calling card for Hoang Phuc Hung / Gabriel Tommy (@GabTommy2006). Surface mode: Experience.

The user explicitly requested a T1-inspired black-to-red gradient, subsequently refined into soft overlapping crimson pools, white Google Sans lettering, English copy, and removal of the previous logo. This brief replaces the earlier paper-and-serif direction.

- Canvas: 1200 × 420.
- Background: #080808 with three elliptical radial fields in #D20A31, #8C0928, and #C90928. Each fades with opacity (1 - radius²)², creating soft irregular pools with dark breathing room.
- All lettering: #FFFFFF.
- Google Sans: 82-unit bold name, 30-unit welcome line, 23-unit handle and signature.
- Copy: “Hoang Phuc Hung”, “Welcome to my GitHub page.”, “@GabTommy2006”, “GABRIEL TOMMY”.
- Composition: left-aligned main name and welcome message; handle and signature anchor the bottom corners. No logo or decorative symbol.
- Fonts: official Google Fonts source, https://github.com/google/fonts/tree/main/ofl/googlesans. Font and licensing files are in assets/fonts.
- Export: tools/render-banner.ps1 loads Google Sans privately and converts all lettering to SVG paths. Winding fill preserves overlapping glyph contours. No installed fonts, scripts, or network are needed to display the SVG.
- Preview: assets/profile-banner.png uses the same path geometry and radial opacity falloff. The README embeds the SVG.

The fixed composition scales with GitHub's content column; supporting text becomes smaller on phones. README text beneath the banner provides an accessible, reflowable introduction.
