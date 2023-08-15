import 'package:equatable/equatable.dart';

abstract class AddContactState extends Equatable {
  const AddContactState();
}

class AddContactLoaded extends AddContactState {
  final bool isLoading;
  final bool isFailed;
  final String? imagePath;
  final Map<String, String?> formErrors;

  @override
  List<Object?> get props => [formErrors];

  const AddContactLoaded({
    this.isLoading = false,
    this.isFailed = false,
    this.imagePath,
    this.formErrors = const {},
  });

  AddContactLoaded copyWith({
    bool? isLoading,
    bool? isFailed,
    String? imagePath,
    Map<String, String?>? formErrors,
  }) {
    return AddContactLoaded(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      imagePath: imagePath ?? this.imagePath,
      formErrors: formErrors ?? this.formErrors,
    );
  }
}
