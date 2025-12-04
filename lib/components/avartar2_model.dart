import '/flutter_flow/flutter_flow_util.dart';
import 'avartar2_widget.dart' show Avartar2Widget;
import 'package:flutter/material.dart';

class Avartar2Model extends FlutterFlowModel<Avartar2Widget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
