import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

// ignore: avoid_types_as_parameter_names
abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call([Param param]);
}
