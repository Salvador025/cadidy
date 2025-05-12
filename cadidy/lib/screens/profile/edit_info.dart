import 'package:flutter/material.dart';
import 'package:cadidy/service/users_service.dart';

class EditInfoPage extends StatefulWidget {
  final String title;
  final String info;

  const EditInfoPage({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedGender;

  final List<String> _genderOptions = [
    'Female',
    'Male',
    'Non-binary',
    'Prefer not to say',
    'Custom',
  ];

  @override
  void initState() {
    super.initState();
    _controller.text = widget.info;
    if (widget.title.toLowerCase().contains('gender')) {
      _selectedGender = widget.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGenderEdit = widget.title.toLowerCase().contains('gender');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 59, 55),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 102, 93, 85),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isGenderEdit)
              Expanded(
                child: Card(
                  color: Color.fromARGB(255, 102, 93, 85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String gender in _genderOptions)
                          RadioListTile<String>(
                            title: Text(
                              gender,
                              style: TextStyle(color: Colors.white),
                            ),
                            value: gender,
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                            activeColor: Colors.white,
                          ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 170, 126, 74),
                              minimumSize: const Size.fromHeight(48),
                              foregroundColor: Colors.white),
                          icon: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          label: const Text('Save Changes'),
                          onPressed: () async {
                            if (_selectedGender != null) {
                              final usersService = UsersService();
                              await usersService.updateUserField(
                                  'gender', _selectedGender);

                              if (context.mounted) Navigator.pop(context);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "This information is only used to personalize your experience and will not be shared with third parties.",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else ...[
              TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'New value',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 170, 126, 74)),
                  ),
                  fillColor: Color.fromARGB(255, 102, 93, 85),
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final String newValue = _controller.text.trim();
                  if (newValue.isNotEmpty) {
                    final String field = widget.title
                            .toLowerCase()
                            .contains('name')
                        ? 'name'
                        : widget.title.toLowerCase().contains('email')
                            ? 'email'
                            : widget.title.toLowerCase().contains('contact')
                                ? 'phone'
                                : widget.title.toLowerCase().contains('address')
                                    ? 'adress'
                                    : '';
                    if (field.isNotEmpty) {
                      print("Updating field: $field with value: $newValue");
                      final usersService = UsersService();
                      await usersService.updateUserField(field, newValue);

                      if (context.mounted) Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  'Save Changes',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
