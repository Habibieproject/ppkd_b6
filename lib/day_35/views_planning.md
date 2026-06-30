# Perencanaan Views - Day 35

Berdasarkan API contract dari `A Latihan PPKDss B3.postman_collection.json` dan implementasi `auth_service.dart`, berikut adalah rencana struktur dan spesifikasi UI (Views) yang dibutuhkan:

## Struktur Folder `views`

Sebaiknya views dipisahkan menjadi dua fitur utama: autentikasi dan profil, agar lebih rapi.

```text
lib/day_35/views/
├── auth/
│   ├── login_screen.dart
│   └── register_screen.dart
└── profile/
    ├── profile_screen.dart
    └── edit_profile_screen.dart
```

---

## Spesifikasi Layar (Screens)

### 1. Register Screen (`register_screen.dart`)
- **Tujuan**: Mendaftarkan pengguna baru ke sistem (`POST /api/register`).
- **Form Input**:
  - `Name` (TextField)
  - `Email` (TextField dengan tipe email)
  - `Password` (TextField dengan mode *obscure/hidden*)
- **Aksi/Tombol**:
  - Tombol **"Register"**: Memanggil `authService.register({"name": name, "email": email, "password": password})`.
  - Link/Tombol navigasi: **"Sudah punya akun? Login"** (Mengarahkan ke `login_screen.dart`).
- **Handling Respons API**:
  - **Sukses (200 OK)**: Tampilkan *Snackbar* "Registrasi berhasil", simpan token dari JSON response ke `TokenStorage.saveToken(token)`, lalu arahkan user ke `profile_screen.dart`.
  - **Gagal (422 Unprocessable Content)**: Tangkap pesan error API (misal: "Email sudah terdaftar" atau field kosong) dan tampilkan di UI sebagai *error text* di TextField atau dialog.

### 2. Login Screen (`login_screen.dart`)
- **Tujuan**: Autentikasi pengguna (`POST /api/login`).
- **Form Input**:
  - `Email` (TextField dengan tipe email)
  - `Password` (TextField dengan mode *obscure/hidden*)
- **Aksi/Tombol**:
  - Tombol **"Login"**: Memanggil `authService.login({"email": email, "password": password})`.
  - Link/Tombol navigasi: **"Belum punya akun? Register"** (Mengarahkan ke `register_screen.dart`).
- **Handling Respons API**:
  - **Sukses (200 OK)**: Tampilkan pesan "Login berhasil", simpan token ke `TokenStorage.saveToken(token)`, lalu navigasikan ke `profile_screen.dart`.
  - **Gagal (401 / 404)**: Tampilkan pesan error seperti "Email atau password salah" atau "Email belum terdaftar" menggunakan *Snackbar* atau Dialog.

### 3. Profile Screen (`profile_screen.dart`)
- **Tujuan**: Menampilkan data profil pengguna saat ini (`GET /api/profile`).
- **Data yang Ditampilkan**:
  - Berdasarkan response `authService.getProfile()`, UI akan menampilkan informasi dari class `UserModel`:
    - `Name`
    - `Email`
- **Aksi/Tombol**:
  - Tombol **"Edit Profile"**: Membuka `edit_profile_screen.dart` sambil membawa data profil saat ini.
  - Tombol **"Logout"**: Menjalankan fungsi logout secara lokal (menghapus token via `TokenStorage.clearToken()`) lalu menendang/mengarahkan user kembali ke `login_screen.dart`.
- **Handling Status**:
  - Saat diakses, layar harus memanggil endpoint GET profile. Selama menembak API, tampilkan `CircularProgressIndicator`.
  - Jika mendapat error **401 Unauthenticated** (token expire/tidak valid), otomatis hapus token dan redirect ke `login_screen.dart`.

### 4. Edit Profile Screen (`edit_profile_screen.dart`)
- **Tujuan**: Memperbarui data profil pengguna (`PUT /api/profile`).
- **Form Input**:
  - Sesuai body request Postman, endpoint ini hanya bisa mengubah **Name**.
  - `Name` (TextField) - Default nilainya diisi dengan data nama pengguna yang didapat dari halaman profil sebelumnya.
- **Aksi/Tombol**:
  - Tombol **"Save Changes"**: Memanggil `authService.updateProfile({"name": newName})`.
- **Handling Respons API**:
  - **Sukses (200 OK)**: Menampilkan pesan "Profil berhasil diperbarui", lalu UI akan pop/kembali ke `profile_screen.dart` (layar profile perlu refresh data otomatis).
  - **Gagal (422)**: Menampilkan error validasi misal field kosong ("Nama wajib diisi").
