# Arahin Workshop Mini

Starter Flutter app kecil untuk latihan fitur autentikasi. UI form login dan
registrasi sudah tersedia; tiap branch tugas menyediakan handler yang sengaja
belum diimplementasikan.

## Menjalankan aplikasi

```sh
flutter pub get
flutter run
```

Jalankan pemeriksaan sebelum mengumpulkan tugas:

```sh
flutter analyze
flutter test
```

## Branch tugas

Tiap branch dibuat langsung dari `main`, jadi tugas bisa dikerjakan secara
terpisah. Pilih salah satu branch untuk memulai:

| Branch | Tugas |
| --- | --- |
| `task/login` | Implementasikan login email/password dan feedback berhasil/gagal. |
| `task/register` | Implementasikan pendaftaran akun dan feedback hasilnya. |
| `task/forgot-password` | Implementasikan alur permintaan reset password. |

Contoh memilih tugas:

```sh
git switch task/login
```

Detail acceptance criteria ada di `docs/tasks/` pada branch tugas masing-masing.
Cari komentar `TODO(workshop-...)` di kode untuk menemukan titik mulai.

Semua autentikasi di workshop ini bersifat demo lokal; tidak ada backend atau
kredensial sungguhan.
