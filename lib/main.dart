import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/planner_bloc_observer.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = PlannerBlocObserver();
  runApp(const PlannerApp());
}
