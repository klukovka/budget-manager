abstract class BaseInteractor<T, R> {

  Future<R> call(T argument);
}
