# Tugas: Implementasi Lupa Password

Branch: `task/forgot-password`

Lengkapi method `_resetPassword()` di `lib/main.dart` agar tombol mencoba
menggunakan API. Sebelum mulai, baca bagian **Panduan partisipan** dan **API
autentikasi Arah.in** di root `README.md`.

## Acceptance criteria

- Validasi email sebelum mengirim request, tanpa mewajibkan password.
- Kirim `POST /v1/auth/forgot-password` dengan JSON `{"email":"..."}` ke base
  URL dari `API_BASE_URL`.
- Backend Arah.in saat ini belum memiliki route tersebut dan akan menjawab
  `404`. Tampilkan pesan bahwa fitur belum didukung; jangan tampilkan sukses
  seolah-olah email reset sudah terkirim.
- Jika fasilitator menyediakan server/mock yang mengimplementasikan endpoint,
  tampilkan feedback sukses hanya setelah response sukses.
- Uji validasi email dan penanganan response `404` tanpa bergantung pada server
  live.
- `flutter analyze` dan `flutter test` tetap lulus.

## Cara mulai

```sh
git switch task/forgot-password
flutter pub get
flutter run
```

Cari komentar `TODO(workshop-forgot-password)` sebagai titik awal.
