import 'package:a_one_gt/features/help_and_support/model/help_and_support_model.dart';
import 'package:flutter/foundation.dart';

class HelpAndSupportViewModel extends ChangeNotifier {
  List<SupportOptionModel> _supportOptions = [];
  List<FaqModel> _faqs = [];
  ContactInfoModel? _contactInfo;
  bool _isLoading = false;
  String? _error;
  String? _message;

  // Getters
  List<SupportOptionModel> get supportOptions => _supportOptions;
  List<FaqModel> get faqs => _faqs;
  ContactInfoModel? get contactInfo => _contactInfo;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get message => _message;

  // Setters
  void setSupportOptions(List<SupportOptionModel> options) {
    _supportOptions = options;
    notifyListeners();
  }

  void setFaqs(List<FaqModel> faqs) {
    _faqs = faqs;
    notifyListeners();
  }

  void setContactInfo(ContactInfoModel contactInfo) {
    _contactInfo = contactInfo;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  // Toggle FAQ expansion
  void toggleFaqExpansion(String faqId) {
    final index = _faqs.indexWhere((faq) => faq.id == faqId);
    if (index != -1) {
      _faqs[index] = _faqs[index].copyWith(
        isExpanded: !_faqs[index].isExpanded,
      );
      notifyListeners();
    }
  }

  // Filter FAQs by category
  List<FaqModel> getFaqsByCategory(String category) {
    return _faqs.where((faq) => faq.category == category).toList();
  }

  // Search FAQs
  List<FaqModel> searchFaqs(String query) {
    if (query.isEmpty) return _faqs;

    return _faqs
        .where(
          (faq) =>
              faq.question.toLowerCase().contains(query.toLowerCase()) ||
              faq.answer.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
