import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';

class UpgradePricingPage extends StatefulWidget {
  const UpgradePricingPage({super.key});

  @override
  State<UpgradePricingPage> createState() => _UpgradePricingPageState();
}

class _UpgradePricingPageState extends State<UpgradePricingPage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int selectedIndex = 0;
  bool isYearly = false;

  final List<_PricingPlan> plans = const [
    _PricingPlan(
      name: 'Basic',
      subtitle: 'Free forever',
      priceMonthly: 'Free',
      priceYearly: 'Free',
      features: [
        '1 Workspace',
        'Up to 10 members',
        '2 Teams',
        '2 Projects',
      ],
      isFree: true,
    ),
    _PricingPlan(
      name: 'Early Startup',
      subtitle: 'For new teams validating ideas',
      priceMonthly: '19',
      priceYearly: '190',
      features: [
        '5 Workspaces',
        'Up to 50 members',
        '10 Teams',
        'Unlimited Projects',
      ],
      isFree: false,
    ),
    _PricingPlan(
      name: 'Growth',
      subtitle: 'For scaling teams',
      priceMonthly: '49',
      priceYearly: '490',
      features: [
        'Unlimited Workspaces',
        'Unlimited members',
        'Unlimited Teams',
        'Priority Support',
      ],
      isFree: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade Plans'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Toggle for monthly/yearly
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Monthly',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: isYearly,
                onChanged: (val) => setState(() => isYearly = val),
                activeColor: colorScheme.surface,
                activeTrackColor: colorScheme.tertiary,
                inactiveThumbColor: colorScheme.secondary,
                inactiveTrackColor: colorScheme.secondary.withOpacity(0.6),
              ),
              Text(
                'Yearly',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Horizontal scrollable PageView with scaling
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: plans.length,
              onPageChanged: (index) {
                setState(() => selectedIndex = index);
              },
              itemBuilder: (context, index) {
                final plan = plans[index];
                final isSelected = index == selectedIndex;

                return AnimatedScale(
                  scale: isSelected ? 1.05 : 0.95,
                  duration: const Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? colorScheme.tertiary
                              : colorScheme.secondary,
                          width: 1,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: colorScheme.tertiary.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            plan.name,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: isSelected
                                  ? themeProvider.contrastColor
                                  : colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            plan.subtitle,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? themeProvider.contrastColor
                                      .withOpacity(0.85)
                                  : colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          if (isYearly && !plan.isFree) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: colorScheme.tertiary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(color: colorScheme.tertiary),
                              ),
                              child: Text(
                                'Save 2 months',
                                style: textTheme.labelMedium?.copyWith(
                                  color: isSelected
                                      ? themeProvider.contrastColor
                                      : colorScheme.tertiary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 16),
                          _buildPrice(plan, isSelected, colorScheme),
                          const SizedBox(height: 16),
                          Divider(
                            color: isSelected
                                ? themeProvider.contrastColor.withOpacity(0.2)
                                : colorScheme.secondary.withOpacity(0.4),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: plan.features.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: colorScheme.tertiary,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          plan.features[i],
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: isSelected
                                                ? themeProvider.contrastColor
                                                : colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.tertiary,
                              foregroundColor: colorScheme.surface,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: isSelected ? 4 : 1,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Selected plan: ${plan.name}'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: Text(
                              plan.isFree ? 'Get Started' : 'Choose Plan',
                              style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Smooth page indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: plans.length,
            effect: ExpandingDotsEffect(
              activeDotColor: colorScheme.tertiary,
              dotColor: colorScheme.secondary.withOpacity(0.6),
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 3,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPrice(
      _PricingPlan plan, bool isSelected, ColorScheme colorScheme) {
    // Use provider-driven contrast and accent for visibility
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final textColor = isSelected
        ? themeProvider.contrastColor
        : colorScheme.tertiary; // accent color when not selected

    if (plan.isFree) {
      return Text(
        'Free',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          color: textColor,
          letterSpacing: -0.5,
        ),
      );
    }

    final price = isYearly ? plan.priceYearly : plan.priceMonthly;
    final duration = isYearly ? '/year' : '/month';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$$price',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: textColor,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            duration,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? themeProvider.contrastColor.withOpacity(0.9)
                  : colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}

class _PricingPlan {
  final String name;
  final String subtitle;
  final String priceMonthly;
  final String priceYearly;
  final List<String> features;
  final bool isFree;

  const _PricingPlan({
    required this.name,
    required this.subtitle,
    required this.priceMonthly,
    required this.priceYearly,
    required this.features,
    required this.isFree,
  });
}
