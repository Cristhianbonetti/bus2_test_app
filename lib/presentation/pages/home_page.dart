import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/user_list/user_list_cubit.dart';
import '../cubits/user_list/user_list_state.dart';
import '../widgets/user_card.dart';
import 'saved_users_page.dart';
import 'user_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserListCubit>().startTicker();
    });
  }

  @override
  void dispose() {
    context.read<UserListCubit>().stopTicker();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários Aleatórios'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.storage),
            tooltip: 'Usuários Salvos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedUsersPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state is UserListInitial || state is UserListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar usuários',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserListCubit>().startTicker();
                    },
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          if (state is UserListLoaded) {
            if (state.users.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Carregando primeiro usuário...'),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: state.isTickerActive 
                      ? Colors.green[50] 
                      : Colors.grey[200],
                  child: Row(
                    children: [
                      Icon(
                        state.isTickerActive 
                            ? Icons.radio_button_checked 
                            : Icons.radio_button_unchecked,
                        color: state.isTickerActive 
                            ? Colors.green 
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        state.isTickerActive 
                            ? 'Ticker Ativo - Novo usuário a cada 5 segundos' 
                            : 'Ticker Pausado',
                        style: TextStyle(
                          color: state.isTickerActive 
                              ? Colors.green[700] 
                              : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return UserCard(
                        user: user,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailPage(user: user),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

