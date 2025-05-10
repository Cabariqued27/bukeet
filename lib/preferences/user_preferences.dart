import 'package:bukeet/enums/preferences_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //USER ID

  int getUserId() => _prefs.getInt(PreferencesEnum.userId) ?? 0;
  set setUserId(int value) => _prefs.setInt(PreferencesEnum.userId, value);

  //FIRST NAME

  String getFirstName() => _prefs.getString(PreferencesEnum.firstName) ?? '';
  set setFirstName(String value) =>
      _prefs.setString(PreferencesEnum.firstName, value);

  //LAST NAME

  String getLastName() => _prefs.getString(PreferencesEnum.lastName) ?? '';
  set setLastName(String value) =>
      _prefs.setString(PreferencesEnum.lastName, value);

  //USER TYPE

  String getUserType() => _prefs.getString(PreferencesEnum.userType) ?? '';
  set setUserType(String value) =>
      _prefs.setString(PreferencesEnum.userType, value);

  //LAST GENDER

  String getGender() => _prefs.getString(PreferencesEnum.gender) ?? '';
  set setGender(String value) =>
      _prefs.setString(PreferencesEnum.gender, value);

  //BIRTH DATE
  String getBirthDate() => _prefs.getString(PreferencesEnum.birthDate) ?? '';
  set setBirthDate(String value) =>
      _prefs.setString(PreferencesEnum.birthDate, value);

  //EMAIL

  String getEmail() => _prefs.getString(PreferencesEnum.email) ?? '';
  set setEmail(String value) => _prefs.setString(PreferencesEnum.email, value);

  //IMAGE

  String getImage() => _prefs.getString(PreferencesEnum.image) ?? '';
  set setImage(String value) => _prefs.setString(PreferencesEnum.image, value);

  //ROOM VOLUME

  int getRoomVolume() => _prefs.getInt(PreferencesEnum.roomVolume) ?? 0;
  set setRoomVolume(int value) =>
      _prefs.setInt(PreferencesEnum.roomVolume, value);

  //CAMERA PERMISSION

  bool getCamera() => _prefs.getBool(PreferencesEnum.camera) ?? false;
  set setCamera(bool value) => _prefs.setBool(PreferencesEnum.camera, value);

  //PHOTOS PERMISSION

  bool getPhotos() => _prefs.getBool(PreferencesEnum.photos) ?? false;
  set setPhotos(bool value) => _prefs.setBool(PreferencesEnum.photos, value);

  //LOCATION PERMISSION

  bool getLocation() => _prefs.getBool(PreferencesEnum.location) ?? false;
  set setLocation(bool value) =>
      _prefs.setBool(PreferencesEnum.location, value);

  //NOTIFICATION PERMISSION

  bool getNotifications() =>
      _prefs.getBool(PreferencesEnum.notification) ?? false;
  set setNotifications(bool value) =>
      _prefs.setBool(PreferencesEnum.notification, value);

  //APP VERSION

  int getAppVersion() => _prefs.getInt(PreferencesEnum.appVersion) ?? 0;
  set setAppVersion(int value) =>
      _prefs.setInt(PreferencesEnum.appVersion, value);

  void deleteAllData() {
    _prefs.setString(PreferencesEnum.firstName, '');
    _prefs.setString(PreferencesEnum.lastName, '');
    _prefs.setString(PreferencesEnum.userType, '');
    _prefs.setString(PreferencesEnum.gender, '');
    _prefs.setString(PreferencesEnum.birthDate, '');
    _prefs.setString(PreferencesEnum.email, '');
    _prefs.setString(PreferencesEnum.image, '');
    _prefs.setInt(PreferencesEnum.userId, 0);
    _prefs.setInt(PreferencesEnum.roomVolume, 0);
  }
}
