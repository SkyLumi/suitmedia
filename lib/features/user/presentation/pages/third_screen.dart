import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia/features/user/domain/entities/user.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_bloc.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_state.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_event.dart';
import 'package:suitmedia/features/user/presentation/widgets/user_list.dart';

class ThirdScreen extends StatefulWidget {
  final Function(UserEntity)? onUserSelected;

  const ThirdScreen({super.key, this.onUserSelected});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final currentState = context.read<RemoteUserBloc>().state;
      if (currentState is RemoteUserDone && 
          !currentState.hasReachedMax && 
          currentState.users!.isNotEmpty) {
        context.read<RemoteUserBloc>().add(
          GetUsers(page: currentState.currentPage + 1)
        );
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Third Screen',
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF553C9A),
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey[300],
          height: 1,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoteUserBloc, RemoteUserState>(
      builder: (context, state) {
        if (state is RemoteUserLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF554AF0),
            ),
          );
        } 
        else if (state is RemoteUserDone) {
          final users = state.users!;
          
          if (users.isEmpty) {
            return const Center(
              child: Text(
                'No users found',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RemoteUserBloc>().add(const GetUsers(page: 1, isRefresh: true));
            },
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: users.length,
              separatorBuilder: (context, index) => const Divider(
                height: 32,
                thickness: 1,
                color: Color(0xFFE2E3E4),
              ),
              itemBuilder: (context, index) {
                final user = users[index];
                return UserListItem(
                  firstName: user.firstName ?? '',
                  lastName: user.lastName ?? '',
                  email: user.email ?? '',
                  avatarUrl: user.avatar ?? '',
                  onTap: () {
                    if (widget.onUserSelected != null) {
                      widget.onUserSelected!(user);
                    }
                    Navigator.of(context).pop(user);
                  },
                );
              },
            ),
          );
        } 
        else if (state is RemoteUserException) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading users',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<RemoteUserBloc>().add(const GetUsers());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF553C9A),
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
