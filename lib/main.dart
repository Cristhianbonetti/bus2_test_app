import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'presentation/cubits/saved_users/saved_users_cubit.dart';
import 'presentation/cubits/user_detail/user_detail_cubit.dart';
import 'presentation/cubits/user_list/user_list_cubit.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<UserListCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<UserDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<SavedUsersCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Random User App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
