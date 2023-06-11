import 'package:fin/controller/api_service.dart';
import 'package:fin/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('User.fromJson should correctly parse user data', () {
    final userData = {
      'name': {'title': null,'first': 'John', 'last': 'Doe'},
      'location': {'city': 'New York', 'country': 'USA'},
      'email': 'johndoe@example.com',
      'dob': {'date': '1990-01-01'},
      'registered': {'age': 2},
      'picture': {'large': 'https://example.com/avatar.jpg'},
    };

    final user = User.fromJson(userData);

    expect(user.results!.name!.first! + ' ' + user.results!.name!.last!, 'John Doe');
    expect(user.results!.location!.city! +", "+ user.results!.location!.country!, 'New York, USA');
    expect(user.results!.email, 'johndoe@example.com');
    expect(user.results!.dob!.date, '1990-01-01');
    expect(user.results!.picture!.large, 'https://example.com/avatar.jpg');
  });

  test('RandomUserApi.fetchRandomUser should fetch and parse a random user', () async {
    final user = await ApiService().fetchUserProfileApi();

    expect(user.results!.name!.first!.isNotEmpty, true);
    expect(user.results!.location!.country!.isNotEmpty, true);
    expect(user.results!.email!.isNotEmpty, true);
    expect(user.results!.dob!.age.toString().isNotEmpty, true);
    expect(user.results!.registered!.age! >= 0, true);
    expect(user.results!.picture!.thumbnail!.isNotEmpty, true);
  });
}