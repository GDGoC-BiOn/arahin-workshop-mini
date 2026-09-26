# Tugas: Implementasi Lupa Password

Branch: `task/forgot-password`

Lengkapi method `_resetPassword()` di `lib/main.dart`. Tombol lupa password
sudah tampil di halaman login.

## Acceptance criteria

- Periksa alamat email yang dimasukkan sebelum memproses permintaan.
- Jangan mewajibkan password untuk menjalankan alur reset.
- Tampilkan konfirmasi yang jelas jika format email valid.
- Tampilkan feedback yang mudah dipahami jika email belum valid.
- Tidak perlu mengirim email sungguhan atau menambahkan backend.
- `flutter analyze` dan `flutter test` tetap lulus.

## Cara mulai

```sh
git switch task/forgot-password
flutter pub get
flutter run
```

Cari komentar `TODO(workshop-forgot-password)` sebagai titik awal.
