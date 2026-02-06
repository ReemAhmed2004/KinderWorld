import 'package:kinder_world/core/network/network_service.dart';
import 'package:kinder_world/core/subscription/plan_info.dart';
import 'package:logger/logger.dart';

class SubscriptionService {
  final NetworkService _networkService;
  final Logger _logger;

  SubscriptionService({
    required NetworkService networkService,
    required Logger logger,
  })  : _networkService = networkService,
        _logger = logger;

  Future<bool> activateSubscription(PlanTier tier) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        '/subscription/select',
        data: {
          'plan_type': _planTypeForTier(tier),
        },
      );
      return response.data != null;
    } catch (e) {
      _logger.e('Error activating subscription: $e');
      return false;
    }
  }

  String _planTypeForTier(PlanTier tier) {
    switch (tier) {
      case PlanTier.familyPlus:
        return 'family_plus';
      case PlanTier.premium:
        return 'premium';
      case PlanTier.free:
        return 'free';
    }
  }
}
