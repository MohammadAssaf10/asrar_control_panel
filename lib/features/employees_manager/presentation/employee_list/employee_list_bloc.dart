import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../home/data/repositories/storage_file_repository_impl.dart';
import '../../../home/domain/entities/file_entities.dart';
import '../../../home/domain/repositories/storage_file_repository.dart';
import '../../data/repo/firebase_employee_repo.dart';
import '../../domain/employees_repo.dart';
import '../../domain/entities/employee.dart';



part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeRepository _employeeRepository = FireBaseEmployeeRepo();
  final StorageFileRepository _fileRepository =
      StorageFileRepositoryImpl(storage: FirebaseStorage.instance);

  EmployeeListBloc() : super(EmployeeListState.empty()) {
    on<FetchEmployeesList>((event, emit) async {
      emit(state.copyWith(employeeListStatus: Status.loading));

      (await _employeeRepository.getList()).fold(((l) {
        emit(state.copyWith(employeeListStatus: Status.failed));
      }), ((employeeList) {
        emit(state.copyWith(
            employeeListStatus: Status.success, employeeList: employeeList));
      }));
    });

    on<FetchEmployeeImages>(
      (event, emit) async {
        emit(state.copyWith(employeeImageStatus: Status.loading));

        (await _fileRepository.getFile('employees/${event.employee.email}/'))
            .fold(((l) {
          emit(state.copyWith(employeeImageStatus: Status.failed));
        }), ((employeeImages) {
          print(employeeImages);
          emit(state.copyWith(
              employeeImageStatus: Status.success,
              employeeImages: employeeImages));
        }));
      },
    );
  }
}
