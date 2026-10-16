# GTA Extreme Indonesia: experimental dedicated iOS runtime

STATUS: SOURCE CHANGES ONLY. No IPA has been built; GTA has not been run on iOS.

Based on https://github.com/willfaust/Madeira (see LICENSE and upstream notices).

Changes:
- Dedicated mode is enabled by GTADedicatedMode in Info.plist.
- On initial appearance, selects Games/GTAExtremeIndonesia/gta_sa.exe.
- Registers a 32-bit game profile at 800x600, touch controls enabled, DirectInput controller mode.
- Uses upstream launchLibraryEntry -> jitReadyForLaunch -> startLibraryEntry; does not bypass StikDebug or fabricate JIT success.
- Attempts automatic launch once per app process. Errors leave the existing library available for retry/settings. Missing files produce an Indonesian message.
- Existing game profile settings are preserved.

Prepare game on Windows (use a NEW output folder outside the original game):

    ./gta-port/Prepare-Game.ps1 -GameDirectory 'C:\Program Files (x86)\GTAind Naufal\GTA Extreme Indonesia v7.1' -OutputDirectory 'C:\Users\riskidr99\GTAExtremeIndonesia'

Copy the resulting GTAExtremeIndonesia folder into the app's Documents/wine/drive_c/Games using Files. This copy excludes the added ReShade/DLSS files, but preserves original game scripts/plugins. Their compatibility is UNKNOWN. The originals are never edited. The app does not download or bundle the game.

Build prerequisites and blockers:
- Follow docs/BUILDING.md and docs/WOW64.md, including the 32-bit Wine/FEX components required by GTA SA.
- The current Windows host has no xcodebuild; compilation/signing/device testing cannot be performed here.
- Upstream BUILDING.md records missing external toolchains, ignored archives and submodule availability problems. These must be resolved before a reproducible build.
- Use the upstream Debug configuration: upstream documents problems with Release.
- Existing StikDebug support requires its custom Madeira script and correct signing/debug permissions. Ordinary IPA signing alone does not guarantee that debugging is available.

Validation here: source diff whitespace check, plist XML parse and source inspection of the JIT gate. No Swift compilation, gameplay/performance testing, CLEO compatibility testing or IPA signing has been performed.
