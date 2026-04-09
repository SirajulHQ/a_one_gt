import 'package:a_one_gt/core/service/api_service.dart';
import 'package:a_one_gt/features/help_and_support/model/help_and_support_model.dart';
import 'package:a_one_gt/features/help_and_support/viewmodel/help_and_support_viewmodel.dart';
import 'package:flutter/foundation.dart';

class HelpAndSupportController {
  final ApiService _apiService = ApiService();
  final HelpAndSupportViewModel _viewModel = HelpAndSupportViewModel();

  HelpAndSupportViewModel get viewModel => _viewModel;

  /// Get support options
  Future<void> getSupportOptions() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/support/options');

      if (response['success'] == true) {
        final List<dynamic> optionsData = response['data'] ?? [];
        final options = optionsData
            .map((json) => SupportOptionModel.fromJson(json))
            .toList();
        _viewModel.setSupportOptions(options);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to fetch support options',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HelpAndSupportController.getSupportOptions error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get FAQs
  Future<void> getFaqs() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/support/faqs');

      if (response['success'] == true) {
        final List<dynamic> faqsData = response['data'] ?? [];
        final faqs = faqsData.map((json) => FaqModel.fromJson(json)).toList();
        _viewModel.setFaqs(faqs);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch FAQs');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HelpAndSupportController.getFaqs error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get contact information
  Future<void> getContactInfo() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/support/contact');

      if (response['success'] == true) {
        final contactData = response['data'] ?? {};
        final contactInfo = ContactInfoModel.fromJson(contactData);
        _viewModel.setContactInfo(contactInfo);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to fetch contact info',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HelpAndSupportController.getContactInfo error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Submit support ticket
  Future<void> submitSupportTicket(SupportTicketModel ticket) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post(
        '/support/tickets',
        ticket.toJson(),
      );

      if (response['success'] == true) {
        _viewModel.setMessage('Support ticket submitted successfully');
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to submit support ticket',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HelpAndSupportController.submitSupportTicket error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Search FAQs
  Future<void> searchFaqs(String query) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/support/faqs/search?q=$query');

      if (response['success'] == true) {
        final List<dynamic> faqsData = response['data'] ?? [];
        final faqs = faqsData.map((json) => FaqModel.fromJson(json)).toList();
        _viewModel.setFaqs(faqs);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to search FAQs');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('HelpAndSupportController.searchFaqs error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Toggle FAQ expansion
  void toggleFaqExpansion(String faqId) {
    _viewModel.toggleFaqExpansion(faqId);
  }

  /// Clear error
  void clearError() {
    _viewModel.clearError();
  }

  /// Clear message
  void clearMessage() {
    _viewModel.clearMessage();
  }

  /// Dispose resources
  void dispose() {
    _viewModel.dispose();
  }
}
