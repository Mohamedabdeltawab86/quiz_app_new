import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app_new/data/models/path.dart';

part 'path_event.dart';
part 'path_state.dart';

class PathBloc extends Bloc<PathEvent, PathState> {
  // how paths will be loaded?
  // from firestore
  final List<Path> paths = [];


  PathBloc() : super(PathInitial()) {
    on<FetchPath>(_fetchPath);
    // on<CreatePath>(_createPath);
    // on<UpdatePath>(_updatePath);
    // on<DeletePath>(_deletePath);
    // on<SubscribePath>(_subscribeToPath);
  }
// create handlers
    void _fetchPath(FetchPath event, Emitter<PathState> emit) {
      emit(PathLoading());
      try {
        // loading path from firebase firestore


        emit(PathLoaded(paths));
      } catch (e) {
        emit(PathError(e.toString()));
      }
    }

    // TODO: implement event handler
    // TODO: 3. create path handlers and events.
  
}
