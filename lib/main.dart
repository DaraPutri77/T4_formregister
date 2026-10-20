
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiRegistrasi());
}

class AplikasiRegistrasi extends StatelessWidget {
  const AplikasiRegistrasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Registrasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
      home: const HalamanRegistrasi(),
    );
  }
}

class HalamanRegistrasi extends StatefulWidget {
  const HalamanRegistrasi({super.key});

  @override
  State<HalamanRegistrasi> createState() =>
      _HalamanRegistrasiState();
}

class _HalamanRegistrasiState extends State<HalamanRegistrasi> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _namaFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  String? _jenisKelamin;
  String? _programStudi;
  bool _setuju = false;
  bool _passwordTerlihat = false;

  final List<String> _daftarProdi = [
    'Sistem Informasi',
    'Teknik Informatika',
    'Sistem Elektronika',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _namaFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  void _daftar() {
    if (!_setuju) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Silakan setujui Syarat & Ketentuan terlebih dahulu.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.fact_check_outlined,
            size: 40,
          ),
          title: const Text('Konfirmasi Registrasi'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Periksa kembali data yang kamu masukkan.',
                ),
                const SizedBox(height: 16),
                _barisRingkasan(
                  'Nama Lengkap',
                  _namaController.text.trim(),
                ),
                _barisRingkasan(
                  'Email',
                  _emailController.text.trim(),
                ),
                _barisRingkasan(
                  'Password',
                  '•' * _passwordController.text.length,
                ),
                _barisRingkasan(
                  'Jenis Kelamin',
                  _jenisKelamin!,
                ),
                _barisRingkasan(
                  'Program Studi',
                  _programStudi!,
                ),
                _barisRingkasan(
                  'Syarat & Ketentuan',
                  'Disetujui',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Periksa Lagi'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    ).then((dikonfirmasi) {
      if (!mounted || dikonfirmasi != true) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Registrasi berhasil dikonfirmasi!',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
    });
  }

  Widget _barisRingkasan(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            isi,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),
      appBar: AppBar(
        title: const Text('Form Registrasi'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6F4FB),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.person_add_alt_1,
                          size: 54,
                          color: Color(0xFF6750A4),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Buat Akun Baru',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Lengkapi data berikut untuk mendaftar.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 28),

                        // Nama lengkap
                        const Text(
                          'Nama Lengkap',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _namaController,
                          focusNode: _namaFocus,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama lengkap',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            _emailFocus.requestFocus();
                          },
                        ),
                        const SizedBox(height: 18),

                        // Email
                        const Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'nama@email.com',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!value.contains('@')) {
                              return 'Email harus mengandung @';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            _passwordFocus.requestFocus();
                          },
                        ),
                        const SizedBox(height: 18),

                        // Password
                        const Text(
                          'Password',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: !_passwordTerlihat,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'Minimal 6 karakter',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              tooltip: _passwordTerlihat
                                  ? 'Sembunyikan password'
                                  : 'Tampilkan password',
                              icon: Icon(
                                _passwordTerlihat
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordTerlihat =
                                  !_passwordTerlihat;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        const SizedBox(height: 22),

                        // Jenis kelamin
                        const Text(
                          'Jenis Kelamin',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        FormField<String>(
                          initialValue: _jenisKelamin,
                          validator: (value) {
                            if (value == null) {
                              return 'Pilih jenis kelamin';
                            }
                            return null;
                          },
                          builder: (field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadioGroup<String>(
                                  groupValue: _jenisKelamin,
                                  onChanged: (value) {
                                    setState(() {
                                      _jenisKelamin = value;
                                    });
                                    field.didChange(value);
                                  },
                                  child: const Column(
                                    children: [
                                      RadioListTile<String>(
                                        title: Text('Laki-laki'),
                                        value: 'Laki-laki',
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                      ),
                                      RadioListTile<String>(
                                        title: Text('Perempuan'),
                                        value: 'Perempuan',
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                      ),
                                    ],
                                  ),
                                ),
                                if (field.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                    ),
                                    child: Text(
                                      field.errorText!,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 18),

                        // Program studi
                        const Text(
                          'Program Studi',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: _programStudi,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            hintText: 'Pilih program studi',
                            prefixIcon: Icon(Icons.school_outlined),
                          ),
                          items: _daftarProdi.map((prodi) {
                            return DropdownMenuItem<String>(
                              value: prodi,
                              child: Text(prodi),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _programStudi = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Pilih program studi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Syarat dan ketentuan
                        CheckboxListTile(
                          value: _setuju,
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            'Saya setuju dengan Syarat & Ketentuan',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _setuju = value ?? false;
                            });
                          },
                        ),
                        const SizedBox(height: 24),

                        // Tombol daftar
                        SizedBox(
                          height: 52,
                          child: FilledButton.icon(
                            onPressed: _daftar,
                            icon: const Icon(Icons.app_registration),
                            label: const Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tugas Praktikum 4 • Mobile Programming',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
