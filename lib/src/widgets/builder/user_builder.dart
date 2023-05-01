import 'package:flutter/material.dart';
import 'package:news_app/src/features/admin/dashboard/index.dart';
import 'package:news_app/src/features/admin/users/index.dart';
import 'package:news_app/src/services/user_services.dart';

import '../../model/user_model.dart';
import '../editor/select_user.dart';

class UsersBuilder extends StatefulWidget {
  final UserModel currentUser;
  final String pushTo;
  final Function(List<UserModel> userList, BuildContext pickerContext)? onPost;

  const UsersBuilder({
    super.key,
    required this.currentUser,
    required this.pushTo,
    this.onPost,
  });

  @override
  State<UsersBuilder> createState() => _UsersBuilderState();
}

class _UsersBuilderState extends State<UsersBuilder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<UserModel?> dataList = List.empty(growable: true);

  Future<void> _refreshData() async {
    try {
      // Call the asynchronous operation to fetch data
      final List<UserModel?> fetchedData = await UserServices().getAll();

      // Update the state with the fetched data and call setState to rebuild the UI
      setState(() {
        dataList = fetchedData;
      });

      // Trigger a refresh of the RefreshIndicator widget
      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Get All:  ${e.toString()}");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: FutureBuilder<List<UserModel?>>(
        future: UserServices().getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.data != null) {
            List<UserModel> userList =
                snapshot.data!.whereType<UserModel>().toList();

            userList.removeWhere((user) => user.role!.name == 'super_admin');

            if (widget.pushTo == 'AdminPanelUsers') {
              return AdminPanelUsers(
                userList: userList,
                currentUser: widget.currentUser,
                notifyRefresh: (refresh) {
                  _refreshData();
                },
              );
            } else if (widget.pushTo == 'UsersPicker') {
              return UsersPicker(
                userList: userList,
                onPost: (selectedUserList, pickerContext) {
                  widget.onPost!(selectedUserList, pickerContext);
                },
              );
            } else if (widget.pushTo == 'Dashboard') {
              return Dashboard(
                userList: userList,
                notifyRefresh: (refresh) {
                  _refreshData();
                },
              );
            }
          }

          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
