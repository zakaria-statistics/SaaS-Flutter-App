import 'package:my_web_app/features/user_auth/presentation/backend/entities/user_entity.dart';
import '../repository/user_repository.dart';

class UserService {
  final UserRepository userRepository;

  UserService(this.userRepository);

  Future<UserEntity> getUser(String id) {
    return userRepository.getUser(id);
  }

  Future<void> addUser(UserEntity user) {
    return userRepository.addUser(user);
  }

  Future<void> updateUser(UserEntity user) {
    return userRepository.updateUser(user);
  }
}
