abstract class HomeLayoutStates{}

class HomeScreenInitialState extends HomeLayoutStates{}
class HomeScreenLoadingState extends HomeLayoutStates{}
class HomeScreenGetDataSuccessState extends HomeLayoutStates{}
class HomeScreenGetDataErrorState extends HomeLayoutStates{
   final String error;
  HomeScreenGetDataErrorState(this.error);

}