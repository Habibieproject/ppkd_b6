import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b6/constant/app_color.dart';
import 'package:ppkd_b6/day_35/models/user_model.dart';
import 'package:ppkd_b6/day_35/services/auth_service.dart';
import 'package:ppkd_b6/day_35/services/dio_client.dart';

class EditProfileScreenDay35 extends StatefulWidget {
  final UserModel user;

  const EditProfileScreenDay35({super.key, required this.user});

  @override
  State<EditProfileScreenDay35> createState() => _EditProfileScreenDay35State();
}

class _EditProfileScreenDay35State extends State<EditProfileScreenDay35> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  late final AuthService _authService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(createDioClient());
    _nameController = TextEditingController(text: widget.user.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final result = await _authService.updateProfile({
        'name': _nameController.text.trim(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message ?? 'Profil berhasil diperbarui')),
      );
      // Pop dengan result true agar ProfileScreen tahu harus refresh
      Navigator.pop(context, true);
    } on DioException catch (e) {
      final message =
          e.response?.data?['message']?.toString() ??
          'Gagal memperbarui profil';
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Ubah Profil',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Perbarui nama profil Anda',
                style: TextStyle(color: AppColor.greyText),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _isLoading ? null : _updateProfile,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Simpan Perubahan',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
