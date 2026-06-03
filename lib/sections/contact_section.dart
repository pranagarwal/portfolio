import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

/// =============================================================
/// CONTACT FORM (static-friendly, no backend required)
/// Uses Web3Forms: create a free access key at https://web3forms.com
/// and paste it below. Submissions are emailed to the address you
/// registered the key with.
/// =============================================================
const String kWeb3FormsAccessKey = '7f4f3c86-188f-4cb9-8d36-00c70fd94c5e';

class ContactSection extends StatefulWidget {
  final Key sectionKey;
  final Profile profile;
  const ContactSection({
    super.key,
    required this.sectionKey,
    required this.profile,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  bool _sending = false;
  String? _status; // user-facing status message
  bool _ok = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (kWeb3FormsAccessKey == 'YOUR-WEB3FORMS-ACCESS-KEY') {
      setState(() {
        _ok = false;
        _status =
            'Add your Web3Forms access key in contact_section.dart first.';
      });
      return;
    }

    setState(() {
      _sending = true;
      _status = null;
    });

    try {
      final res = await http.post(
        Uri.parse('https://api.web3forms.com/submit'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'access_key': kWeb3FormsAccessKey,
          'name': _name.text,
          'email': _email.text,
          'message': _message.text,
          'subject': 'New message from your portfolio',
        }),
      );
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final success = body['success'] == true;
      setState(() {
        _ok = success;
        _status = success
            ? 'Thanks — your message is on its way.'
            : 'Something went wrong. Please email me directly.';
      });
      if (success) {
        _name.clear();
        _email.clear();
        _message.clear();
      }
    } catch (_) {
      setState(() {
        _ok = false;
        _status = 'Network error. Please email me directly.';
      });
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Let’s build\nsomething.', style: AppTheme.sectionTitle(context)),
        const SizedBox(height: Gap.md),
        Text(
          'Have a role, a project, or just want to talk shop? '
          'Drop a line and I’ll get back to you.',
          style: AppTheme.body.copyWith(fontSize: 17),
        ),
        const SizedBox(height: Gap.lg),
        GestureDetector(
          onTap: () => openUrl('mailto:${widget.profile.email}'),
          child: Text(widget.profile.email,
              style: AppTheme.mono(size: 16, color: AppColors.accent)),
        ),
        Text(widget.profile.location,
            style: AppTheme.mono(size: 13, color: AppColors.textMuted)),
      ],
    );

    final form = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Field(
            controller: _name,
            label: 'NAME',
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          _Field(
            controller: _email,
            label: 'EMAIL',
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!v.contains('@')) return 'Enter a valid email';
              return null;
            },
          ),
          _Field(
            controller: _message,
            label: 'MESSAGE',
            maxLines: 4,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: Gap.md),
          _sending
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.accent),
                  ),
                )
              : PrimaryButton(
                  label: 'SEND MESSAGE',
                  icon: Icons.send,
                  onTap: _submit,
                ),
          if (_status != null) ...[
            const SizedBox(height: Gap.sm),
            Text(
              _status!,
              style: AppTheme.mono(
                size: 13,
                color: _ok ? AppColors.accent : const Color(0xFFFF6B6B),
              ),
            ),
          ],
        ],
      ),
    );

    return SectionWrapper(
      sectionKey: widget.sectionKey,
      index: '05',
      label: 'CONTACT',
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [left, const SizedBox(height: Gap.lg), form],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const SizedBox(width: Gap.xl),
                Expanded(child: form),
              ],
            ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final String? Function(String?)? validator;

  const _Field({
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTheme.mono(size: 11, color: AppColors.textMuted)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            validator: validator,
            style: AppTheme.bodyStrong,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: AppColors.surface,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: Gap.sm, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.accent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFFF6B6B)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFFF6B6B)),
              ),
              errorStyle:
                  AppTheme.mono(size: 11, color: const Color(0xFFFF6B6B)),
            ),
          ),
        ],
      ),
    );
  }
}
