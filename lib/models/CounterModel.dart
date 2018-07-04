import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model {

    int _count = 0;

    int get count => _count;

    void inc() {
        _count++;
        notifyListeners();
    }

    void dec() {
        _count--;
        notifyListeners();
    }

    void clear() {
        _count = 0;
        notifyListeners();
    }
}