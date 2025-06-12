import 'package:fda/app/presentation/medicaldevice/cubit/medical_device_cubit.dart';
import 'package:fda/app/presentation/medicaldevice/service/medicaldeviceservice.dart';
import 'package:fda/app/presentation/medicaldevice/widgets/medicaldevicewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalDevicePage extends StatelessWidget {
  final String title;
  final String status;

  const MedicalDevicePage({
    required this.title,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              MedicalDeviceCubit(service: MedicalDeviceService())
                ..fetchDevicesByStatus(status),
      child: Scaffold(
        body: BlocBuilder<MedicalDeviceCubit, MedicalDeviceState>(
          builder: (context, state) {
            if (state is MedicalDeviceLoading) {
              return _buildGradientBackground(
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            } else if (state is MedicalDeviceError) {
              return _buildGradientBackground(
                child: Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else if (state is MedicalDeviceLoaded) {
              final devices = state.devices;

              return _buildGradientBackground(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Scroll ile kaybolabilen AppBar gibi başlık
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '$status Devices',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuButton<SortOrder>(
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            color: Colors.white,
                            onSelected: (SortOrder selected) {
                              context
                                  .read<MedicalDeviceCubit>()
                                  .sortDevicesByDate(selected);
                            },
                            itemBuilder:
                                (context) => const [
                                  PopupMenuItem<SortOrder>(
                                    value: SortOrder.descending,
                                    child: Text("Yeniden Eskiye"),
                                  ),
                                  PopupMenuItem<SortOrder>(
                                    value: SortOrder.ascending,
                                    child: Text("Eskiden Yeniye"),
                                  ),
                                ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ...devices
                          .map((device) => MedicalDeviceCard(device: device))
                          .toList(),
                    ],
                  ),
                ),
              );
            }

            return _buildGradientBackground(child: const SizedBox());
          },
        ),
      ),
    );
  }

  Widget _buildGradientBackground({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 25, 66, 100),
            Color.fromARGB(255, 106, 34, 119),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
