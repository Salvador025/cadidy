import 'package:flutter/material.dart';

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
                          onPressed: () {
                            // Save gender
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
                decoration: const InputDecoration(
                  labelText: 'New value',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save text info
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
