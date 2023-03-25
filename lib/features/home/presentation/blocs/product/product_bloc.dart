import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../domain/entities/product_entities.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/shop_repository.dart';
import '../../../domain/repositories/storage_file_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ShopRepository productRepository = instance<ShopRepository>();
  final StorageFileRepository storageFileRepository =
      instance<StorageFileRepository>();
  ProductBloc() : super(ProductInitial()) {
    on<AddProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      await (await storageFileRepository.uploadFile(
              event.xFileEntities, FireBaseCollection.products))
          .fold((failure) {
        emit(ProductErrorState(errorMessage: failure.message));
      }, (image) async {
        (await productRepository.addProduct(event.productEntities, image.url))
            .fold((failure) {
          emit(ProductErrorState(errorMessage: failure.message));
        }, (r) {
          emit(ProductAddedSuccessfullyState());
        });
      });
    });
    on<GetProductsListEvent>((event, emit) async {
      emit(ProductLoadingState());
      (await productRepository.getProductsList()).fold((failure) {
        emit(GetProductErrorState(errorMessage: failure.message));
      }, (productsList) {
        emit(ProductsLoadedState(productsList: productsList));
      });
    });
    on<DeleteProductEvent>((event, emit) async {
      emit(DeleteProductLoadingState());
      (await productRepository.deleteProduct(event.productEntities)).fold(
          (failure) {
        emit(ProductErrorState(errorMessage: failure.message));
      }, (r) {
        emit(ProductDeletedSuccessfullyState());
      });
    });
  }
}
