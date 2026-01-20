import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../utils/models/user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile? profile;

  const EditProfileScreen({Key? key, this.profile}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  // Controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;
  late TextEditingController _occupationController;
  late TextEditingController _organizationController;
  late TextEditingController _linkedInController;
  late TextEditingController _githubController;

  // State
  String? _profileImageUrl;
  DateTime? _dateOfBirth;
  EducationLevel? _educationLevel;
  List<String> _interests = [];
  List<String> _skills = [];
  bool _isPublicProfile = false;
  bool _isLoading = false;

  // Available options
  final List<String> _availableInterests = [
    'Technology',
    'Business',
    'Design',
    'Marketing',
    'Data Science',
    'Development',
    'AI & Machine Learning',
    'Cloud Computing',
    'Cybersecurity',
    'Mobile Development',
  ];

  final List<String> _availableSkills = [
    'JavaScript',
    'Python',
    'React',
    'Flutter',
    'Node.js',
    'SQL',
    'Git',
    'AWS',
    'Docker',
    'Figma',
    'UI/UX Design',
    'Project Management',
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final profile = widget.profile;
    _firstNameController = TextEditingController(text: profile?.firstName ?? '');
    _lastNameController = TextEditingController(text: profile?.lastName ?? '');
    _emailController = TextEditingController(text: profile?.email ?? '');
    _phoneController = TextEditingController(text: profile?.phoneNumber ?? '');
    _bioController = TextEditingController(text: profile?.bio ?? '');
    _locationController = TextEditingController(text: profile?.location ?? '');
    _occupationController = TextEditingController(text: profile?.occupation ?? '');
    _organizationController = TextEditingController(text: profile?.organization ?? '');
    _linkedInController = TextEditingController(text: profile?.linkedInUrl ?? '');
    _githubController = TextEditingController(text: profile?.githubUrl ?? '');

    _profileImageUrl = profile?.profileImageUrl;
    _dateOfBirth = profile?.dateOfBirth;
    _educationLevel = profile?.educationLevel;
    _interests = List.from(profile?.interests ?? []);
    _skills = List.from(profile?.skills ?? []);
    _isPublicProfile = profile?.isPublicProfile ?? false;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _occupationController.dispose();
    _organizationController.dispose();
    _linkedInController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => _showDiscardDialog(),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Profile Photo Section
            _buildProfilePhotoSection(),
            const SizedBox(height: 24),

            // Personal Information
            _buildSectionHeader('Personal Information'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _firstNameController,
              label: 'First Name',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _lastNameController,
              label: 'Last Name',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildDateField(),
            const SizedBox(height: 24),

            // Contact Information
            _buildSectionHeader('Contact Information'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _locationController,
              label: 'Location',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 24),

            // Professional Information
            _buildSectionHeader('Professional Information'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _occupationController,
              label: 'Occupation',
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _organizationController,
              label: 'Organization',
              icon: Icons.business_outlined,
            ),
            const SizedBox(height: 16),
            _buildEducationLevelField(),
            const SizedBox(height: 24),

            // Bio
            _buildSectionHeader('About Me'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _bioController,
              label: 'Bio',
              icon: Icons.notes,
              maxLines: 4,
              hint: 'Tell us about yourself, your goals, and interests...',
            ),
            const SizedBox(height: 24),

            // Interests
            _buildSectionHeader('Interests'),
            const SizedBox(height: 12),
            _buildInterestsSection(),
            const SizedBox(height: 24),

            // Skills
            _buildSectionHeader('Skills'),
            const SizedBox(height: 12),
            _buildSkillsSection(),
            const SizedBox(height: 24),

            // Social Links
            _buildSectionHeader('Social Links'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _linkedInController,
              label: 'LinkedIn URL',
              icon: Icons.link,
              hint: 'https://linkedin.com/in/username',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _githubController,
              label: 'GitHub URL',
              icon: Icons.code,
              hint: 'https://github.com/username',
            ),
            const SizedBox(height: 24),

            // Privacy Settings
            _buildSectionHeader('Privacy'),
            const SizedBox(height: 12),
            _buildPrivacySwitch(),
            const SizedBox(height: 32),

            // Delete Account
            TextButton.icon(
              onPressed: _showDeleteAccountDialog,
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              image: _profileImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(_profileImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _profileImageUrl == null
                ? Icon(Icons.person, size: 60, color: Colors.grey[400])
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[700]),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                _dateOfBirth != null
                    ? DateFormat('MMMM d, y').format(_dateOfBirth!)
                    : 'Date of Birth',
                style: TextStyle(
                  fontSize: 16,
                  color: _dateOfBirth != null ? Colors.black87 : Colors.grey[600],
                ),
              ),
            ),
            if (_dateOfBirth != null)
              GestureDetector(
                onTap: () => setState(() => _dateOfBirth = null),
                child: Icon(Icons.clear, size: 20, color: Colors.grey[600]),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationLevelField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonFormField<EducationLevel>(
        value: _educationLevel,
        decoration: const InputDecoration(
          labelText: 'Education Level',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.school_outlined),
        ),
        items: EducationLevel.values.map((level) {
          return DropdownMenuItem(
            value: level,
            child: Text(_educationLevelToString(level)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _educationLevel = value;
          });
        },
      ),
    );
  }

  Widget _buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _interests.map((interest) {
            return Chip(
              label: Text(interest),
              onDeleted: () {
                setState(() {
                  _interests.remove(interest);
                });
              },
              backgroundColor: Colors.blue[50],
              labelStyle: const TextStyle(color: Colors.blue),
              deleteIconColor: Colors.blue,
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _showInterestsPicker,
          icon: const Icon(Icons.add),
          label: const Text('Add Interests'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _skills.map((skill) {
            return Chip(
              label: Text(skill),
              onDeleted: () {
                setState(() {
                  _skills.remove(skill);
                });
              },
              backgroundColor: Colors.green[50],
              labelStyle: const TextStyle(color: Colors.green),
              deleteIconColor: Colors.green,
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _showSkillsPicker,
          icon: const Icon(Icons.add),
          label: const Text('Add Skills'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacySwitch() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.public, color: Colors.grey[700]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Public Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Allow others to view your profile',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _isPublicProfile,
            onChanged: (value) {
              setState(() {
                _isPublicProfile = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImageUrl = image.path; // In real app, upload to server
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  void _showInterestsPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Interests',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: _availableInterests.map((interest) {
                        final isSelected = _interests.contains(interest);
                        return CheckboxListTile(
                          title: Text(interest),
                          value: isSelected,
                          onChanged: (value) {
                            setModalState(() {
                              if (value == true) {
                                _interests.add(interest);
                              } else {
                                _interests.remove(interest);
                              }
                            });
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSkillsPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Skills',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: _availableSkills.map((skill) {
                        final isSelected = _skills.contains(skill);
                        return CheckboxListTile(
                          title: Text(skill),
                          value: isSelected,
                          onChanged: (value) {
                            setModalState(() {
                              if (value == true) {
                                _skills.add(skill);
                              } else {
                                _skills.remove(skill);
                              }
                            });
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _educationLevelToString(EducationLevel level) {
    switch (level) {
      case EducationLevel.highSchool:
        return 'High School';
      case EducationLevel.associate:
        return 'Associate Degree';
      case EducationLevel.bachelor:
        return 'Bachelor\'s Degree';
      case EducationLevel.master:
        return 'Master\'s Degree';
      case EducationLevel.doctorate:
        return 'Doctorate';
      case EducationLevel.other:
        return 'Other';
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    final updatedProfile = UserProfile(
      id: widget.profile?.id ?? 'new_user',
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text.isEmpty ? null : _phoneController.text,
      bio: _bioController.text.isEmpty ? null : _bioController.text,
      profileImageUrl: _profileImageUrl,
      dateOfBirth: _dateOfBirth,
      location: _locationController.text.isEmpty ? null : _locationController.text,
      occupation: _occupationController.text.isEmpty ? null : _occupationController.text,
      organization: _organizationController.text.isEmpty ? null : _organizationController.text,
      interests: _interests,
      skills: _skills,
      educationLevel: _educationLevel,
      linkedInUrl: _linkedInController.text.isEmpty ? null : _linkedInController.text,
      githubUrl: _githubController.text.isEmpty ? null : _githubController.text,
      isPublicProfile: _isPublicProfile,
      createdAt: widget.profile?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, updatedProfile);
    }
  }

  void _showDiscardDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Changes?'),
        content: const Text('Are you sure you want to discard your changes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Discard', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deletion requested')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
