# Tugas: Implementasi Registrasi

Branch: `task/register`

Lengkapi method `_register()` di `lib/main.dart` agar form menggunakan API
Arah.in. Sebelum mulai, baca bagian **Panduan partisipan** dan **API autentikasi
Arah.in** di root `README.md`.

## Acceptance criteria

- Kirim `POST /v1/auth/register` dengan JSON `fullName`, `email`, dan `password`
  ke base URL dari `API_BASE_URL`.
- Saat menerima `201`, baca `user` dan `accessToken` dari response. Register
  langsung membuka sesi sehingga tidak perlu request login tambahan.
- Tangani `400 INVALID_BODY`, `409 EMAIL_TAKEN`, dan kegagalan koneksi dengan
  pesan yang mudah dipahami.
- Tampilkan state loading selama request dan cegah submit berulang.
- Jangan hardcode atau mencetak access token ke log.
- Uji sukses dan error tanpa bergantung pada server live.
- `flutter analyze` dan `flutter test` tetap lulus.

## Cara mulai

```sh
git switch task/register
flutter pub get
flutter run
```

Cari komentar `TODO(workshop-register)` sebagai titik awal.
