import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_hub_fronend/data/datasources/challenge_remote_datasource.dart';
import 'package:skill_hub_fronend/data/datasources/submission_remote_datasource.dart';
import 'package:skill_hub_fronend/data/repositories/challenge_repository_impl.dart';
import 'package:skill_hub_fronend/data/repositories/submission_repository_impl.dart';
import 'package:skill_hub_fronend/domain/usecases/submit_flag_usecase.dart';
import 'package:skill_hub_fronend/domain/usecases/get_user_stats_usecase.dart';
import 'package:skill_hub_fronend/presentation/cubits/submission_cubit.dart';

import 'core/theme/app_theme.dart';
import 'core/network/dio_client.dart';
import 'core/storage/secure_storage.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/leaderboard_remote_datasource.dart';
import 'data/datasources/user_remote_datasource.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/leaderboard_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';

import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/get_challenges_usecase.dart';
import 'domain/usecases/get_leaderboard_usecase.dart';
import 'domain/usecases/get_me_usecase.dart';
import 'domain/usecases/get_challenge_details_usecase.dart';

import 'presentation/cubits/auth_cubit.dart';
import 'presentation/cubits/challenges_cubit.dart';
import 'presentation/cubits/leaderboard_cubit.dart';
import 'presentation/cubits/user_cubit.dart';
import 'presentation/cubits/challenge_details_cubit.dart';

import 'presentation/screens/login_screen.dart';

void main() {
  runApp(const CTFApp());
}

class CTFApp extends StatelessWidget {
  const CTFApp({super.key});

  @override
  Widget build(BuildContext context) {

    final dio = DioClient().dio;

    /// AUTH
    final authDatasource = AuthRemoteDatasource(dio);
    final authRepository = AuthRepositoryImpl(authDatasource);

    final loginUseCase = LoginUseCase(authRepository);
    final registerUseCase = RegisterUseCase(authRepository);

    /// CHALLENGES
    final challengesDatasource = ChallengeRemoteDatasource(dio);
    final challengesRepository = ChallengeRepositoryImpl(challengesDatasource);

    final getChallengesUseCase = GetChallengesUseCase(challengesRepository);
    final getChallengeDetailsUseCase =
        GetChallengeDetailsUseCase(challengesRepository);

    /// LEADERBOARD
    final leaderboardDatasource = LeaderboardRemoteDatasource(dio);
    final leaderboardRepository =
        LeaderboardRepositoryImpl(leaderboardDatasource);

    final getLeaderboardUseCase =
        GetLeaderboardUseCase(leaderboardRepository);

    /// USER
    final userDatasource = UserRemoteDatasource(dio);
    final userRepository = UserRepositoryImpl(userDatasource);

    final getMeUseCase = GetMeUseCase(userRepository);
    final getUserStatsUseCase = GetUserStatsUseCase(userRepository);

    /// SUBMISSIONS
    final submissionDatasource = SubmissionRemoteDatasource(dio);
    final submissionRepository = SubmissionRepositoryImpl(submissionDatasource);
    final submitFlagUseCase = SubmitFlagUseCase(submissionRepository);

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