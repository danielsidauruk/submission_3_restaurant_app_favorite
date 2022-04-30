import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3_restaurant_app/provider/scheduling_provider.dart';


class RestaurantSettingPage extends StatelessWidget {
  const RestaurantSettingPage({Key? key}) : super(key: key);
  static const routeName = '/setting_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings Page',
          ),
          backgroundColor: Colors.deepOrange,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _buildList(context));
  }

  _buildList(BuildContext context) {
    return Consumer<SchedulingProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text(
                  'Scheduling Restaurant',
                ),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isScheduled,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                        provider.enableDailyRestaurant(value);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
