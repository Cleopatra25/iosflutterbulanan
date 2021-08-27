import 'dart:async';

class BlocCoupon {
  StreamController _inputcontroller = StreamController();
  StreamSink get sinkin => _inputcontroller.sink;

  StreamController _outputcontroller = StreamController();
  StreamSink get sinkout => _outputcontroller.sink;

  Stream get output => _outputcontroller.stream;

  BlocCoupon() {
    _inputcontroller.stream.listen((event) {
      sinkout.add(event);
    });
  }

  void dispose() {
    _inputcontroller.close();
    _outputcontroller.close();
  }
}
