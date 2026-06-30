import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b6/constant/app_color.dart';
import 'package:ppkd_b6/day_35/models/user_model.dart';
import 'package:ppkd_b6/day_35/services/auth_service.dart';
import 'package:ppkd_b6/day_35/services/dio_client.dart';
import 'package:ppkd_b6/day_35/services/token_storage.dart';
import 'package:ppkd_b6/day_35/views/auth/login_screen.dart';
import 'package:ppkd_b6/day_35/views/profile/edit_profile_screen.dart';
import 'package:ppkd_b6/extension/navigator.dart';

class ProfileScreenDay35 extends StatefulWidget {
  const ProfileScreenDay35({super.key});

  @override
  State<ProfileScreenDay35> createState() => _ProfileScreenDay35State();
}

class _ProfileScreenDay35State extends State<ProfileScreenDay35> {
  late final AuthService _authService;
  bool _isLoading = true;
  UserModel? _user;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(createDioClient());
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _authService.getProfile();
      if (!mounted) return;
      setState(() {
        _user = result.data;
        _isLoading = false;
      });
    } on DioException catch (e) {
      if (!mounted) return;

      // Jika 401 Unauthenticated, hapus token dan redirect ke login
      if (e.response?.statusCode == 401) {
        await TokenStorage.clearToken();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sesi berakhir, silakan login kembali')),
        );
        context.pushReplacement(const LoginScreenDay35());
        return;
      }

      final message =
          e.response?.data?['message']?.toString() ??
          'Gagal mengambil data profil';
      setState(() {
        _errorMessage = message;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await TokenStorage.clearToken();
    if (!mounted) return;
    context.pushAndRemoveAll(const LoginScreenDay35());
  }

  Future<void> _navigateToEditProfile() async {
    if (_user == null) return;
    final result = await context.push(EditProfileScreenDay35(user: _user!));
    // Jika kembali dengan result true, berarti profil berhasil diupdate
    if (result == true) {
      _fetchProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _isLoading ? null : _logout,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _fetchProfile,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (_user == null) {
      return const Center(child: Text('Data profil tidak tersedia'));
    }

    return RefreshIndicator(
      onRefresh: _fetchProfile,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          // Avatar
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColor.primaryColor,
              child: Text(
                (_user!.name ?? '?')[0].toUpperCase(),
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Nama
          _buildInfoCard(
            icon: Icons.person_outline,
            label: 'Nama',
            value: _user!.name ?? '-',
          ),
          const SizedBox(height: 12),

          // Email
          _buildInfoCard(
            icon: Icons.email_outlined,
            label: 'Email',
            value: _user!.email ?? '-',
          ),
          const SizedBox(height: 32),

          // Tombol Edit Profile
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _navigateToEditProfile,
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),

          // Tombol Logout
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Colors.red),
            ),
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: AppColor.primaryColor),
        title: Text(label, style: const TextStyle(fontSize: 12, color: AppColor.greyText)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
