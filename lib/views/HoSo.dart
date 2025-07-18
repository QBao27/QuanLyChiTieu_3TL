import 'package:flutter/material.dart';

class HoSoScreen extends StatefulWidget {
  const HoSoScreen({super.key});

  @override
  State<HoSoScreen> createState() => _HoSoScreenState();
}

class _HoSoScreenState extends State<HoSoScreen> {
  bool _isNotificationEnabled = true;
  String _selectedCurrency = 'VND';
  String _selectedLanguage = 'Tiếng Việt';
  String _userName = 'Nguyễn Văn A';
  String _gender = 'Nam';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileInfo(),
            const SizedBox(height: 20),
            _buildSettingsSection(),
            const SizedBox(height: 30),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/avatar.png'), // Bạn cần thêm ảnh này
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text('Giới tính: $_gender'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditProfileDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cài đặt ứng dụng',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Thông báo',
                subtitle: 'Bật/tắt thông báo',
                trailing: Switch(
                  value: _isNotificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isNotificationEnabled = value;
                    });
                  },
                  activeColor: Colors.amber,
                ),
              ),
              const Divider(height: 1),
              _buildMenuItem(
                icon: Icons.attach_money,
                title: 'Đơn vị tiền tệ',
                subtitle: _selectedCurrency,
                onTap: () => _showCurrencyDialog(),
              ),
              const Divider(height: 1),
              _buildMenuItem(
                icon: Icons.language,
                title: 'Ngôn ngữ',
                subtitle: _selectedLanguage,
                onTap: () => _showLanguageDialog(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Chọn đơn vị tiền tệ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('VND'),
              onTap: () {
                setState(() {
                  _selectedCurrency = 'VND';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('USD'),
              onTap: () {
                setState(() {
                  _selectedCurrency = 'USD';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Chọn ngôn ngữ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Tiếng Việt'),
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Tiếng Việt';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('English'),
              onTap: () {
                setState(() {
                  _selectedLanguage = 'English';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    String tempName = _userName;
    String tempGender = _gender;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Chỉnh sửa hồ sơ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Tên'),
              controller: TextEditingController(text: tempName),
              onChanged: (value) => tempName = value,
            ),
            DropdownButtonFormField<String>(
              value: tempGender,
              items: const [
                DropdownMenuItem(value: 'Nam', child: Text('Nam')),
                DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
                DropdownMenuItem(value: 'Khác', child: Text('Khác')),
              ],
              onChanged: (value) => tempGender = value ?? 'Nam',
              decoration: const InputDecoration(labelText: 'Giới tính'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _userName = tempName;
                _gender = tempGender;
              });
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        // Xử lý đăng xuất ở đây
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Đăng xuất'),
            content: const Text('Bạn có chắc muốn đăng xuất không?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: xử lý logic đăng xuất
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã đăng xuất')),
                  );
                },
                child: const Text('Đăng xuất'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.logout),
      label: const Text('Đăng xuất'),
    );
  }
}
