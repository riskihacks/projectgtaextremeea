# Handoff untuk AI cloud build

## Permintaan pemilik

Repo: https://github.com/riskihacks/projectgtaextremeea
Target: iPhone 15 Pro, iOS 27, JIT melalui StikDebug.
Buat IPA iOS sungguhan dari source ini. Jangan mengemas launcher kosong atau mengklaim GTA sudah kompatibel sebelum diuji.

## UI sudah diimplementasikan

`app/Madeira/ContentView.swift` memuat `GTAMainMenu` langsung dalam file yang sudah menjadi anggota target Xcode, sehingga tidak membutuhkan penambahan file ke project.

- Menu gelap dengan aksen hijau, judul GTA Extreme Indonesia dan nama riskidr999.
- Instagram @riskidr999 di kanan atas, menuju https://www.instagram.com/riskidr999/ melalui SwiftUI Link. iOS menentukan apakah membuka aplikasi Instagram atau browser.
- Pesan awal: Silakan enable JIT dulu.
- Enable JIT memakai fungsi upstream `enableJIT()` dan JITCoordinator/StikDebug, tanpa bypass signing.
- Mulai Game dinonaktifkan sebelum `StikJITHelper.ready` benar. Status dibaca ulang setiap detik dan diperiksa lagi saat tombol ditekan.
- Tidak ada autostart saat aplikasi dibuka atau kembali dari Instagram/StikDebug. Pengguna menekan Mulai Game setelah JIT siap.
- Pengaturan & file game membuka library upstream; Menu GTA kembali ke menu pembuka.
- Mode ini diaktifkan oleh GTADedicatedMode=true pada Info.plist.

## Pekerjaan build yang masih HARUS dilakukan

1. Baca docs/BUILDING.md, docs/WOW64.md, docs/JIT.md, LICENSE dan THIRD-PARTY-NOTICES.md. Root repo adalah snapshot Madeira dari commit upstream yang dicantumkan di README.
2. Gunakan macOS/Xcode cloud. Inisialisasi submodule sesuai commit yang dipin. Jika commit tidak tersedia di fork upstream, laporkan blocker dan cari source yang benar; jangan mengganti fork dengan upstream generik tanpa mengadaptasi patch iOS-nya.
3. Lengkapi toolchain dan semua library native yang diabaikan Git, termasuk FEX, Wine, DXMT, FFmpeg dan pairing jika target memerlukannya. GTA SA adalah x86 32-bit: pastikan i386-windows, WoW64 dan modul FEX xtajit.dll dibangun/disertakan. Jalur x64 saja tidak cukup.
4. Jalankan pemeriksaan upstream yang relevan dan compile SwiftUI. Perbaiki error compile nyata, termasuk availability API jika perlu. Jangan menghilangkan JIT gate hanya agar build lolos.
5. Gunakan konfigurasi Debug terlebih dahulu: upstream mencatat crash pada Release. Contoh entry point setelah seluruh dependensi siap:

   xcodebuild -project app/Madeira.xcodeproj -scheme Madeira -configuration Debug -destination 'generic/platform=iOS' -derivedDataPath build/gta-derived CODE_SIGNING_ALLOWED=NO build

   Ini hanya entry point, bukan jaminan build berhasil. Jika Xcode meminta signing untuk extension/framework, tangani sesuai project dan lingkungan.
6. Setelah sukses, kemas produk .app beserta framework/resources/extension yang lengkap di Payload/<app>.app menjadi IPA. Untuk distribusi unsigned jelaskan bahwa pengguna masih harus menandatangani dengan provisioning development/debuggable yang valid. Jangan sertakan certificate/private key/pairing file ke repo atau artifact publik.
7. StikDebug memerlukan executable yang debuggable dan skrip Madeira yang sesuai. Menempelkan entitlement get-task-allow pada signature distribution tidak menjamin debugger bisa attach. Ikuti docs/JIT.md; pertahankan helper extension dan bundle identifier yang konsisten.
8. Upload IPA sebagai artifact cloud dan laporkan commit, hasil build, ukuran/hash IPA, serta bagian yang belum diuji di perangkat.

## Game dan pengujian

File GTA berukuran 4,79 GB tidak berada di GitHub. Pengguna memiliki salinan lokal. Gunakan gta-port/Prepare-Game.ps1 bila perlu membuat salinan tanpa tambahan ReShade/DLSS. Jangan mengunduh atau mempublikasikan game ke repo.

Lokasi game di perangkat: Documents/wine/drive_c/Games/GTAExtremeIndonesia/gta_sa.exe beserta seluruh data pendamping. Saat Mulai Game ditekan, launchDedicatedGTA membuat/memakai entry library 32-bit pada 800x600, lalu melewati launchLibraryEntry dan gate JIT upstream.

Uji di iPhone: cold start menampilkan menu; game tidak mulai tanpa JIT; kegagalan StikDebug ditampilkan; JIT siap membuka tombol; Instagram menuju akun yang benar; kembali dari Instagram tidak memulai game; file game hilang menampilkan pesan; library/settings dan tombol kembali berfungsi; portrait/landscape, safe area dan ukuran teks besar tidak memotong tombol. Jalankan game dasar dahulu, lalu verifikasi CLEO/ASI satu per satu. Tidak ada hasil gameplay atau FPS yang sudah terbukti.

## Validasi yang sudah dilakukan di Windows

Diff whitespace check dan parse XML Info.plist. Source launch/JIT diperiksa. Swift/Xcode build dan visual QA di simulator/perangkat BELUM dilakukan. Lanjutkan verifikasi itu di cloud; jangan menyatakan pekerjaan ini tinggal klik build atau sudah playable.
