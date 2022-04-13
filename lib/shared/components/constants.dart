import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

bool? splash;
String? uId;

void signOut(context){
  CacheHelper.removeData(key: 'uId')!.then((value){
    if(value){
      navigateTo(context, LoginScreen());
    }
  }
  );
  print(uId);

}