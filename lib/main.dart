import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'core/network/dio_client.dart';
import 'core/storage/secure_storage.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/leaderboard_remote_datasource.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'data/datasources/challenge_remote_datasource.dart';
import 'data/datasources/submission_remote_datasource.dart';
import 'data/datasources/admin_remote_datasource.dart';
import 'data/datasources/hints_remote_datasource.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/leaderboard_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/repositories/challenge_repository_impl.dart';
import 'data/repositories/submission_repository_impl.dart';
import 'data/repositories/admin_repository_impl.dart';

import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/get_challenges_usecase.dart';
import 'domain/usecases/get_leaderboard_usecase.dart';
import 'domain/usecases/get_me_usecase.dart';
import 'domain/usecases/get_user_stats_usecase.dart';
import 'domain/usecases/get_challenge_details_usecase.dart';
import 'domain/usecases/submit_flag_usecase.dart';

import 'domain/usecases/create_challenge_usecase.dart';
import 'domain/usecases/delete_challenge_usecase.dart';

import 'presentation/cubits/auth_cubit.dart';
import 'presentation/cubits/challenges_cubit.dart';
import 'presentation/cubits/leaderboard_cubit.dart';
import 'presentation/cubits/user_cubit.dart';
import 'presentation/cubits/challenge_details_cubit.dart';
import 'presentation/cubits/submission_cubit.dart';
import 'presentation/cubits/admin_cubit.dart';
import 'presentation/cubits/hints_cubit.dart';

import 'presentation/screens/login_screen.dart';

void main() {
  runApp(const CTFApp());
}

class CTFApp extends StatelessWidget {
  const CTFApp({super.key});

  @override
  Widget build(BuildContext context) {

    final dio = DioClient().dio;

    final authDatasource = AuthRemoteDatasource(dio);
    final authRepository = AuthRepositoryImpl(authDatasource);

    final loginUseCase = LoginUseCase(authRepository);
    final registerUseCase = RegisterUseCase(authRepository);

    final challengesDatasource = ChallengeRemoteDatasource(dio);
    final challengesRepository = ChallengeRepositoryImpl(challengesDatasource);

    final getChallengesUseCase = GetChallengesUseCase(challengesRepository);
    final getChallengeDetailsUseCase =
        GetChallengeDetailsUseCase(challengesRepository);

    final leaderboardDatasource = LeaderboardRemoteDatasource(dio);
    final leaderboardRepository =
        LeaderboardRepositoryImpl(leaderboardDatasource);

    final getLeaderboardUseCase =
        GetLeaderboardUseCase(leaderboardRepository);

    final userDatasource = UserRemoteDatasource(dio);
    final userRepository = UserRepositoryImpl(userDatasource);

    final getMeUseCase = GetMeUseCase(userRepository);
    final getUserStatsUseCase = GetUserStatsUseCase(userRepository);

    final submissionDatasource = SubmissionRemoteDatasource(dio);
    final submissionRepository =
        SubmissionRepositoryImpl(submissionDatasource);

    final submitFlagUseCase = SubmitFlagUseCase(submissionRepository);

    final adminDatasource = AdminRemoteDatasource(dio);
    final adminRepository = AdminRepositoryImpl(adminDatasource);

    final createChallengeUseCase =
        CreateChallengeUseCase(adminRepository);

    final deleteChallengeUseCase =
        DeleteChallengeUseCase(adminRepository);

    final hintsDatasource = HintsRemoteDatasource(dio);

    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => AuthCubit(
            loginUseCase,
            registerUseCase,
            SecureStorage(),
          ),
        ),

        BlocProvider(
          create: (_) => ChallengesCubit(
            getChallengesUseCase,
          ),
        ),

        BlocProvider(
          create: (_) => ChallengeDetailsCubit(
            getChallengeDetailsUseCase,
          ),
        ),

        BlocProvider(
          create: (_) => LeaderboardCubit(
            getLeaderboardUseCase,
          ),
        ),

        BlocProvider(
          create: (_) => UserCubit(
            getMeUseCase,
            getUserStatsUseCase,
          ),
        ),

        BlocProvider(
          create: (_) => SubmissionCubit(
            submitFlagUseCase,
          ),
        ),

        BlocProvider(
          create: (_) => HintsCubit(
            hintsDatasource,
          ),
        ),

        BlocProvider(
          create: (_) => AdminCubit(
            createChallengeUseCase,
            deleteChallengeUseCase,
          ),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CTF Platform",
        theme: AppTheme.darkTheme,
        home: LoginScreen(),
      ),
    );
  }
}