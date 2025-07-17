import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia/features/homepage/presentation/bloc/homepage_bloc.dart';
import 'package:suitmedia/features/homepage/presentation/bloc/homepage_event.dart';
import 'package:suitmedia/features/homepage/presentation/bloc/homepage_state.dart';
import 'package:suitmedia/features/user/presentation/pages/third_screen.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_bloc.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_event.dart';
import 'package:suitmedia/injection_container.dart';

class SecondScreen extends StatelessWidget {
  final String userName;

  const SecondScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageBloc()..add(LoadHomepage(userName)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Second Screen'
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF553C9A),
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey[300],
          height: 1,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        if (state is HomepageLoaded) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF04021D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  state.userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF04021D),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    state.selectedUser != null 
                        ? '${state.selectedUser!.firstName ?? ''} ${state.selectedUser!.lastName ?? ''}'.trim()
                        : 'Selected User Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF04021D)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => _navigateToThirdScreen(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B637B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Choose a User',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
        
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _navigateToThirdScreen(BuildContext context) async {
    final homepageBloc = context.read<HomepageBloc>();
    
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => sl<RemoteUserBloc>()..add(const GetUsers(page: 1, isRefresh: true)),
          child: ThirdScreen(
            onUserSelected: (user) {
              homepageBloc.add(SelectUser(user));
            },
          ),
        ),
      ),
    );
  }
}
