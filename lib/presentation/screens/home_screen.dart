import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:auto_route/auto_route.dart';
import '../cubit/food_log_cubit.dart';
import '../widgets/daily_tracker.dart';
import '../widgets/meal_list.dart';
import '../widgets/alert_message_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();
  Uint8List? _imageBytes;
  bool _isScanning = false;

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 600,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      var bytes = await pickedFile.readAsBytes();

      // Resize & compress image to reduce request size (helps avoid 429 / request-too-large)
      try {
        final decoded = img.decodeImage(bytes);
        if (decoded != null) {
          final resized = img.copyResize(decoded, width: 400);
          bytes = img.encodeJpg(resized, quality: 70);
        }
      } catch (_) {
        // ignore if compression fails, we'll still send original bytes
      }

      setState(() {
        _imageBytes = bytes;
      });
      scanImage(bytes);
    }
  }

  void scanImage(Uint8List imageBytes) async {
    if (_isScanning) {
      // Prevent triggering multiple scans in quick succession
      return;
    }

    _isScanning = true;
    setState(() {});

    // A small delay reduces the chance of hitting a burst rate limit
    final cubit = context.read<FoodLogCubit>();
    await Future.delayed(const Duration(milliseconds: 600));

    await cubit.addMealFromImage(imageBytes);

    if (!mounted) return;

    _isScanning = false;
    setState(() {});
  }

  void showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              getImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              getImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((FoodLogCubit cubit) => cubit.state.isLoading);
    final isBusy = isLoading || _isScanning;

    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(const AddMealFormRoute());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's trackers", style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 16),
                BlocBuilder<FoodLogCubit, FoodLogState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      // Tracker Section
                      DailyTracker(
                        calories: state.totalCalories,
                        protein: state.totalProtein,
                        carbs: state.totalCarbs,
                        fat: state.totalFat,
                      ),
                      SizedBox(height: 24),

                      // Preview selected image (web/mobile)
                      if (_imageBytes != null) ...[
                        Text('Selected Image', style: Theme.of(context).textTheme.titleMedium),
                        SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _imageBytes!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 24),
                      ],

                      // Inline Alert Section for Success or Error
                      if (state.successMessage != null || state.error != null)
                          AlertMessageWidget(
                            errorMessage: state.error,
                            successMessage: state.successMessage,
                            onClose: () => context.read<FoodLogCubit>().clearMessages(),
                          ),

                      // Meals Section
                      Text('Meals', style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(height: 16),
                      MealList(meals: state.meals),
                    ],
                  );
                },
              ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isBusy ? null : () => showImageSourceActionSheet(context),
        child: isBusy ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.add_a_photo),
      ),
    );
  }
}