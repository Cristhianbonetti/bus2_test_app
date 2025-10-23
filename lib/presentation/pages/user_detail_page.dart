import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../cubits/user_detail/user_detail_cubit.dart';
import '../cubits/user_detail/user_detail_state.dart';

class UserDetailPage extends StatelessWidget {
  final UserEntity user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Initialize the cubit with the user
    context.read<UserDetailCubit>().loadUser(user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Usuário'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<UserDetailCubit, UserDetailState>(
        listener: (context, state) {
          if (state is UserDetailDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Usuário removido dos salvos')),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is UserDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserDetailError) {
            return Center(
              child: Text('Erro: ${state.message}'),
            );
          }

          if (state is UserDetailLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header com foto e nome
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(state.user.picture.large),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.user.name.fullName,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.user.email,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  // Informações pessoais
                  _buildSection(
                    context,
                    'Informações Pessoais',
                    [
                      _buildDetailRow('Gênero', state.user.gender),
                      _buildDetailRow('Idade', '${state.user.dob.age} anos'),
                      _buildDetailRow('Data de Nascimento', state.user.dob.date),
                      _buildDetailRow('Nacionalidade', state.user.nat),
                    ],
                  ),

                  // Localização
                  _buildSection(
                    context,
                    'Localização',
                    [
                      _buildDetailRow('Endereço', state.user.location.fullAddress),
                      _buildDetailRow('Coordenadas',
                          '${state.user.location.coordinates.latitude}, ${state.user.location.coordinates.longitude}'),
                      _buildDetailRow('Timezone',
                          '${state.user.location.timezone.offset} - ${state.user.location.timezone.description}'),
                    ],
                  ),

                  // Contato
                  _buildSection(
                    context,
                    'Contato',
                    [
                      _buildDetailRow('Telefone', state.user.phone),
                      _buildDetailRow('Celular', state.user.cell),
                      _buildDetailRow('Email', state.user.email),
                    ],
                  ),

                  // Login
                  _buildSection(
                    context,
                    'Informações de Login',
                    [
                      _buildDetailRow('UUID', state.user.login.uuid),
                      _buildDetailRow('Username', state.user.login.username),
                      _buildDetailRow('Password', state.user.login.password),
                    ],
                  ),

                  // Registro
                  _buildSection(
                    context,
                    'Registro',
                    [
                      _buildDetailRow('Data de Registro', state.user.registered.date),
                      _buildDetailRow('Tempo de Registro', '${state.user.registered.age} anos'),
                    ],
                  ),

                  // ID
                  if (state.user.id.name != null || state.user.id.value != null)
                    _buildSection(
                      context,
                      'Identificação',
                      [
                        if (state.user.id.name != null)
                          _buildDetailRow('Tipo', state.user.id.name!),
                        if (state.user.id.value != null)
                          _buildDetailRow('Valor', state.user.id.value!),
                      ],
                    ),

                  const SizedBox(height: 80),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomSheet: BlocBuilder<UserDetailCubit, UserDetailState>(
        builder: (context, state) {
          if (state is UserDetailLoaded) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<UserDetailCubit>().toggleSaveUser();
                },
                icon: Icon(
                  state.isSaved ? Icons.bookmark : Icons.bookmark_border,
                ),
                label: Text(
                  state.isSaved ? 'Remover dos Salvos' : 'Salvar Usuário',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.isSaved ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

