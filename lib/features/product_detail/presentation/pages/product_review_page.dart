import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ProductReviewPage extends StatefulWidget {
  const ProductReviewPage({super.key});

  @override
  State<ProductReviewPage> createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  int _rating = 0;
  String? _skinType;
  final Set<String> _skinConcerns = <String>{};
  String? _skinTone;
  final TextEditingController _reviewController = TextEditingController();

  static const List<String> _skinTypes = [
    'Combination',
    'Oily',
    'Dry',
    'Normal',
    'Sensitive',
  ];

  static const List<String> _skinConcernsOptions = [
    'Acne',
    'Anti-Age',
    'Brightening',
    'Calming',
    'Dryness',
    'Oil Control',
    'Pore care',
    'Dark spots',
  ];

  static const List<String> _skinTones = [
    'Porcelain',
    'Fair',
    'Medium',
    'Tan',
    'Olive',
  ];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _toggleConcern(String concern) {
    setState(() {
      if (_skinConcerns.contains(concern)) {
        _skinConcerns.remove(concern);
      } else {
        _skinConcerns.add(concern);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(26, 10, 26, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Product Review',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 38),
              _SectionTitle(title: 'How would you rate this product?'),
              const SizedBox(height: 14),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    final isActive = index < _rating;
                    return IconButton(
                      onPressed: () => setState(() => _rating = index + 1),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 34,
                        height: 34,
                      ),
                      icon: Icon(
                        Icons.star_rounded,
                        size: 34,
                        color: isActive
                            ? AppColors.star
                            : const Color(0xFFD8DCE2),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 50),
              _SectionTitle(title: 'What is your skin type?'),
              const SizedBox(height: 18),
              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: _skinTypes.map((type) {
                    return _OutlineChoiceChip(
                      label: type,
                      isSelected: _skinType == type,
                      onTap: () => setState(() => _skinType = type),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 64),
              _SectionTitle(title: 'What is your skin concern?'),
              const SizedBox(height: 18),
              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: _skinConcernsOptions.map((concern) {
                    return _OutlineChoiceChip(
                      label: concern,
                      isSelected: _skinConcerns.contains(concern),
                      onTap: () => _toggleConcern(concern),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 64),
              _SectionTitle(title: 'Skin Tone'),
              const SizedBox(height: 18),
              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: _skinTones.map((tone) {
                    return _OutlineChoiceChip(
                      label: tone,
                      isSelected: _skinTone == tone,
                      onTap: () => setState(() => _skinTone = tone),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 70),
              Row(
                children: [
                  Icon(Icons.message_outlined, color: AppColors.secondary,),
                  const SizedBox(width: 8),
                  Text(
                    'Share your review with us.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'type here..',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFC7CAD0),
                  ),
                  contentPadding: const EdgeInsets.all(14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFD7D7D7),
                    style: BorderStyle.solid,
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_outlined,
                  color: AppColors.textSecondary,
                  size: 30,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Reviews that violate our policy such as inappropriate content, copied images, or promotional messages may be removed without notice.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Review Policy',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 34),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    side: const BorderSide(color: Color(0xFFD1D1D1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    foregroundColor: const Color(0xFF969696),
                  ),
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _OutlineChoiceChip extends StatelessWidget {
  const _OutlineChoiceChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? const Color(0xFF2D62D6)
        : const Color(0xFF2D62D6);
    final textColor = isSelected
        ? const Color(0xFF2D62D6)
        : const Color(0xFF2D62D6);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0x142D62D6) : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
