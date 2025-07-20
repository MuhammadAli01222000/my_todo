import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_todo/core/constants/app_colors.dart';
import 'package:my_todo/core/services/auth_service_impl.dart';
import 'package:my_todo/l10n/app_localizations.dart';
import 'package:my_todo/routes/path_router.dart';

import '../../bloc/cubit/l10_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLang = 'uz';

  final List<Map<String, String>> _languages = [
    {'code': 'uz', 'label': '🇺🇿 O‘zbek'},
    {'code': 'ru', 'label': '🇷🇺 Русский'},
    {'code': 'en', 'label': '🇺🇸 English'},
  ];

  void _changeLanguage(String code) {
    setState(() {
      _selectedLang = code;
    });
  }

  void _logout() {
    AuthService authService = AuthService();
    authService.signOut();
    print("🚪 Logout clicked");
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'MyTodo App',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2025 MyTodo Developers',
    );
  }

  void _showNotImplemented(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title funksiyasi hali qo‘shilmagan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.pushNamed(AppRouteName.home),
        ),
        title: Text('settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('${AppLocalizations.of(context)?.language}'),
            trailing: DropdownButton<String>(
              value: _selectedLang,
              underline: const SizedBox(),

              /// Localization metod
              onChanged: (val) {
                if (val != null) _changeLanguage(val);
                context.read<L10nCubit>().changeL10n(val!);
              },
              items: _languages.map((lang) {
                return DropdownMenuItem(
                  value: lang['code'],
                  child: Text(lang['label']!),
                );
              }).toList(),
            ),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('Dastur haqida'),
            onTap: _showAboutDialog,
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: Text('Taklif va shikoyatlar'),
            onTap: () => _showNotImplemented('Taklif'),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: Text('Donat qilish'),
            onTap: () => ('Donat'),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text('Ko‘p so‘raladigan savollar (FAQ)'),
            onTap: () => _showNotImplemented('FAQ'),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('Chiqish'),
            onTap: () async {
              await AuthService().signOut();
              if (context.mounted) {
                context.goNamed(AppRouteName.signIn);
              }
            },
          ),
        ],
      ),
    );
  }
}
