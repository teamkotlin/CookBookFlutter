import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadingScreen extends StatefulWidget {
  const DownloadingScreen({Key? key}) : super(key: key);

  @override
  State<DownloadingScreen> createState() => _DownloadingScreenState();
}

class _DownloadingScreenState extends State<DownloadingScreen> {
  late final List<DownloadController> _downloadControllers;

  void _openDownload(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Open App ${index + 1}'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _downloadControllers = List<DownloadController>.generate(
      20,
      (index) => SimulatedDownloadController(onOpenDownload: () {
        _openDownload(index);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apps')),
      body: ListView.separated(
        itemCount: _downloadControllers.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: _buildListItem,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final downloadController = _downloadControllers[index];

    return ListTile(
      leading: const DemoAppIcon(),
      title: Text(
        'App ${index + 1}',
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleLarge,
      ),
      subtitle: Text(
        'Lorem ipsum dolor #${index + 1}',
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall,
      ),
      trailing: SizedBox(
        width: 96,
        child: AnimatedBuilder(
          animation: downloadController,
          builder: (context, child) {
            return DownLoadButton(
              status: downloadController.downloadStatus,
              downloadProgress: downloadController.progress,
              onDownload: downloadController.startDownload,
              onCancel: downloadController.stopDownload,
              onOpen: downloadController.openDownload,
            );
          },
        ),
      ),
    );
  }
}

class DemoAppIcon extends StatelessWidget {
  const DemoAppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1,
      child: FittedBox(
        child: SizedBox(
          width: 80,
          height: 80,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum DownloadStatus { notDownloaded, fetchDownloading, downloading, downloaded }

class DownLoadButton extends StatelessWidget {
  final DownloadStatus status;
  final Duration duration;
  final double downloadProgress;
  final VoidCallback onDownload, onCancel, onOpen;

  const DownLoadButton(
      {Key? key,
      required this.status,
      this.duration = const Duration(milliseconds: 500),
      this.downloadProgress = 0,
      required this.onDownload,
      required this.onCancel,
      required this.onOpen})
      : super(key: key);

  bool get _isDownLoading => status == DownloadStatus.downloading;

  bool get _isFetching => status == DownloadStatus.fetchDownloading;

  bool get _isDownloaded => status == DownloadStatus.downloaded;

  void _onPressed() {
    switch (status) {
      case DownloadStatus.notDownloaded:
        onDownload();
        break;
      case DownloadStatus.fetchDownloading:
        break;
      case DownloadStatus.fetchDownloading:
        onCancel();
        break;
      case DownloadStatus.downloaded:
        onOpen();
        break;
      case DownloadStatus.downloading:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Stack(
        children: [
          ButtonShapeWidget(
            transitionDuration: duration,
            isDownloading: _isDownLoading,
            isFetching: _isFetching,
            isDownloaded: _isDownloaded,
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: duration,
              opacity: _isDownloaded || _isFetching ? 1 : 0,
              curve: Curves.ease,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ProgressIndicatorWidget(
                    downloadProgress: downloadProgress,
                    isDownloading: _isDownLoading,
                    isFetching: _isFetching,
                  ),
                  if (_isDownLoading)
                    Icon(
                      Icons.stop,
                      size: 14,
                      color: CupertinoColors.activeBlue,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonShapeWidget extends StatelessWidget {
  final Duration transitionDuration;
  final bool isDownloading, isFetching, isDownloaded;

  const ButtonShapeWidget(
      {Key? key,
      required this.transitionDuration,
      required this.isDownloading,
      required this.isFetching,
      required this.isDownloaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shape = const ShapeDecoration(
        shape: StadiumBorder(), color: CupertinoColors.lightBackgroundGray);
    if (isDownloading || isFetching) {
      shape = ShapeDecoration(
          shape: CircleBorder(), color: Colors.white.withOpacity(0));
    }
    return AnimatedContainer(
      duration: transitionDuration,
      decoration: shape,
      width: double.infinity,
      curve: Curves.ease,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: AnimatedOpacity(
          duration: transitionDuration,
          curve: Curves.ease,
          opacity: isDownloading || isFetching ? 0 : 1,
          child: Text(
            isDownloaded ? "OPEN" : "GET",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold, color: CupertinoColors.activeBlue),
          ),
        ),
      ),
    );
  }
}

class ProgressIndicatorWidget extends StatelessWidget {
  final double downloadProgress;
  final bool isDownloading, isFetching;

  const ProgressIndicatorWidget(
      {Key? key,
      required this.downloadProgress,
      required this.isDownloading,
      required this.isFetching})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: downloadProgress),
        duration: const Duration(milliseconds: 200),
        builder: (context, progress, child) {
          return CircularProgressIndicator(
            backgroundColor: isDownloading
                ? CupertinoColors.lightBackgroundGray
                : Colors.white.withOpacity(0),
            valueColor: AlwaysStoppedAnimation(isFetching
                ? CupertinoColors.lightBackgroundGray
                : CupertinoColors.activeBlue),
            strokeWidth: 2,
            value: isFetching ? null : progress,
          );
        },
      ),
    );
  }
}

abstract class DownloadController implements ChangeNotifier {
  DownloadStatus get downloadStatus;

  double get progress;

  void startDownload();

  void stopDownload();

  void openDownload();
}

class SimulatedDownloadController extends DownloadController
    with ChangeNotifier {
  SimulatedDownloadController(
      {DownloadStatus downloadStatus = DownloadStatus.notDownloaded,
      progress = 0.0,
      required VoidCallback onOpenDownload})
      : _progress = progress,
        _downloadStatus = downloadStatus,
        _onOpenDownload = onOpenDownload;
  DownloadStatus _downloadStatus;
  double _progress;
  VoidCallback _onOpenDownload;
  bool _isDownloading = false;

  @override
  DownloadStatus get downloadStatus => _downloadStatus;

  @override
  double get progress => _progress;

  @override
  void openDownload() {
    if (downloadStatus == DownloadStatus.downloaded) {
      _onOpenDownload();
    }
  }

  @override
  void startDownload() {
    if (_downloadStatus == DownloadStatus.notDownloaded) {
      _doSimulatedDownload();
    }
  }

  @override
  void stopDownload() {
    if (_isDownloading) {
      _isDownloading = false;
      _progress = 0;
      _downloadStatus = DownloadStatus.notDownloaded;
      notifyListeners();
    }
  }

  Future<void> _doSimulatedDownload() async {
    _isDownloading = true;
    _downloadStatus = DownloadStatus.fetchDownloading;
    notifyListeners();

    // Wait a second to simulate fetch time.
    await Future<void>.delayed(const Duration(seconds: 1));

    // If the user chose to cancel the download, stop the simulation.
    if (!_isDownloading) {
      return;
    }

    // Shift to the downloading phase.
    _downloadStatus = DownloadStatus.downloading;
    notifyListeners();

    const downloadProgressStops = [0.0, 0.15, 0.45, 0.8, 1.0];
    for (final stop in downloadProgressStops) {
      // Wait a second to simulate varying download speeds.
      await Future<void>.delayed(const Duration(seconds: 1));

      // If the user chose to cancel the download, stop the simulation.
      if (!_isDownloading) {
        return;
      }

      // Update the download progress.
      _progress = stop;
      notifyListeners();
    }

    // Wait a second to simulate a final delay.
    await Future<void>.delayed(const Duration(seconds: 1));

    // If the user chose to cancel the download, stop the simulation.
    if (!_isDownloading) {
      return;
    }

    // Shift to the downloaded state, completing the simulation.
    _downloadStatus = DownloadStatus.downloaded;
    _isDownloading = false;
    notifyListeners();
  }
}
