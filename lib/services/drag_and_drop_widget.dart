import 'package:flutter/material.dart';
import 'package:network_monitor/manager/cache/icache_manager.dart';
import 'package:network_monitor/models/device_model.dart';

class DragAndDropDevice extends StatefulWidget {
  final Widget child;
  final DeviceModel deviceInfo;
  final ICacheManager<DeviceModel> cacheManager;
  final int index;

  const DragAndDropDevice(
      {Key? key, required this.child, required this.deviceInfo,required this.cacheManager,required this.index})
      : super(key: key);

  @override
  _DragAreaStateStateful createState() => _DragAreaStateStateful();
}

class _DragAreaStateStateful extends State<DragAndDropDevice> {
  double prevScale = 1;
  double scale = 1;

  void updateScale(double zoom) => setState(() => scale = prevScale * zoom);
  void commitScale() => setState(() => prevScale = scale);
  void updatePosition(Offset newPosition) async{
    setState(() {
      widget.deviceInfo.offsetDx = newPosition.dx;
      widget.deviceInfo.offsetDy = newPosition.dy;
    });
    await widget.cacheManager.putItemIndex(widget.index, widget.deviceInfo);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (details) => updateScale(details.scale),
      onScaleEnd: (_) => commitScale(),
      child: Stack(
        children: [
          Positioned(
            left: widget.deviceInfo.offsetDx,
            top: widget.deviceInfo.offsetDy,
            child: Draggable(
              maxSimultaneousDrags: 1,
              feedback: widget.child,
              childWhenDragging: Opacity(
                opacity: .3,
                child: widget.child,
              ),
              onDragEnd: (details) => updatePosition(details.offset),
              child: Transform.scale(
                scale: scale,
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
