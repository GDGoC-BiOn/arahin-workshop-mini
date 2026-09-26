# Tugas: Implementasi Login

Branch: `task/login`

Lengkapi method `_login()` di `lib/main.dart` agar form menggunakan API Arah.in.
Sebelum mulai, baca bagian **Panduan partisipan** dan **API autentikasi Arah.in**
di root `README.md`.

## Acceptance criteria

- Kirim `POST /v1/auth/login` dengan JSON `email` dan `password` ke base URL dari
  `API_BASE_URL`.
- Saat menerima `200`, baca `user` dan `accessToken` dari response dan tampilkan
  feedback berhasil.
- Tangani `401 INVALID_CREDENTIALS`, error validasi, dan kegagalan koneksi dengan
  pesan yang mudah dipahami.
- Tampilkan state loading selama request dan cegah submit berulang.
- Jangan hardcode atau mencetak access token ke log.
- Uji sukses dan error tanpa bergantung pada server live.
- `flutter analyze` dan `flutter test` tetap lulus.

## Cara mulai

```sh
git switch task/login
flutter pub get
flutter run
```

Cari komentar `TODO(workshop-login)` sebagai titik awal.
