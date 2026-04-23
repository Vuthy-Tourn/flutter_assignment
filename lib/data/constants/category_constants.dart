const Map<String, List<String>> kCategoryFilters = {
  'Best Deal': ['All', 'Under \$10', 'Under \$20', 'Under \$30', 'Price: Low', 'Price: High'],
  'New Arrivals': ['All', 'This Week', 'This Month', 'Top Rated'],
  'Clearance Sale': ['All', 'Up to 30% off', 'Up to 50% off', 'Up to 70% off'],
  'Time Deal': ['All', 'Ending Soon', 'Flash Sale', 'Today Only'],
  'Skincare': ['All', 'Cleanser', 'Toner', 'Serum', 'Moisturiser', 'Sunscreen'],
  'Make Up': ['All', 'Foundation', 'Lip', 'Eye', 'Blush', 'Primer'],
  'Supplement': ['All', 'Collagen', 'Vitamins', 'Antioxidant', 'Detox'],
  'Beauty Tools': ['All', 'Face', 'Hair', 'Body', 'Nails'],
};

const List<String> kDefaultFilters = [
  'All', 'Best Seller', 'New', 'Price: Low', 'Price: High',
];

const Map<String, int> kCategoryDiscounts = {
  'Best Deal':      10,
  'Clearance Sale': 30,
  'Time Deal':      20,
};

const Map<String, int> kFilterDiscounts = {
  'Up to 30% off': 30,
  'Up to 50% off': 50,
  'Up to 70% off': 70,
  'Flash Sale':    25,
  'Today Only':    15,
  'Ending Soon':   10,
};