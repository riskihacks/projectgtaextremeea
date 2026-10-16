# projectgtaextremeea

Experimental GTA Extreme Indonesia launcher for iOS, based on Madeira.

**Status: source prototype only. No custom IPA has been built and GTA gameplay on iOS has not been verified.**

Target device reported by the user: iPhone 15 Pro, iOS 27, StikDebug.

## Changes

- Dedicated GTA mode in Info.plist.
- Opens a riskidr999 main menu with an Instagram link and JIT prompt; Play selects `Games/GTAExtremeIndonesia/gta_sa.exe` after JIT is ready.
- Uses Madeira's existing launch validation and JIT/StikDebug flow.
- Starts with a 32-bit, 800x600 profile and touch controls enabled.
- Provides a Windows preparation script which copies the game separately and excludes added ReShade/DLSS files.

See [preparation and current build blockers](gta-port/README.md).

## Build status

This is not a ready-to-build standalone game. Complete the upstream native libraries/toolchains and 32-bit WoW64 components described in [BUILDING](docs/BUILDING.md) and [WOW64](docs/WOW64.md), then compile with macOS/Xcode. Upstream documentation records incomplete clean-checkout reproducibility. Moving the project to GitHub does not fix those dependencies automatically.

The Windows game, the local 4.79 GB staging copy, pairing credentials, signing certificates, and downloaded IPA are not included. Keep your game files local and import them separately. CLEO/ASI plugin compatibility is unknown.

## Upstream and license

Based on [willfaust/Madeira](https://github.com/willfaust/Madeira), source snapshot `279fd0f83170425db002fe25d6bd62f6355f497d`. Original documentation is preserved in [README-MADEIRA.md](README-MADEIRA.md).

See [LICENSE](LICENSE), [LICENSE-EXCEPTION.md](LICENSE-EXCEPTION.md) and [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md). Existing component licenses and credits are retained. No claim of original authorship of the emulator is made.

## Cloud AI handoff

See [AI-CLOUD-HANDOFF.md](gta-port/AI-CLOUD-HANDOFF.md) for the requested UI, exact launch flow, outstanding dependencies, build entry point, signing requirements, and device checks.
