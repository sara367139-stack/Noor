import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:noorah/l10n/app_localizations.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  Future<bool?>? _deviceSupport;
  Future<LocationStatus>? _locationStatus;
  bool _isRequestingPermission = false;

  @override
  void initState() {
    super.initState();
    _refreshStatus();
  }

  @override
  void dispose() {
    FlutterQiblah().dispose();
    super.dispose();
  }

  Future<void> _refreshStatus() async {
    setState(() {
      _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
      _locationStatus = FlutterQiblah.checkLocationStatus();
    });
  }

  Future<void> _requestPermission() async {
    setState(() {
      _isRequestingPermission = true;
    });

    await FlutterQiblah.requestPermissions();
    setState(() {
      _locationStatus = FlutterQiblah.checkLocationStatus();
      _isRequestingPermission = false;
    });
  }

  Future<void> _openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<void> _openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  bool _isPermissionGranted(LocationStatus status) {
    return status.status == LocationPermission.always ||
        status.status == LocationPermission.whileInUse;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.qibla),
        centerTitle: true,
      ),
      body: FutureBuilder<bool?>(
        future: _deviceSupport,
        builder: (context, deviceSnapshot) {
          if (deviceSnapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (deviceSnapshot.hasError) {
            return _buildError(context, l10n.unableToCheckDeviceSupport);
          }

          if (deviceSnapshot.data == false) {
            return _buildMessage(
              context,
              title: l10n.compassNotSupported,
              message: l10n.deviceDoesNotSupportCompass,
            );
          }

          return FutureBuilder<LocationStatus>(
            future: _locationStatus,
            builder: (context, locationSnapshot) {
              if (locationSnapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              if (locationSnapshot.hasError || !locationSnapshot.hasData) {
                return _buildError(context, l10n.unableToGetLocationStatus);
              }

              final status = locationSnapshot.data!;

              if (!status.enabled) {
                return _buildStatusCard(
                  context,
                  title: l10n.locationServiceDisabled,
                  message: l10n.enableLocationServices,
                  primaryLabel: l10n.openLocationSettings,
                  onPrimaryPressed: _openLocationSettings,
                  secondaryLabel: l10n.refresh,
                  onSecondaryPressed: _refreshStatus,
                );
              }

              if (!_isPermissionGranted(status)) {
                final deniedForever =
                    status.status == LocationPermission.deniedForever;

                return _buildStatusCard(
                  context,
                  title: deniedForever
                      ? l10n.permissionDeniedForever
                      : l10n.locationPermissionRequired,
                  message: deniedForever
                      ? l10n.grantLocationPermission
                      : l10n.enableLocationServices,
                  primaryLabel: deniedForever ? l10n.openAppSettings : l10n.allowPermission,
                  onPrimaryPressed:
                      deniedForever ? _openAppSettings : _requestPermission,
                  secondaryLabel: l10n.refresh,
                  onSecondaryPressed: _refreshStatus,
                  isPrimaryLoading: _isRequestingPermission,
                );
              }

              return StreamBuilder<QiblahDirection>(
                stream: FlutterQiblah.qiblahStream,
                builder: (context, qiblahSnapshot) {
                  if (qiblahSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (qiblahSnapshot.hasError || !qiblahSnapshot.hasData) {
                    return _buildError(context, l10n.unableToReadCompassValues);
                  }

                  return _buildQiblaView(context, qiblahSnapshot.data!);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildQiblaView(BuildContext context, QiblahDirection direction) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.qiblaDirection,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 40),
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.explore,
                size: 260,
                color: Colors.grey.shade300,
              ),
              Transform.rotate(
                angle: (-direction.qiblah) * pi / 180,
                child: Icon(
                  Icons.navigation,
                  size: 140,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            '${direction.qiblah.toStringAsFixed(1)}°',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.pointYourPhoneTowardKaaba,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _refreshStatus,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    BuildContext context, {
    required String title,
    required String message,
    required String primaryLabel,
    required VoidCallback onPrimaryPressed,
    required String secondaryLabel,
    required VoidCallback onSecondaryPressed,
    bool isPrimaryLoading = false,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Card(
          margin: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: onSecondaryPressed,
                      child: Text(secondaryLabel),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: isPrimaryLoading ? null : onPrimaryPressed,
                      child: isPrimaryLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                color: Colors.white,
                              ),
                            )
                          : Text(primaryLabel),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            ElevatedButton(
              onPressed: _refreshStatus,
              child: Text(l10n.refresh),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}
