
import 'package:bodoni/core/theme/theme.dart';
import 'package:bodoni/features/venues/bloc/venue_bloc.dart';
import 'package:bodoni/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'core/app/app.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/checklist/presentation/bloc/checklist_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
  BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
  BlocProvider<ChecklistBloc>(create: (context) => di.sl<ChecklistBloc>()),
  BlocProvider<VenueBloc>(create: (context) => di.sl<VenueBloc>()),
     ],
      child: MaterialApp(
        title: 'Wedding Planner',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AppWrapper(),
      ),
    );
  }
}