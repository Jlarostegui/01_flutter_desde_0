import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/dataSources/products_datatsource_impl.dart';
import 'package:teslo_shop/features/products/infrastructure/repositories/products_repository_impl.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accesToken = ref.watch(authProvider).user?.token ?? '';
  final productsRepository =
      ProductsRepositoryImpl(ProductsDataSourceImpl(accessToken: accesToken));
  return productsRepository;
});
