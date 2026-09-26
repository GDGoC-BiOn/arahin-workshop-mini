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
kredensial sungguhan. Bagian berikut adalah referensi jika tugas dikembangkan
untuk terhubung ke API Arah.in.

## API autentikasi Arah.in

Base URL backend lokal adalah `http://localhost:8080`. Jalankan backend dan
database terlebih dahulu; panduannya ada di
[`arahin-backend`](https://github.com/GDGoC-BiOn/arahin-backend#Getting-started).
Contoh di bawah menggunakan `curl` dan JSON.

```sh
API_BASE_URL=http://localhost:8080
```

### Register — `POST /v1/auth/register`

Request:

```sh
curl -i -X POST "$API_BASE_URL/v1/auth/register" \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "peserta@example.com",
    "password": "belajar123",
    "fullName": "Nama Peserta"
  }'
```

Email harus valid, password minimal 8 karakter, dan `fullName` wajib diisi.
Register yang berhasil sekaligus membuka sesi, jadi tidak perlu langsung login
lagi.

Response `201 Created`:

```json
{
  "user": {
    "id": "<user-id>",
    "email": "peserta@example.com",
    "fullName": "Nama Peserta"
  },
  "accessToken": "<jwt>"
}
```

### Login — `POST /v1/auth/login`

Request:

```sh
curl -i -X POST "$API_BASE_URL/v1/auth/login" \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "peserta@example.com",
    "password": "belajar123"
  }'
```

Response `200 OK` memiliki bentuk yang sama seperti response register (`user`
dan `accessToken`). Simpan token untuk request terautentikasi, kirimkan sebagai
`Authorization: Bearer <jwt>`, dan jangan log atau bagikan token tersebut.
Login baru akan menggantikan sesi aktif sebelumnya untuk akun yang sama.

### Lupa password — `POST /v1/auth/forgot-password`

Route ini **belum tersedia di backend Arah.in**; request ke backend saat ini
akan mendapat `404 Not Found`. Karena itu belum ada request/response API resmi
untuk mengirim tautan reset password.

App Flutter Arah.in memiliki mock lokal untuk route ini dengan request berbentuk
`{"email":"peserta@example.com"}` dan response mock `{"message":"oke"}`.
Itu hanya perilaku mock—jangan anggap sebagai dukungan API backend atau gunakan
response tersebut sebagai kontrak produksi. Untuk branch tugas workshop,
lakukan demo reset password secara lokal sampai backend menyediakan endpoint.

### Error API

Error memakai format JSON yang sama untuk semua endpoint:

```json
{
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "email or password is incorrect"
  }
}
```

Status yang umum:

| Endpoint | Status | Arti |
| --- | --- | --- |
| Register | `400 INVALID_BODY` | Email, password, atau nama tidak memenuhi validasi. |
| Register | `409 EMAIL_TAKEN` | Email sudah terdaftar. |
| Login | `400 INVALID_BODY` | Body atau field wajib tidak valid. |
| Login | `401 INVALID_CREDENTIALS` | Email atau password salah. |
| Login/Register | `503 DATABASE_UNAVAILABLE` | Database backend belum tersedia. |
| Forgot password | `404` | Route belum diimplementasikan di backend. |

Kontrak lengkap dan perubahan terbaru ada di
[`arahin-backend/api/API.md`](https://github.com/GDGoC-BiOn/arahin-backend/blob/main/api/API.md)
dan [OpenAPI spec](https://github.com/GDGoC-BiOn/arahin-backend/blob/main/api/openapi.yaml).
