
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'screens/add_user/add_user/add_team_view.dart';
import 'screens/add_user/list_users/list_member_view.dart';
import 'screens/bottom_navigation.dart';
import 'screens/change_password/change_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/lead_screen/add_lead_screen/add_lead_screen.dart';
import 'screens/lead_screen/list_lead_screen.dart/list_lead_screen.dart';
import 'screens/lead_screen/update_lead_screen/update_screen.dart';
import 'screens/login screen/login_screen.dart';
import 'screens/page_sheets/add_page_sheet/add_page_sheet_screen.dart';
import 'screens/page_sheets/list_page_sheet/list_page_sheet_screen.dart';
import 'screens/splash_screen.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: LoginScreen),
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: BottomNavigationScreen),
    MaterialRoute(page: ChangePasswordScreen),
    MaterialRoute(page: LeadListScreen),
    MaterialRoute(page: AddLeadScreen),
    MaterialRoute(page: AddTeamMember),
    MaterialRoute(page: TeamMemberList),
    MaterialRoute(page: UpdateLeadScreen),
    MaterialRoute(page: ListPageSheetScreen),
    MaterialRoute(page: AddPageSheetScreen)
  ],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {
  // empty class, will be filled after code generation
}
 //flutter pub run build_runner build --delete-conflicting-outputs