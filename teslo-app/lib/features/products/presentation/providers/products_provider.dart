import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_repository_provider.dart';

final productsProvider = StateNotifierProvider<ProductsNotifier,ProductsState >((ref){
  
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(productsRepository: productsRepository);
});


class ProductsNotifier extends StateNotifier<ProductsState>{
  ProductsNotifier({required this.productsRepository})
      : super(ProductsState()) {
    loadNextPage();
  }

  final ProductsRepository productsRepository;
  Future loadNextPage () async {
    if(state.isLoading || state.islastPage) return;
    state = state.copyWith(isLoading: true);
    final products = await productsRepository.getProductByPage(limit: state.limit, offset: state.offset);
    if(products.isEmpty){
      state = state.copyWith(
        isLoading: false,
        islastPage: true);
        return;
    }
    state = state.copyWith(
      isLoading: false,
      islastPage: false,
      offset: state.offset + 10,
      products: [...state.products, ...products],
    );
  }
}


class ProductsState {
  final bool islastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.islastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? islastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
        islastPage: islastPage ?? this.islastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
