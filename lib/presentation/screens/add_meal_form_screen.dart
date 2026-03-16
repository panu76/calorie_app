import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/food_item.dart';
import '../cubit/food_log_cubit.dart';

@RoutePage()
class AddMealFormScreen extends StatefulWidget {
  const AddMealFormScreen({super.key});

  @override
  State<AddMealFormScreen> createState() => _AddMealFormScreenState();
}

class _AddMealFormScreenState extends State<AddMealFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final cubit = context.read<FoodLogCubit>();
    final meal = FoodItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      calories: double.parse(_caloriesController.text.trim()),
      protein: 0,
      carbs: 0,
      fat: 0,
      quantity: 100,
      timestamp: DateTime.now(),
    );

    cubit.addMeal(meal).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Meal Manually')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Food name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a food name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _caloriesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Calories (kcal)'),
                validator: (value) {
                  final v = double.tryParse(value ?? '');
                  if (v == null || v <= 0) {
                    return 'Enter a valid calorie value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
