import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_app/ui/ui.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _searchController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Input',
      children: [
        // ── GlassTextField ────────────────────────────────
        const SectionTitle(title: 'GlassTextField'),
        SizedBox(height: 16),
        GlassTextField(
          controller: _usernameController,
          placeholder: 'Username',
        ),
        SizedBox(height: 12),
        GlassTextField(
          controller: _emailController,
          placeholder: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 12),
        GlassTextField(
          controller: _passwordController,
          placeholder: 'Password',
          obscureText: true,
        ),
        SizedBox(height: 24),

        // With icons
        GlassTextField(
          controller: _searchController,
          placeholder: 'Search...',
          prefixIcon: Icon(
            CupertinoIcons.search,
            size: 20,
            color: CupertinoColors.secondaryLabel.resolveFrom(
              context,
            ),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? Icon(
                  CupertinoIcons.xmark_circle_fill,
                  size: 20,
                  color: CupertinoColors.secondaryLabel
                      .resolveFrom(context),
                )
              : null,
          onSuffixTap: () {
            setState(_searchController.clear);
          },
          onChanged: (value) => setState(() {}),
        ),
        SizedBox(height: 24),

        // Multiline
        GlassTextField(
          controller: _messageController,
          placeholder: 'Enter your message...',
          maxLines: 5,
          minLines: 3,
        ),

        SizedBox(height: 40),

        // ── GlassSearchBar ────────────────────────────────
        const SectionTitle(title: 'GlassSearchBar'),
        SizedBox(height: 16),
        GlassSearchBar(
          placeholder: 'Search',
          onChanged: (value) {},
        ),
        SizedBox(height: 12),
        GlassSearchBar(
          placeholder: 'Search messages',
          showsCancelButton: true,
          onCancel: () {},
        ),

        SizedBox(height: 40),

        // ── Example Form ─────────────────────────────────
        const SectionTitle(title: 'Example Form'),
        SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            color: CupertinoColors.systemFill.resolveFrom(
              context,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.label.resolveFrom(
                      context,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                GlassTextField(
                  placeholder: 'Full Name',
                  useOwnLayer: true,
                  prefixIcon: Icon(
                    CupertinoIcons.person,
                    size: 20,
                    color: CupertinoColors.secondaryLabel
                        .resolveFrom(context),
                  ),
                ),
                SizedBox(height: 16),
                GlassTextField(
                  placeholder: 'Email Address',
                  useOwnLayer: true,
                  prefixIcon: Icon(
                    CupertinoIcons.mail,
                    size: 20,
                    color: CupertinoColors.secondaryLabel
                        .resolveFrom(context),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                GlassTextField(
                  placeholder: 'Password',
                  useOwnLayer: true,
                  prefixIcon: Icon(
                    CupertinoIcons.lock,
                    size: 20,
                    color: CupertinoColors.secondaryLabel
                        .resolveFrom(context),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: GlassButton.custom(
                    onTap: () {},
                    height: 56,
                    shape: const LiquidRoundedSuperellipse(
                      borderRadius: 12,
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.label
                              .resolveFrom(context),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Already have an account? Sign In',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.label
                          .resolveFrom(context)
                          .withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 40),

        // ── GlassPasswordField ─────────────────────────
        const SectionTitle(title: 'GlassPasswordField'),
        SizedBox(height: 16),
        const GlassPasswordField(placeholder: 'Enter password'),

        SizedBox(height: 40),

        // ── GlassTextArea ──────────────────────────────
        const SectionTitle(title: 'GlassTextArea'),
        SizedBox(height: 16),
        const GlassTextArea(
          placeholder: 'Write a short description...',
          minLines: 4,
        ),

        SizedBox(height: 40),

        // ── GlassPicker ────────────────────────────────
        const SectionTitle(title: 'GlassPicker'),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GlassPicker(
                value: 'Administrator',
                icon: Icon(CupertinoIcons.briefcase),
                useOwnLayer: true,
                quality: GlassQuality.premium,
                onTap: () {},
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: GlassPicker(
                value: null,
                placeholder: 'Select role',
                useOwnLayer: true,
                quality: GlassQuality.premium,
                onTap: () {},
              ),
            ),
          ],
        ),

        SizedBox(height: 40),

        // ── GlassFormField ─────────────────────────────
        const SectionTitle(title: 'GlassFormField'),
        SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            color: CupertinoColors.systemFill.resolveFrom(
              context,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                GlassFormField(
                  label: 'Account Email',
                  child: GlassTextField(
                    placeholder: 'example@email.com',
                    keyboardType: TextInputType.emailAddress,
                    useOwnLayer: true,
                    prefixIcon: Icon(
                      CupertinoIcons.mail,
                      color: CupertinoColors.secondaryLabel
                          .resolveFrom(context),
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                const GlassFormField(
                  label: 'Password',
                  helperText: 'Must be at least 8 characters',
                  child: GlassPasswordField(),
                ),
                SizedBox(height: 16),
                GlassFormField(
                  label: 'Bio / Description',
                  child: GlassTextArea(
                    placeholder: 'Write a short description...',
                    minLines: 3,
                    useOwnLayer: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
