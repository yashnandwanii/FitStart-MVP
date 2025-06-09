import 'package:fit_start/utils/utils.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices extends GetxService {
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() async {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseKey,
    );
    currentUser.value = client.auth.currentUser; 
    listenToAuthChange();
    super.onInit();
  }

  static final SupabaseClient client = Supabase.instance.client;

  // Listen to auth events
  void listenToAuthChange() {
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent authEvent = data.event;
      if (authEvent == AuthChangeEvent.userUpdated) {
        currentUser.value = data.session?.user;
      } else if(authEvent == AuthChangeEvent.signedIn) {
        currentUser.value = data.session?.user;
      } else if(authEvent == AuthChangeEvent.signedOut) {
        currentUser.value = null;
      }
    });
  }
}
