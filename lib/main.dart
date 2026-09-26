import 'package:flutter/material.dart';

const _brandBlue = Color(0xFF4169E1);

void main() {
  runApp(const WorkshopApp());
}

class WorkshopApp extends StatelessWidget {
  const WorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Workshop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _brandBlue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: _brandBlue),
        ),
      ),
      home: const AuthWorkshopScreen(),
    );
  }
}

class AuthWorkshopScreen extends StatefulWidget {
  const AuthWorkshopScreen({super.key});

  @override
  State<AuthWorkshopScreen> createState() => _AuthWorkshopScreenState();
}

class _AuthWorkshopScreenState extends State<AuthWorkshopScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isRegistering = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_isRegistering) {
      _register();
    } else {
      _login();
    }
  }

  void _login() {
    _showMessage('Tugas login belum dikerjakan.');
  }

  void _register() {
    _showMessage('Tugas registrasi belum dikerjakan.');
  }

  void _resetPassword() {
    // TODO(workshop-forgot-password): call POST /v1/auth/forgot-password with
    // the email only (do not validate the password). This backend currently
    // returns 404; show an honest unsupported-feature message, not fake success.
    _showMessage('Tugas lupa password belum dikerjakan.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final title = _isRegistering
        ? 'Daftar Arahin secara\nSimple'
        : 'Masuk ke akun Arahin\nkamu';
    final subtitle = _isRegistering
        ? 'Buat akun kamu untuk melanjutkan'
        : 'Masukkan email dan kata sandi Anda untuk masuk';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 52, 30, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _AuthLogo(),
                    const SizedBox(height: 48),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111111),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 16,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (_isRegistering) ...[
                      _AuthField(
                        key: const Key('name-field'),
                        label: 'Nama Lengkap',
                        hint: 'Nama Lengkap',
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Nama lengkap wajib diisi'
                            : null,
                      ),
                      const SizedBox(height: 20),
                    ],
                    _AuthField(
                      key: const Key('email-field'),
                      label: 'Email',
                      hint: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (email.isEmpty) return 'Email wajib diisi';
                        return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(email)
                            ? null
                            : 'Email tidak valid';
                      },
                    ),
                    const SizedBox(height: 20),
                    _AuthField(
                      key: const Key('password-field'),
                      label: _isRegistering ? 'Buat Kata Sandi' : 'Password',
                      hint: _isRegistering ? 'Buat Kata Sandi' : 'Password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: [
                        _isRegistering
                            ? AutofillHints.newPassword
                            : AutofillHints.password,
                      ],
                      suffix: IconButton(
                        tooltip: _obscurePassword
                            ? 'Tampilkan kata sandi'
                            : 'Sembunyikan kata sandi',
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF667085),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password wajib diisi';
                        }
                        return value.length < 6
                            ? 'Password minimal 6 karakter'
                            : null;
                      },
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    if (!_isRegistering) ...[
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _resetPassword,
                          child: const Text('Lupa Kata Sandi ?'),
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 30),
                    ],
                    const SizedBox(height: 8),
                    _PrimaryButton(
                      label: _isRegistering ? 'Daftar' : 'Masuk',
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 30),
                    const _AuthDivider(),
                    const SizedBox(height: 22),
                    _SocialButton(
                      label: 'Lanjutkan dengan Google',
                      leading: const Text(
                        'G',
                        style: TextStyle(
                          color: Color(0xFF4285F4),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () => _showMessage(
                        'Login Google tidak tersedia di mini workshop.',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _SocialButton(
                      label: 'Lanjutkan dengan Facebook',
                      leading: Icon(Icons.facebook, color: Color(0xFF1877F2)),
                      onPressed: null,
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() => _isRegistering = !_isRegistering);
                        },
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              color: Color(0xFF667085),
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: _isRegistering
                                    ? 'Sudah punya akun? '
                                    : 'Belum punya akun? ',
                              ),
                              TextSpan(
                                text: _isRegistering ? 'Masuk' : 'Daftar',
                                style: const TextStyle(
                                  color: _brandBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthLogo extends StatelessWidget {
  const _AuthLogo();

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Logo Arahin',
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.cloud_outlined, color: _brandBlue, size: 30),
        SizedBox(width: 6),
        Text(
          'arahin',
          style: TextStyle(
            color: _brandBlue,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -.6,
          ),
        ),
      ],
    ),
  );
}

class _AuthField extends StatelessWidget {
  const _AuthField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.obscureText = false,
    this.suffix,
    this.onFieldSubmitted,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final Widget? suffix;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF667085),
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        autofillHints: autofillHints,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF98A2B3), fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          suffixIcon: suffix,
          enabledBorder: _authBorder(const Color(0xFFE5E7EB)),
          focusedBorder: _authBorder(_brandBlue, 1.5),
          errorBorder: _authBorder(const Color(0xFFEF4444)),
          focusedErrorBorder: _authBorder(const Color(0xFFEF4444), 1.5),
          errorStyle: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
        ),
      ),
    ],
  );
}

OutlineInputBorder _authBorder(Color color, [double width = 1]) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: width),
    );

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 60,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _brandBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.leading,
    required this.onPressed,
  });

  final String label;
  final Widget leading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 56,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF1F2937),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(alignment: Alignment.centerLeft, child: leading),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

class _AuthDivider extends StatelessWidget {
  const _AuthDivider();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(child: Divider(color: Color(0xFFE5E7EB))),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          'Atau',
          style: TextStyle(color: Color(0xFF667085), fontSize: 14),
        ),
      ),
      Expanded(child: Divider(color: Color(0xFFE5E7EB))),
    ],
  );
}
