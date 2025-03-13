import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/custom_card.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({Key? key}) : super(key: key);

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchMeals();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchMeals() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Meals',
          style: AppTextStyles.heading3.copyWith(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchMeals,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTextStyles.bodyMedium,
          tabs: const [
            Tab(text: 'Breakfast'),
            Tab(text: 'Lunch'),
            Tab(text: 'Dinner'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMealList('Breakfast'),
          _buildMealList('Lunch'),
          _buildMealList('Dinner'),
        ],
      ),
    );
  }

  Widget _buildMealList(String mealType) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          'Today\'s $mealType Menu',
          style: AppTextStyles.heading3,
        ),
        const SizedBox(height: 16),
        _buildMealCard(
          name: 'Vegetable Sandwich',
          description: 'Fresh vegetables with cheese in whole wheat bread',
          price: 50.0,
          isVeg: true,
          isAvailable: true,
        ),
        const SizedBox(height: 16),
        _buildMealCard(
          name: 'Chicken Sandwich',
          description: 'Grilled chicken with lettuce and mayo',
          price: 70.0,
          isVeg: false,
          isAvailable: true,
        ),
        const SizedBox(height: 16),
        _buildMealCard(
          name: 'Fruit Salad',
          description: 'Fresh seasonal fruits with honey',
          price: 60.0,
          isVeg: true,
          isAvailable: false,
        ),
      ],
    );
  }

  Widget _buildMealCard({
    required String name,
    required String description,
    required double price,
    required bool isVeg,
    required bool isAvailable,
  }) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isVeg ? AppColors.success : AppColors.accent,
                  ),
                  borderRadius: AppBorderRadius.sm,
                ),
                child: Icon(
                  isVeg ? Icons.circle : Icons.square,
                  color: isVeg ? AppColors.success : AppColors.accent,
                  size: 12,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isAvailable ? AppColors.text : AppColors.textLight,
                  ),
                ),
              ),
              Text(
                '₹$price',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isAvailable ? AppColors.primary : AppColors.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isAvailable ? 'Available' : 'Not Available',
                style: AppTextStyles.bodySmall.copyWith(
                  color: isAvailable ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton(
                onPressed: isAvailable ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.md,
                  ),
                ),
                child: const Text('Order'),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 