import 'package:project/LoginScreen/info.dart';
class Registerdata {
  static List<Info> z = [];
  static int getcount(){
    return z.length;
  }
  static void addInfo(String email, String password){
    z.add (Info(email: email, password: password));
  }
  static Info getdata(int index){
    return z[index];
  }
  static Info? getInfoByEmail(String email){
    for (int i=0; i<z.length; i++){
    if (z[i].email == email){
    return z[i];
  }
  }
  return null;
  }
  static void removeArtAt(int index){       
z.removeAt(index);  
}
static void removeInfoByEmail(String email) {
for (int i = 0; i < z.length; i++) {
if (z[i].email == email) {
z.removeAt(i);
}
}
}
}
