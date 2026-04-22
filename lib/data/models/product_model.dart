
class ProductModel {
  final String id;
  final String name;
  final String type;
  final String description;
  final double price;
  final List<String> suitableFor;
  final String? imageUrl;

  const ProductModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.suitableFor,
    this.imageUrl,
  });
}

final List<ProductModel> sampleProducts = [
  ProductModel(
    id: '1',
    name: 'Gentle Foam Cleanser',
    type: 'Cleanser',
    description:
    'A soft hydrating cleanser that removes dirt without stripping moisture.',
    price: 12.99,
    suitableFor: ['oily', 'combination', 'normal'],
    imageUrl: 'assets/images/product1.png',
  ),
  ProductModel(
    id: '2',
    name: 'Hyaluronic Acid Serum',
    type: 'Serum',
    description:
    'Deep hydration serum with 2% hyaluronic acid for plump dewy skin.',
    price: 24.99,
    suitableFor: ['dry', 'normal', 'combination'],
  ),
  ProductModel(
    id: '3',
    name: 'SPF 50 Sunscreen',
    type: 'Sunscreen',
    description:
    'Lightweight daily sunscreen with broad spectrum UVA/UVB protection.',
    price: 18.99,
    suitableFor: ['oily', 'dry', 'combination', 'normal', 'sensitive'],
  ),
  ProductModel(
    id: '4',
    name: 'Niacinamide Toner',
    type: 'Toner',
    description: 'Balances skin tone and minimises pores with 10% niacinamide.',
    price: 15.99,
    suitableFor: ['oily', 'combination'],
  ),
  ProductModel(
    id: '5',
    name: 'Ceramide Moisturiser',
    type: 'Moisturiser',
    description:
    'Barrier-repairing cream with ceramides and peptides for dry skin.',
    price: 21.99,
    suitableFor: ['dry', 'sensitive'],
  ),
  ProductModel(
    id: '6',
    name: 'Rose Water Toner',
    type: 'Toner',
    description:
    'Soothing toner with rose water to calm irritated sensitive skin.',
    price: 13.99,
    suitableFor: ['sensitive', 'normal', 'dry'],
  ),
];